/*  inference_spatialvb.cc - implementation of VB with spatial priors

 Adrian Groves and Matthew Webster, FMRIB Image Analysis Group

 Copyright (C) 2007-2010 University of Oxford  */

/*  CCOPYRIGHT */

#include "inference_myvb.h"

#include "priors.h"
#include "run_context.h"
#include "convergence.h"
#include "easylog.h"
#include "tools.h"
#include "version.h"

#include <miscmaths/miscmaths.h>
#include <newmatio.h>

#include <math.h>

using MISCMATHS::sign;

static OptionSpec OPTIONS[] = {
    { "noise", OPT_STR, "Noise model to use (white or ar1)", OPT_REQ, "" },
    { "convergence", OPT_STR, "Name of method for detecting convergence", OPT_NONREQ, "maxits" },
    { "max-iterations", OPT_STR, "number of iterations of VB to use with the maxits convergence detector",
        OPT_NONREQ, "10" },
    { "min-fchange", OPT_STR, "When using the fchange convergence detector, the change in F to stop at", OPT_NONREQ,
        "10" },
    { "max-trials", OPT_STR,
        "When using the trial mode convergence detector, the maximum number of trials after an initial reduction in F",
        OPT_NONREQ, "10" },
    { "print-free-energy", OPT_BOOL, "Output the free energy", OPT_NONREQ, "" },
    { "mcsteps", OPT_INT, "Number of motion correction steps", OPT_NONREQ, "0" },
    { "continue-from-mvn", OPT_MVN, "Continue previous run from output MVN files", OPT_NONREQ, "" },
    { "output-only", OPT_BOOL,
        "Skip model fitting, just output requested data based on supplied MVN. Can only be used with continue-from-mvn",
        OPT_NONREQ, "" },
    { "noise-initial-prior", OPT_MATRIX, "MVN of initial noise prior", OPT_NONREQ, "" },
    { "noise-initial-posterior", OPT_MATRIX, "MVN of initial noise posterior", OPT_NONREQ, "" },
    { "noise-pattern", OPT_STR,
        "repeating pattern of noise variances for each point (e.g. 12 gives odd and even data points different variances)",
        OPT_NONREQ, "1" },
    { "PSP_byname<n>", OPT_STR, "Name of model parameter to use image prior", OPT_NONREQ, "" },
    { "PSP_byname<n>_type", OPT_STR, "Type of image prior to use for parameter <n> - I=image prior",
        OPT_NONREQ, "" },
    { "PSP_byname<n>_image", OPT_IMAGE, "Image prior for parameter <n>", OPT_NONREQ, "" },
    { "PSP_byname<n>_prec", OPT_FLOAT, "Precision to apply to image prior for parameter <n>", OPT_NONREQ, "" },
    { "allow-bad-voxels", OPT_BOOL, "Continue if numerical error found in a voxel, rather than stopping",
        OPT_NONREQ, "" },
    { "ar1-cross-terms", OPT_STR, "For AR1 noise, type of cross-linking (dual, same or none)", OPT_NONREQ,
        "dual" },
    { "spatial-dims", OPT_INT, "Number of spatial dimensions", OPT_NONREQ, "3" },
    { "spatial-speed", OPT_STR, "Restrict speed of spatial smoothing", OPT_NONREQ,
        "-1" },
    { "distance-measure", OPT_STR, "", OPT_NONREQ, "dist1" },
    { "param-spatial-priors", OPT_STR,
        "Type of spatial priors for each parameter, as a sequence of characters. "
        "N=nonspatial, M=Markov random field, P=Penny, A=ARD",
        OPT_NONREQ, "N+" },
    { "update-spatial-prior-on-first-iteration", OPT_BOOL, "", OPT_NONREQ, "" },
    { "locked-linear-from-mvn", OPT_MVN, "MVN file containing fixed centres for linearization", OPT_NONREQ,
        "" },
    { "" },
};

void Vb::GetOptions(vector<OptionSpec> &opts) const
{
    InferenceTechnique::GetOptions(opts);

    for (int i = 0; OPTIONS[i].name != ""; i++)
    {
        opts.push_back(OPTIONS[i]);
    }
}

string Vb::GetDescription() const
{
    return "Variational Bayes inference technique";
}

string Vb::GetVersion() const
{
    return fabber_version();
}

