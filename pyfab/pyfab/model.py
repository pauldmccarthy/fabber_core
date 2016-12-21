import sys, os
import traceback

""" Fabber has been run """
CH_RUN = "run"

from mvc import Model
from fabber import DirectoryRun

class FabberRunData(Model):
    """
    A fabber options file
    """
    def __init__(self, filename=None):
        Model.__init__(self, "fab")
        
        # Mapping of options as key/value pairs
        self.options = {}
        
        # Lines in the file in order, either a key or a comment string
        # Enables file to be recreated with comments in right place
        self.filelines = []

        if filename: 
            self.load(filename)
        else: 
            self._init_default()

    def set_option(self, key, value=""):
        key, value = key.strip(), value.strip()
        if key == "": return
        if key not in self.options:
            self.filelines.append(key)
        self.options[key] = value
        self._dump(sys.stdout)
        self._change(key)        
        self._update_views()
       
    def clear_option(self, key):
        key = key.strip()
        if key == "": return
        if key in self.options:
            del self.options[key]
            self.filelines.remove(key)
        self._dump(sys.stdout)
        self._change(key)
        self._update_views()
        
    def set_file(self, f):
        """ Set the file. Do not parse, this is just used
            as part of 'save as' """
        self.filepath = os.path.abspath(f)
        # FIXME update views?
           
    def get_filedir(self):
        dir, junk = os.path.split(self.filepath)
        return dir
    
    def get_filename(self):
        junk, fname = os.path.split(self.filepath)
        return fname
        
    def set_fabber(self, ex):
        """
        Set the fabber executable for use with this file
        """
        self.fabber.set_exec(ex)
        self.set_option("fabber", ex)
  
    def get_runs(self):
        """
        Get a list of known previous runs. The first in the list is the most recent
        
        This starts with the specified output directory and tries to load a run.
        If successful, it adds + to the filename (as Fabber does) and tries again.
        It continues until it cannot find any more valid run directories.
        """
        runs = []
        if not self.options.has_key("output"):
            print("WARNING: No output dir set, cannot check for runs")
            return []
        if not self.options.has_key("data"):
            print("WARNING: No data, will not check for runs")
            return []
            
        outdir = self.options["output"]
        if not os.path.isabs(outdir):
            outdir = os.path.join(self.get_filedir(), outdir)
        if self.options.has_key("overwrite"):
            try:
                runs.append(DirectoryRun(outdir))
            except:
                traceback.print_exc()
                print("Could not find logfile in: %s - ignoring" % outdir)
        else:
            while os.path.exists(outdir):
                try:
                    run = DirectoryRun(outdir)
                    runs.append(run)
                except:
                    traceback.print_exc()
                    print("Could not find logfile in: %s - ignoring" % outdir)
                outdir += "+"
            runs.sort(key=lambda run: run.time)
        return runs

    def load(self, fname):   
        self.set_file(fname)     
        fabfile = open(self.filepath, "r")        
        for line in fabfile.readlines():
            line = line.strip()
            if len(line) == 0 or line[0] == "#":
                self.filelines.append(line)
            else:
                kv = line.split("=", 1)
                key = kv[0].strip()
                if len(kv) > 1: value = kv[1].strip()
                else: value = ""
                self.options[key] = value
                
                self.filelines.append(key)
                
        fabfile.close()
        self._change()        
        self._update_views()
               
    def save(self, fpath=None, mask=None):
        """
        Save .fab file. If mask specified use this mask file
        in preference to one in options (used for quick runs)
        """
        if fpath is None:
            fpath = self.filepath
        if not fpath:
            raise "No file specified for save"
        
        print(fpath)
        fab = open(fpath, "w")
        self._dump(fab, mask=mask)
        #self._dump(sys.stdout, mask=mask)
        fab.close()
     
    def run(self, focus=None):
        """
        Run fabber. If focus specified, do a quick 1-voxel run at this point
        """
        if focus:
            temp_mask = self._write_temp_mask(focus)
            fpath = self.filepath + "_tmp"
        else:
            temp_mask = None
            fpath = self.filepath
        self.save(fpath=fpath, mask=temp_mask)
        self.fabber.run(fpath)
        
        if focus:
            os.remove(fpath)
            os.remove(temp_mask)
        
        self._change(CH_RUN)        
        self._update_views()        
  
    def _write_temp_mask(self, focus):
        """
        Something of a hack
        """
        main_data = nib.load(self.options["data"]).get_data()
        mask_shape = main_data.shape[:3]
        
        fname = os.path.join(self.get_filedir(), "fabber_mask_temp.nii.gz")
        mask_data = np.zeros(mask_shape)
        mask_data[focus[0], focus[1], focus[2]] = 1
        img = nib.Nifti1Image(mask_data, main_data.affine)
        nib.save(img, fname)
        return fname

    def _dump(self, dev, mask=None):
        for line in self.filelines:
            if len(line) == 0 or line[0] == "#":
                dev.write(line)
            else:
                if self.options[line] == "":
                    dev.write("%s" % line)
                elif line=="mask" and mask is not None:
                    dev.write("mask=%s" % mask)
                else:
                    dev.write("%s=%s" % (line, self.options[line]))
            dev.write("\n")
              
#    def _write_quickrun_file(self, dir):
#        """
#        Write a little file which identifies a particular
#        run as a 1-voxel test run
#        
#        FIXME not used
#        """
#        f = open(os.path.join(dir, "QUICKRUN.txt"), "wc")
#        f.write("This data is from a 1-voxel test run\n")
#        f.close()
           
    def _init_default(self):
        self.set_file("newfile.fab")
        
        self.options = {"method" : "vb", "noise" : "white", 
                        "model" : "poly", "degree" : "2", 
                        "output" : "out", "overwrite" : "", 
                        "save-model-fit" : ""}
        self.filelines = ["# Generated by fabber_gui.py", "", 
                          "output", "overwrite", "save-model-fit", ""
                          "method", "noise", "model", "degree"]
        self._change()
        self._update_views()


        