InferenceTechnique *Vb::NewInstance()
{
    return new Vb();
}

void Vb::Initialize(FwdModel *fwd_model, FabberRunData &args)
{
    InferenceTechnique::Initialize(fwd_model, args);

    // Get noise model.
    m_noise = std::auto_ptr<NoiseModel>(NoiseModel::NewFromName(args.GetString("noise")));
    m_noise->Initialize(args);
    m_noise_params = m_noise->NumParams();
    LOG << "Vb::Noise has " << m_noise_params << " parameters" << endl;

    // If we are resuming from a previous run, there will be a file containing a per-voxel
    // distribution of the model parameters, and possibly the noise as well. So we may
    // not need the initial posterior distributions we have created. We choose not to delete
    // them here as the memory involved is not large (they are not per voxel).
    m_continueFromFile = args.GetStringDefault("continue-from-mvn", "");
    paramFilename = args.GetStringDefault("continue-from-params", ""); // optional list of parameters in MVN

    // Create convergence-testing method:
    m_conv = ConvergenceDetector::NewFromName(args.GetStringDefault("convergence", "maxits"));
    m_conv->Initialize(args);

    // Figure out if F needs to be calculated every iteration
    m_printF = args.GetBool("print-free-energy");
    m_needF = m_conv->UseF() || m_printF;

    // Motion correction related setup - by default no motion correction
    m_num_mcsteps = convertTo<int>(args.GetStringDefault("mcsteps", "0"));

    m_spatial_dims = args.GetIntDefault("spatial-dims", 3, 0, 3);
    if (m_spatial_dims == 1)
    {
        WARN_ONCE("spatial-dims=1 is weird... hope you're just testing!");
    }
    else if (m_spatial_dims == 2)
    {
        WARN_ONCE("spatial-dims=2 may not work the way you expect");
    }

    // Locked linearizations, if requested
    m_locked_linear_file = args.GetStringDefault("locked-linear-from-mvn", "");
    m_locked_linear = (m_locked_linear_file != "");
}

void Vb::InitializeNoiseFromParam(FabberRunData &args, NoiseParams *dist,
    string param_key)
{
    string filename = args.GetStringDefault(param_key, "modeldefault");
    if (filename != "modeldefault")
    {
        // FIXME should there be checking of size here
        LOG << "VbInferenceTechnique::Loading " << param_key << " distribution from " << filename << endl;
        dist->InputFromMVN(MVNDist(filename, m_log));
    }
}

void Vb::SetupPerVoxelDists(FabberRunData &rundata)
{
    // Initialized in voxel loop below (from file or default as required)
    m_ctx->noise_post.resize(m_nvoxels, NULL);
    m_ctx->noise_prior.resize(m_nvoxels, NULL);
    m_ctx->fwd_post.resize(m_nvoxels);

    // Re-centred in voxel loop below
    m_lin_model.resize(m_nvoxels, LinearizedFwdModel(m_model));

    // Model prior is updated during main voxel loop
    m_ctx->fwd_prior.resize(m_nvoxels, MVNDist(m_num_params, m_log));

    // Loaded from file if required, otherwise initialized during calculation
    resultMVNs.resize(m_nvoxels, NULL);

    // Initialized during calculation
    resultFs.resize(m_nvoxels, 9999); // 9999 is a garbage default value

    // Whether to fix the linearization centres (default: false)
    vector<MVNDist *> lockedLinearDists;
    Matrix lockedLinearCentres;
    if (m_locked_linear)
    {
        LOG << "Vb::Loading fixed linearization centres from the MVN '"
            << m_locked_linear_file << "'\nNOTE: This does not check if the correct "
                                   "number of parameters is present!\n";
        MVNDist::Load(lockedLinearDists, m_locked_linear_file, rundata, m_log);
        lockedLinearCentres.ReSize(m_num_params, m_nvoxels);
    }

    if (m_continueFromFile != "")
    {
        LOG << "Vb::Continuing from file "
            << m_continueFromFile << endl;
        InitMVNFromFile(m_continueFromFile, rundata, paramFilename);
    }

    // Initial noise distributions
    NoiseParams *initialNoisePrior = m_noise->NewParams();
    NoiseParams *initialNoisePosterior = m_noise->NewParams();
    m_noise->HardcodedInitialDists(*initialNoisePrior, *initialNoisePosterior);
    InitializeNoiseFromParam(rundata, initialNoisePrior, "noise-initial-prior");
    InitializeNoiseFromParam(rundata, initialNoisePosterior, "noise-initial-posterior");

    for (int v = 1; v <= m_nvoxels; v++)
    {
        if (m_continueFromFile != "")
        {
            m_ctx->fwd_post[v - 1] = resultMVNs.at(v - 1)->GetSubmatrix(1, m_num_params);
            assert(m_num_params + m_noise_params == resultMVNs.at(v - 1)->GetSize());
            m_ctx->noise_post[v - 1] = m_noise->NewParams();
            m_ctx->noise_post[v - 1]->InputFromMVN(resultMVNs.at(v - 1)->GetSubmatrix(
                m_num_params + 1, m_num_params + m_noise_params));
        }
        else
        {
            // Set the initial posterior for model params. Model
            // may want the voxel data in order to do this
            PassModelData(v);
            m_model->GetInitialPosterior(m_ctx->fwd_post[v - 1]);
            // Set initial noise posterior
            m_ctx->noise_post[v - 1] = initialNoisePosterior->Clone();
        }

        if (m_locked_linear)
        {
            lockedLinearCentres.Column(v) = lockedLinearDists.at(v - 1)->means.Rows(1, m_num_params);
            m_lin_model[v - 1].ReCentre(lockedLinearCentres.Column(v));
        }
        else
        {
            //LOG  << "Initial re-centering: " << m_ctx->fwd_post[v - 1].means.t() << endl;
            m_lin_model[v - 1].ReCentre(m_ctx->fwd_post[v - 1].means);
        }

        m_ctx->noise_prior[v - 1] = initialNoisePrior->Clone();
        m_noise->Precalculate(*m_ctx->noise_post[v - 1], *m_ctx->noise_prior[v - 1],
            m_origdata->Column(v));
    }
}

void Vb::PassModelData(int v)
{
    // Pass in data, coords and supplemental data for this voxel
    ColumnVector y = m_origdata->Column(v);
    ColumnVector vcoords = m_coords->Column(v);
    if (m_suppdata->Ncols() > 0)
    {
        ColumnVector suppy = m_suppdata->Column(v);
        m_model->PassData(y, vcoords, suppy);
    }
    else
    {
        m_model->PassData(y, vcoords);
    }
}

void Vb::IgnoreVoxel(int v) 
{
    LOG << "Vb::IgnoreVoxel This voxel will be ignored in further updates" << endl;
    
    m_ignore_voxels.push_back(v);
    
    // Remove voxel from lists of neighbours of other voxels.
    // We identify affected voxels by looking in the neighbour
    // lists for the bad voxel, because any voxel which has 
    // the bad voxel as a neighbour will be a neighbour of the
    // bad voxel
    vector<int> nn = m_ctx->neighbours[v-1];
    for (vector<int>::iterator i=nn.begin(); i!=nn.end(); ++i) {
        // Reference to list of neighbours of some other voxel which
        // has the bad voxel as a neighbour
        vector<int> &n2 = m_ctx->neighbours[*i-1];

        n2.erase(std::remove(n2.begin(), n2.end(), v), n2.end());
    }

    // Same for next-nearest-neighbours
    nn = m_ctx->neighbours2[v-1];
    for (vector<int>::iterator i=nn.begin(); i!=nn.end(); ++i) {
        // Reference to list of neighbours of some other voxel which
        // has the bad voxel as a neighbour
        vector<int> &n2 = m_ctx->neighbours2[*i-1];

        n2.erase(std::remove(n2.begin(), n2.end(), v), n2.end());
    }
}

/**
 * Calculate free energy. Note that this is currently unused in spatial VB
 */
double Vb::CalculateF(int v, string label, double Fprior)
{
    double F = 1234.5678;
    if (m_needF)
    {
        F = m_noise->CalcFreeEnergy(*m_ctx->noise_post[v - 1], *m_ctx->noise_prior[v - 1],
                    m_ctx->fwd_post[v - 1], m_ctx->fwd_prior[v - 1],
                    m_lin_model[v - 1], m_origdata->Column(v));
        F += Fprior;
        resultFs[v-1] = F;
        if (m_printF)
        {
            LOG << "Vb::F" << label << " = " << F << endl;
        }
    }
    return F;
}

void Vb::DoCalculations(FabberRunData &rundata)
{    
    // extract data (and the coords) from rundata for the (first) VB run
    // Rows are volumes
    // Columns are (time) series
    // num Rows is size of (time) series
    // num Cols is size of volumes
    m_origdata = &rundata.GetMainVoxelData();
    m_coords = &rundata.GetVoxelCoords();
    m_suppdata = &rundata.GetVoxelSuppData();
    m_nvoxels = m_origdata->Ncols();
    m_ctx = new RunContext(m_nvoxels);

    // pass in some (dummy) data/coords here just in case the model relies upon it
    // use the first voxel values as our dummies FIXME this shouldn't really be
    // necessary, need to find way for model to know about the data beforehand.
    if (m_nvoxels > 0)
        PassModelData(1);

    // Only call DoCalculations once
    assert(resultMVNs.empty());
    assert(resultFs.empty());

    SetupPerVoxelDists(rundata);
    
    if (rundata.GetBool("output-only"))
    {
        // Do no calculations - now we have set resultMVNs we can finish
        LOG << "Vb::DoCalculations output-only set - not performing any calculations" << endl;
    }
    else if (rundata.GetString("method") == "vb") {
        DoCalculationsVoxelwise(rundata);
    }
    else {
        DoCalculationsSpatial(rundata);        
    }

    if (!m_needF)
    {
        // clearing resultFs here should prevent an F image from being saved.
        resultFs.clear();
    }

    // Delete stuff (avoid memory leaks)
    for (int v = 1; v <= m_nvoxels; v++)
    {
        delete m_ctx->noise_post[v - 1];
        delete m_ctx->noise_prior[v - 1];
    }
}

void Vb::DoCalculationsVoxelwise(FabberRunData &rundata)
{
    vector<Parameter> params;
    m_model->GetParameters(rundata, params);
    vector<Prior *> priors = PriorFactory(rundata).CreatePriors(params);

    m_conv->Reset();
    
    // Loop over voxels
    for (int v = 1; v <= m_nvoxels; v++)
    {
        PassModelData(v);

        m_ctx->v = v;
        m_ctx->it = 0; 

        // Save our model parameters in case we need to revert later.
        // Note need to save prior in case ARD is being used
        NoiseParams *const noisePosteriorSave = m_ctx->noise_post[v - 1]->Clone();
        MVNDist fwdPosteriorSave(m_ctx->fwd_post[v - 1]);
        MVNDist fwdPriorSave(m_ctx->fwd_prior[v - 1]);

        // Give an indication of the progress through the voxels;
        rundata.Progress(v, m_nvoxels);
        double F = 1234.5678;

        try
        {
            m_lin_model[v-1].ReCentre(m_ctx->fwd_post[v - 1].means);
            m_conv->Reset();

            // START the VB updates and run through the relevant iterations (according to the convergence testing)
            do
            {
                double Fprior = 0;
                
                if (m_conv->NeedRevert()) //revert to previous solution if the convergence detector calls for it
                {
                    *m_ctx->noise_post[v - 1] = *noisePosteriorSave;
                    m_ctx->fwd_post[v - 1] = fwdPosteriorSave;
                    m_ctx->fwd_prior[v-1] = fwdPriorSave;
                    m_lin_model[v-1].ReCentre(m_ctx->fwd_post[v - 1].means);
                }

                // Save old values if called for
                if (m_conv->NeedSave())
                {
                    *noisePosteriorSave = *m_ctx->noise_post[v - 1]; // copy values, not pointer!
                    fwdPosteriorSave = m_ctx->fwd_post[v - 1];
                    fwdPriorSave = m_ctx->fwd_prior[v-1];
                }
                
                for (int k=0; k<m_num_params; k++) {
                    Fprior += priors[k]->ApplyToMVN(&m_ctx->fwd_prior[v-1], *m_ctx);
                }

                F = CalculateF(v, "before", Fprior);

                m_noise->UpdateTheta(*m_ctx->noise_post[v - 1], m_ctx->fwd_post[v - 1], m_ctx->fwd_prior[v-1], m_lin_model[v-1], m_origdata->Column(v), NULL,
                    m_conv->LMalpha());

                F = CalculateF(v, "theta", Fprior);

                m_noise->UpdateNoise(*m_ctx->noise_post[v - 1], *m_ctx->noise_prior[v - 1], m_ctx->fwd_post[v - 1], m_lin_model[v-1], m_origdata->Column(v));
                
                F = CalculateF(v, "phi", Fprior);
                
                // Linearization update
                // Update the linear model before doing Free energy calculation 
                // (and ready for next round of theta and phi updates)
                m_lin_model[v-1].ReCentre(m_ctx->fwd_post[v - 1].means);

                F = CalculateF(v, "lin", Fprior);
                
                ++m_ctx->it;
            } while (!m_conv->Test(F));

            // Revert to old values at last stage if required
            if (m_conv->NeedRevert())
            {
                *m_ctx->noise_post[v - 1] = *noisePosteriorSave;
                m_ctx->fwd_post[v - 1] = fwdPosteriorSave;
                m_ctx->fwd_prior[v-1] = fwdPriorSave;
                m_lin_model[v-1].ReCentre(m_ctx->fwd_post[v - 1].means);
            }
        }
        catch (FabberInternalError &e) {
            LOG << "Vb::Internal error for voxel " <<  v 
                << " at " << m_coords->Column(v).t() << " : " << e.what() << endl;
            
            if (m_halt_bad_voxel) throw;
            else IgnoreVoxel(v);
        }
        catch (NEWMAT::Exception &e) {

            LOG << "Vb::NEWMAT exception for voxel " <<  v 
                << " at " << m_coords->Column(v).t() << " : " << e.what() << endl;
            
            if (m_halt_bad_voxel) throw;
            else IgnoreVoxel(v);
        }

        // now write the results to resultMVNs
        try
        {
            resultMVNs.at(v - 1) = new MVNDist(m_ctx->fwd_post[v-1], m_ctx->noise_post[v-1]->OutputAsMVN());
            if (m_needF)
            {
                resultFs.at(v - 1) = F;
            }
        }
        catch (...)
        {
            // Even that can fail, due to results being singular
            LOG
                << "Vb::Can't give any sensible answer for this voxel; outputting zero +- identity\n";
            MVNDist *tmp = new MVNDist(m_log);
            tmp->SetSize(m_ctx->fwd_post[v-1].means.Nrows() + m_ctx->noise_post[v-1]->OutputAsMVN().means.Nrows());
            tmp->SetCovariance(IdentityMatrix(tmp->means.Nrows()));
            resultMVNs.at(v - 1) = tmp;

            if (m_needF)
                resultFs.at(v - 1) = F;
        }
    }
}

void Vb::DoCalculationsSpatial(FabberRunData &rundata)
{
   int maxits = convertTo<int>(rundata.GetStringDefault("max-iterations", "10"));

    // pass in some (dummy) data/coords here just in case the model relies upon it
    // use the first voxel values as our dummies FIXME this shouldn't really be
    // necessary, need to find way for model to know about the data beforehand.
    if (m_nvoxels > 0)
        PassModelData(1);

    // Make the neighbours[] lists if required
    //if (m_prior_types_str.find_first_of("mMpP") != string::npos)
    if (true) // FIXME
    {
        CalcNeighbours(*m_coords);
    }

    vector<Parameter> params;
    m_model->GetParameters(rundata, params);
    vector<Prior *> priors = PriorFactory(rundata).CreatePriors(params);
    
    m_conv->Reset();
    
    double Fglobal=1234.5678;

    // MAIN ITERATION LOOP
    do
    {
        LOG << endl << "*** Spatial iteration *** " << (m_ctx->it+1) << endl;

        // Give an indication of the progress through the voxels;
        rundata.Progress(m_ctx->it, maxits);
        double Fprior=0;

        // ITERATE OVER VOXELS
        for (int v = 1; v <= m_nvoxels; v++)
        {
            m_ctx->v = v;

            PassModelData(v);

            // The steps below are essentially the same as regular VB, although
            // the code looks different as the per-voxel dists are set up at the
            // start rather than as we go
            try {
                Fprior=0;

                // Apply prior updates for spatial or ARD priors
                for (int k=0; k<m_num_params; k++) {
                    Fprior += priors[k]->ApplyToMVN(&m_ctx->fwd_prior[v-1], *m_ctx);
                }
                if (m_debug) {
                    LOG << "Voxel " << v << " of " << m_nvoxels << endl;
                    LOG << "Prior means: " << m_ctx->fwd_prior[v-1].means.t();
                    LOG << "Prior precisions: " << m_ctx->fwd_prior[v-1].GetPrecisions();
                    LOG << "Noise prior means: " << m_ctx->noise_prior[v-1]->OutputAsMVN().means.t();
                    LOG << "Noise prior precisions: " << m_ctx->noise_prior[v-1]->OutputAsMVN().GetPrecisions();
                    LOG << "Centre: " << m_lin_model[v-1].Centre();
                    LOG << "Offset: " << m_lin_model[v-1].Offset();
                    LOG << "Jacobian: " << m_lin_model[v-1].Jacobian();
                }

                // Ignore voxels where numerical issues have occurred
                if (std::find(m_ignore_voxels.begin(), m_ignore_voxels.end(), v) != m_ignore_voxels.end()) continue;

                CalculateF(v, "before", Fprior);

                m_noise->UpdateTheta(*m_ctx->noise_post[v - 1], m_ctx->fwd_post[v - 1],
                    m_ctx->fwd_prior[v - 1], m_lin_model[v - 1],
                    m_origdata->Column(v), NULL, 0);
                if (m_debug) {
                    LOG << "Post means: " << m_ctx->fwd_post[v-1].means.t();
                    LOG << "Post precisions: " << m_ctx->fwd_post[v-1].GetPrecisions();
                }
                CalculateF(v, "theta", Fprior);
            }
            catch (FabberInternalError &e) {
                LOG << "Vb::Internal error for voxel " <<  v 
                    << " at " << m_coords->Column(v).t() << " : " << e.what() << endl;
                
                if (m_halt_bad_voxel) throw;
                else IgnoreVoxel(v);
            }
            catch (NEWMAT::Exception &e) {

                LOG << "Vb::NEWMAT exception for voxel " <<  v 
                    << " at " << m_coords->Column(v).t() << " : " << e.what() << endl;
                
                if (m_halt_bad_voxel) throw;
                else IgnoreVoxel(v);
            }
        }

        Fglobal=0;
        for (int v = 1; v <= m_nvoxels; v++) 
        {
            PassModelData(v);

            m_noise->UpdateNoise(*m_ctx->noise_post[v - 1], *m_ctx->noise_prior[v - 1],
                m_ctx->fwd_post[v - 1], m_lin_model[v - 1],
                m_origdata->Column(v));

            CalculateF(v, "noise", Fprior);

            if (!m_locked_linear)
                m_lin_model[v - 1].ReCentre(m_ctx->fwd_post[v - 1].means);

            Fglobal += CalculateF(v, "lin", Fprior);
        }

        ++m_ctx->it;
    } while (!m_conv->Test(Fglobal));

    // Interesting addition: calculate "coefficient resels" from Penny et al. 2005
    for (int k = 1; k <= m_num_params; k++)
    {
        ColumnVector gamma_vk(m_nvoxels);
        for (int v = 1; v <= m_nvoxels; v++)
        {
            gamma_vk(v) = 1 - m_ctx->fwd_post[v - 1].GetCovariance()(k, k) / m_ctx->fwd_prior[v - 1].GetCovariance()(k, k);
        }
        LOG << "Vb::Coefficient resels per voxel for param "
            << k << ": " << gamma_vk.Sum() / m_nvoxels << endl;
    }

    for (int v = 1; v <= m_nvoxels; v++)
    {
        resultMVNs[v - 1] = new MVNDist(m_ctx->fwd_post[v - 1], m_ctx->noise_post[v - 1]->OutputAsMVN());
    }
}

void Vb::CheckCoordMatrixCorrectlyOrdered(const Matrix &coords)
{
    // Only 3D
    assert(coords.Nrows() == 3);

    // Voxels are stored one per column, each column is the x/y/z coords
    const int m_nvoxels = coords.Ncols();

    // Go through each voxel one at a time apart from last
    for (int v = 1; v <= m_nvoxels - 1; v++)
    {
        // Find difference between current coords and next
        ColumnVector diff = coords.Column(v + 1) - coords.Column(v);

        // Check order
        // +1 = +x, +10 = +y, +100 = +z, -100 = -z+x, etc.
        int d = sign(diff(1)) + 10 * sign(diff(2)) + 100 * sign(diff(3));
        if (d <= 0)
        {
            LOG << "Vb::Found mis-ordered voxels " << v << " and " << v + 1 << ": d=" << d << endl;
            throw FabberInternalError("Coordinate matrix must be in correct order to use adjacency-based priors.");
        }
    }
}

// Binary search for data(index) == num
// Assumes data is sorted ascending!!
// Either returns an index such that data(index) == num
//   or -1 if num is not present in data.
static inline int binarySearch(const ColumnVector &data, int num)
{
    int first = 1, last = data.Nrows();

    while (first <= last)
    {
        int test = (first + last) / 2;

        if (data(test) < num)
        {
            first = test + 1;
        }
        else if (data(test) > num)
        {
            last = test - 1;
        }
        else if (data(test) == num)
        {
            return test;
        }
        else
        {
            assert(false); // logic error!  data wasn't sorted?
        }
    }
    return -1;
}

/**
 * Calculate nearest and second-nearest neighbours for the voxels
 */
void Vb::CalcNeighbours(const Matrix &coords)
{
    const int nVoxels = coords.Ncols();
    if (nVoxels == 0)
        return;

    // Voxels must be ordered by increasing z, y and x values respectively
    // otherwise binary search for voxel by offset will not work
    CheckCoordMatrixCorrectlyOrdered(coords);

    // Create a column vector with one entry per voxel.
    ColumnVector offsets(nVoxels);

    // Populate offsets with the offset into the
    // matrix of each voxel. We assume that co-ordinates
    // could be zero but not negative
    int xsize = coords.Row(1).Maximum() + 1;
    int ysize = coords.Row(2).Maximum() + 1;
    for (int v = 1; v <= nVoxels; v++)
    {
        int x = coords(1, v);
        int y = coords(2, v);
        int z = coords(3, v);
        int offset = z * xsize * ysize + y * xsize + x;
        offsets(v) = offset;
    }

    // Delta is a list of offsets to find nearest
    // neighbours in x y and z direction (not diagonally)
    // Of course applying these offsets naively would not
    // always work, e.g. offset of -1 in the x direction
    // will not be a nearest neighbour for the first voxel
    // so need to check for this in subsequent code
    vector<int> delta;
    delta.push_back(1);              // next row
    delta.push_back(-1);             // prev row
    delta.push_back(xsize);          // next column
    delta.push_back(-xsize);         // prev column
    delta.push_back(xsize * ysize);  // next slice
    delta.push_back(-xsize * ysize); // prev slice

    // Don't look for neighbours in all dimensions.
    // For example if spatialDims=2, max_delta=3 so we
    // only look for neighbours in rows and columns
    //
    // However note we still need the full list of 3D deltas for later
    int max_delta = m_spatial_dims * 2 - 1;

    // Neighbours is a vector of vectors, so each voxel
    // will have an entry which is a vector of its neighbours
    m_ctx->neighbours.resize(nVoxels);

    // Go through each voxel. Note that offsets is indexed from 1 not 0
    // however the offsets themselves (potentially) start at 0.
    for (int vid = 1; vid <= nVoxels; vid++)
    {
        // Get the voxel offset into the matrix
        int pos = int(offsets(vid));

        // Now search for neighbours
        for (int n = 0; n <= max_delta; n++)
        {
            // is there a voxel at this neighbour position?
            // indexed from 1; id == -1 if not found.
            int id = binarySearch(offsets, pos + delta[n]);

            // No such voxel: continue
            if (id < 0)
                continue;

            // Check for wrap-around

            // Don't check for wrap around on final co-ord
            // PREVIOUSLY		if (delta.size() >= n + 2)
            // Changed (fixed)? because if spatialDims != 3 we still need
            // to check for wrap around in y-coordinate FIXME check
            if (n < 4)
            {
                bool ignore = false;
                if (delta[n] > 0)
                {
                    int test = delta[n + 2];
                    if (test > 0)
                        ignore = (pos % test) >= test - delta[n];
                }
                else
                {
                    int test = -delta[n + 2];
                    if (test > 0)
                        ignore = (pos % test) < -delta[n];
                }
                if (ignore)
                {
                    continue;
                }
            }

            // If we get this far, add it to the list
            m_ctx->neighbours.at(vid - 1).push_back(id);
        }
    }

    // Similar algorithm but looking for Neighbours-of-neighbours, excluding self,
    // but including duplicates if there are two routes to get there
    // (diagonally connected) 
    m_ctx->neighbours2.resize(nVoxels);

    for (int vid = 1; vid <= nVoxels; vid++)
    {
        // Go through the list of neighbours for each voxel.
        for (unsigned n1 = 0; n1 < m_ctx->neighbours.at(vid - 1).size(); n1++)
        {
            // n1id is the voxel index (not the offset) of the neighbour
            int n1id = m_ctx->neighbours[vid - 1].at(n1);
            int checkNofN = 0;
            // Go through each of it's neighbours. Add each, apart from original voxel
            for (unsigned n2 = 0; n2 < m_ctx->neighbours.at(n1id - 1).size(); n2++)
            {
                int n2id = m_ctx->neighbours[n1id - 1].at(n2);
                if (n2id != vid)
                {
                    m_ctx->neighbours2[vid - 1].push_back(n2id);
                }
                else
                    checkNofN++;
            }

            if (checkNofN != 1)
            {
                throw FabberInternalError(
                    "Each of this voxel's neighbours must have "
                    "this voxel as a neighbour");
            }
        }
    }
}

void Vb::SaveResults(FabberRunData &rundata) const
{
    LOG << "Vb::Preparing to save results..." << endl;
    int nVoxels = resultMVNs.size();

    // Save the resultMVNs
    if (rundata.GetBool("save-mvn"))
    {
        MVNDist::Save(resultMVNs, "finalMVN", rundata);
    }

    // Create individual files for each parameter's mean and Z-stat
    vector<Parameter> params;
    m_model->GetParameters(rundata, params);

    if (rundata.GetBool("save-mean") | rundata.GetBool("save-std") | rundata.GetBool("save-zstat"))
    {
        LOG << "Vb::Writing means..." << endl;
        for (unsigned i = 1; i <= params.size(); i++)
        {
            Matrix paramMean, paramZstat, paramStd;
            paramMean.ReSize(1, nVoxels);
            paramZstat.ReSize(1, nVoxels);
            paramStd.ReSize(1, nVoxels);
            
            for (int vox = 1; vox <= nVoxels; vox++)
            {
                MVNDist result = *resultMVNs[vox - 1];
                m_model->ToModel(result);
                paramMean(1, vox) = result.means(i);
                double std = sqrt(result.GetCovariance()(i, i));
                paramZstat(1, vox) = paramMean(1, vox) / std;
                paramStd(1, vox) = std;
            }

            if (rundata.GetBool("save-mean"))
                rundata.SaveVoxelData("mean_" + params.at(i - 1).name, paramMean);
            if (rundata.GetBool("save-zstat"))
                rundata.SaveVoxelData("zstat_" + params.at(i - 1).name, paramZstat);
            if (rundata.GetBool("save-std"))
                rundata.SaveVoxelData("std_" + params.at(i - 1).name, paramStd);
        }
    }

    // Produce the model fit and residual volume series
    bool saveModelFit = rundata.GetBool("save-model-fit");
    bool saveResiduals = rundata.GetBool("save-residuals");
    if (saveModelFit || saveResiduals)
    {
        LOG << "Vb::Writing model fit/residuals..." << endl;

        Matrix modelFit, residuals, datamtx, coords;
        datamtx = rundata.GetMainVoxelData(); // it is just possible that the model needs the data in its calculations
        coords = rundata.GetVoxelCoords();
        modelFit.ReSize(datamtx.Nrows(), nVoxels);
        ColumnVector tmp;
        for (int vox = 1; vox <= nVoxels; vox++)
        {
            // pass in stuff that the model might need
            ColumnVector y = datamtx.Column(vox);
            ColumnVector vcoords = coords.Column(vox);
            m_model->PassData(y, vcoords);

            // do the evaluation
            m_model->EvaluateFabber(resultMVNs.at(vox - 1)->means.Rows(1, m_num_params), tmp);
            modelFit.Column(vox) = tmp;
        }

        if (saveResiduals)
        {
            residuals = datamtx - modelFit;
            rundata.SaveVoxelData("residuals", residuals);
        }
        if (saveModelFit)
        {
            rundata.SaveVoxelData("modelfit", modelFit);
        }
    }

    LOG << "Vb::Done writing results." << endl;
}
