# Makefile.in generated by automake 1.11.1 from Makefile.am.
# Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
# 2003, 2004, 2005, 2006, 2007, 2008, 2009  Free Software Foundation,
# Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.





pkgdatadir = $(datadir)/fabber
pkgincludedir = $(includedir)/fabber
pkglibdir = $(libdir)/fabber
pkglibexecdir = $(libexecdir)/fabber
am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
install_sh_DATA = $(install_sh) -c -m 644
install_sh_PROGRAM = $(install_sh) -c
install_sh_SCRIPT = $(install_sh) -c
INSTALL_HEADER = $(INSTALL_DATA)
transform = $(program_transform_name)
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
bin_PROGRAMS = fabber$(EXEEXT)
check_PROGRAMS = testfabber$(EXEEXT)
TESTS = testfabber$(EXEEXT)
subdir = .
DIST_COMMON = $(am__configure_deps) $(srcdir)/Makefile.am \
	$(srcdir)/Makefile.in $(top_srcdir)/configure depcomp \
	install-sh missing
ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
am__aclocal_m4_deps = $(top_srcdir)/configure.ac
am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
	$(ACLOCAL_M4)
am__CONFIG_DISTCLEAN_FILES = config.status config.cache config.log \
 configure.lineno config.status.lineno
mkinstalldirs = $(install_sh) -d
CONFIG_CLEAN_FILES =
CONFIG_CLEAN_VPATH_FILES =
LIBRARIES = $(noinst_LIBRARIES)
AR = ar
ARFLAGS = cru
libfabbercore_a_AR = $(AR) $(ARFLAGS)
libfabbercore_a_DEPENDENCIES =
am__objects_1 = tools.$(OBJEXT) dataset.$(OBJEXT) dist_mvn.$(OBJEXT) \
	easylog.$(OBJEXT) setup.$(OBJEXT) fabber_core.$(OBJEXT)
am__objects_2 = noisemodel.$(OBJEXT) fwdmodel.$(OBJEXT) \
	inference.$(OBJEXT) utils.$(OBJEXT) fwdmodel_linear.$(OBJEXT) \
	fwdmodel_trivial.$(OBJEXT) fwdmodel_poly.$(OBJEXT) \
	convergence.$(OBJEXT)
am__objects_3 = inference_vb.$(OBJEXT) inference_nlls.$(OBJEXT) \
	inference_spatialvb.$(OBJEXT)
am__objects_4 = noisemodel_white.$(OBJEXT) noisemodel_ar.$(OBJEXT)
am_libfabbercore_a_OBJECTS = $(am__objects_1) $(am__objects_2) \
	$(am__objects_3) $(am__objects_4)
libfabbercore_a_OBJECTS = $(am_libfabbercore_a_OBJECTS)
am__installdirs = "$(DESTDIR)$(bindir)"
PROGRAMS = $(bin_PROGRAMS)
am_fabber_OBJECTS = fabber-fabber_main.$(OBJEXT)
fabber_OBJECTS = $(am_fabber_OBJECTS)
fabber_DEPENDENCIES = libfabbercore.a
am_testfabber_OBJECTS = testfabber-fabbertest.$(OBJEXT) \
	testfabber-test_inference.$(OBJEXT) \
	testfabber-test_spatialvb.$(OBJEXT) \
	testfabber-test_vb.$(OBJEXT) \
	testfabber-test_convergence.$(OBJEXT) \
	testfabber-test_rundata.$(OBJEXT)
testfabber_OBJECTS = $(am_testfabber_OBJECTS)
am__DEPENDENCIES_1 = libfabbercore.a
testfabber_DEPENDENCIES = $(am__DEPENDENCIES_1)
DEFAULT_INCLUDES = -I.
depcomp = $(SHELL) $(top_srcdir)/depcomp
am__depfiles_maybe = depfiles
am__mv = mv -f
CXXCOMPILE = $(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
	$(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS)
CXXLD = $(CXX)
CXXLINK = $(CXXLD) $(AM_CXXFLAGS) $(CXXFLAGS) $(AM_LDFLAGS) $(LDFLAGS) \
	-o $@
SOURCES = $(libfabbercore_a_SOURCES) $(fabber_SOURCES) \
	$(testfabber_SOURCES)
DIST_SOURCES = $(libfabbercore_a_SOURCES) $(fabber_SOURCES) \
	$(testfabber_SOURCES)
ETAGS = etags
CTAGS = ctags
am__tty_colors = \
red=; grn=; lgn=; blu=; std=
DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
distdir = $(PACKAGE)-$(VERSION)
top_distdir = $(distdir)
am__remove_distdir = \
  { test ! -d "$(distdir)" \
    || { find "$(distdir)" -type d ! -perm -200 -exec chmod u+w {} ';' \
         && rm -fr "$(distdir)"; }; }
DIST_ARCHIVES = $(distdir).tar.gz
GZIP_ENV = --best
distuninstallcheck_listfiles = find . -type f -print
distcleancheck_listfiles = find . -type f -print
ACLOCAL = ${SHELL} /home/fsl/dev/fabber/fabber_core/missing --run aclocal-1.11
AMTAR = ${SHELL} /home/fsl/dev/fabber/fabber_core/missing --run tar
AUTOCONF = ${SHELL} /home/fsl/dev/fabber/fabber_core/missing --run autoconf
AUTOHEADER = ${SHELL} /home/fsl/dev/fabber/fabber_core/missing --run autoheader
AUTOMAKE = ${SHELL} /home/fsl/dev/fabber/fabber_core/missing --run automake-1.11
AWK = gawk
CPPFLAGS = -I$(FSLDIR)/include -I$(FSLDIR)/extras/include/newmat -I$(FSLDIR)/extras/include/boost -DUSE_NEWIMAGE
CXX = g++
CXXDEPMODE = depmode=gcc3
CXXFLAGS = -g -O2
CYGPATH_W = echo
DEFS = -DPACKAGE_NAME=\"fabber\" -DPACKAGE_TARNAME=\"fabber\" -DPACKAGE_VERSION=\"4.0pre\" -DPACKAGE_STRING=\"fabber\ 4.0pre\" -DPACKAGE_BUGREPORT=\"martin.craig@eng.ox.ac.uk\" -DPACKAGE=\"fabber\" -DVERSION=\"4.0pre\"
DEPDIR = .deps
DOXYGEN = doxygen
ECHO_C = 
ECHO_N = -n
ECHO_T = 
EXEEXT = 
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
LDFLAGS = 
LIBOBJS = 
LIBS = 
LTLIBOBJS = 
MAKEINFO = ${SHELL} /home/fsl/dev/fabber/fabber_core/missing --run makeinfo
MKDIR_P = /bin/mkdir -p
OBJEXT = o
PACKAGE = fabber
PACKAGE_BUGREPORT = martin.craig@eng.ox.ac.uk
PACKAGE_NAME = fabber
PACKAGE_STRING = fabber 4.0pre
PACKAGE_TARNAME = fabber
PACKAGE_VERSION = 4.0pre
PATH_SEPARATOR = :
RANLIB = ranlib
SET_MAKE = 
SHELL = /bin/sh
STRIP = 
VERSION = 4.0pre
abs_builddir = /home/fsl/dev/fabber/fabber_core
abs_srcdir = /home/fsl/dev/fabber/fabber_core
abs_top_builddir = /home/fsl/dev/fabber/fabber_core
abs_top_srcdir = /home/fsl/dev/fabber/fabber_core
ac_ct_CXX = g++
am__include = include
am__leading_dot = .
am__quote = 
am__tar = ${AMTAR} chof - "$$tardir"
am__untar = ${AMTAR} xf -
bindir = ${exec_prefix}/bin
build_alias = 
builddir = .
datadir = ${datarootdir}
datarootdir = ${prefix}/share
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
dvidir = ${docdir}
exec_prefix = ${prefix}
host_alias = 
htmldir = ${docdir}
includedir = ${prefix}/include
infodir = ${datarootdir}/info
install_sh = ${SHELL} /home/fsl/dev/fabber/fabber_core/install-sh
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/libexec
localedir = ${datarootdir}/locale
localstatedir = ${prefix}/var
mandir = ${datarootdir}/man
mkdir_p = /bin/mkdir -p
oldincludedir = /usr/include
pdfdir = ${docdir}
prefix = /usr/local
program_transform_name = s,x,x,
psdir = ${docdir}
sbindir = ${exec_prefix}/sbin
sharedstatedir = ${prefix}/com
srcdir = .
sysconfdir = ${prefix}/etc
target_alias = 
top_build_prefix = 
top_builddir = .
top_srcdir = .
AUTOMAKE_OPTIONS = foreign
noinst_LIBRARIES = libfabbercore.a

# Basic objects - things that have nothing directly to do with inference
BASIC_SRC = tools.cc dataset.cc dist_mvn.cc easylog.cc setup.cc fabber_core.cc

# Core objects - things that implement the framework for inference
CORE_SRC = noisemodel.cc fwdmodel.cc inference.cc utils.cc fwdmodel_linear.cc fwdmodel_trivial.cc fwdmodel_poly.cc convergence.cc

# Inference methods
INFERENCE_SRC = inference_vb.cc inference_nlls.cc inference_spatialvb.cc

# Noise models
NOISE_SRC = noisemodel_white.cc noisemodel_ar.cc
fabber_SOURCES = fabber_main.cc 
fabber_CPPFLAGS = -I. $(CPPFLAGS)
fabber_LDADD = libfabbercore.a \
	-L$(FSLDIR)/lib -L$(FSLDIR)/extras/lib \
	-lnewimage -lmiscmaths -lnewmat -lfslio -lniftiio -lutils \
	-lpthread -lznz -lz

testfabber_SOURCES = test/fabbertest.cc \
                   test/test_inference.cc \
                   test/test_spatialvb.cc \
                   test/test_vb.cc \
                   test/test_convergence.cc \
		   test/test_rundata.cc

testfabber_CPPFLAGS = -I. $(CPPFLAGS)
testfabber_LDADD = $(fabber_LDADD) -lgtest
libfabbercore_a_SOURCES = $(BASIC_SRC) $(CORE_SRC) $(INFERENCE_SRC) $(NOISE_SRC)
libfabbercore_a_CPPFLAGSas = $(CPPFLAGS)
libfabbercore_a_LIBADD = 
all: all-am

.SUFFIXES:
.SUFFIXES: .cc .o .obj
am--refresh:
	@:
$(srcdir)/Makefile.in:  $(srcdir)/Makefile.am  $(am__configure_deps)
	@for dep in $?; do \
	  case '$(am__configure_deps)' in \
	    *$$dep*) \
	      echo ' cd $(srcdir) && $(AUTOMAKE) --foreign'; \
	      $(am__cd) $(srcdir) && $(AUTOMAKE) --foreign \
		&& exit 0; \
	      exit 1;; \
	  esac; \
	done; \
	echo ' cd $(top_srcdir) && $(AUTOMAKE) --foreign Makefile'; \
	$(am__cd) $(top_srcdir) && \
	  $(AUTOMAKE) --foreign Makefile
.PRECIOUS: Makefile
Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	@case '$?' in \
	  *config.status*) \
	    echo ' $(SHELL) ./config.status'; \
	    $(SHELL) ./config.status;; \
	  *) \
	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe)'; \
	    cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe);; \
	esac;

$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
	$(SHELL) ./config.status --recheck

$(top_srcdir)/configure:  $(am__configure_deps)
	$(am__cd) $(srcdir) && $(AUTOCONF)
$(ACLOCAL_M4):  $(am__aclocal_m4_deps)
	$(am__cd) $(srcdir) && $(ACLOCAL) $(ACLOCAL_AMFLAGS)
$(am__aclocal_m4_deps):

clean-noinstLIBRARIES:
	-test -z "$(noinst_LIBRARIES)" || rm -f $(noinst_LIBRARIES)
libfabbercore.a: $(libfabbercore_a_OBJECTS) $(libfabbercore_a_DEPENDENCIES) 
	-rm -f libfabbercore.a
	$(libfabbercore_a_AR) libfabbercore.a $(libfabbercore_a_OBJECTS) $(libfabbercore_a_LIBADD)
	$(RANLIB) libfabbercore.a
install-binPROGRAMS: $(bin_PROGRAMS)
	@$(NORMAL_INSTALL)
	test -z "$(bindir)" || $(MKDIR_P) "$(DESTDIR)$(bindir)"
	@list='$(bin_PROGRAMS)'; test -n "$(bindir)" || list=; \
	for p in $$list; do echo "$$p $$p"; done | \
	sed 's/$(EXEEXT)$$//' | \
	while read p p1; do if test -f $$p; \
	  then echo "$$p"; echo "$$p"; else :; fi; \
	done | \
	sed -e 'p;s,.*/,,;n;h' -e 's|.*|.|' \
	    -e 'p;x;s,.*/,,;s/$(EXEEXT)$$//;$(transform);s/$$/$(EXEEXT)/' | \
	sed 'N;N;N;s,\n, ,g' | \
	$(AWK) 'BEGIN { files["."] = ""; dirs["."] = 1 } \
	  { d=$$3; if (dirs[d] != 1) { print "d", d; dirs[d] = 1 } \
	    if ($$2 == $$4) files[d] = files[d] " " $$1; \
	    else { print "f", $$3 "/" $$4, $$1; } } \
	  END { for (d in files) print "f", d, files[d] }' | \
	while read type dir files; do \
	    if test "$$dir" = .; then dir=; else dir=/$$dir; fi; \
	    test -z "$$files" || { \
	      echo " $(INSTALL_PROGRAM_ENV) $(INSTALL_PROGRAM) $$files '$(DESTDIR)$(bindir)$$dir'"; \
	      $(INSTALL_PROGRAM_ENV) $(INSTALL_PROGRAM) $$files "$(DESTDIR)$(bindir)$$dir" || exit $$?; \
	    } \
	; done

uninstall-binPROGRAMS:
	@$(NORMAL_UNINSTALL)
	@list='$(bin_PROGRAMS)'; test -n "$(bindir)" || list=; \
	files=`for p in $$list; do echo "$$p"; done | \
	  sed -e 'h;s,^.*/,,;s/$(EXEEXT)$$//;$(transform)' \
	      -e 's/$$/$(EXEEXT)/' `; \
	test -n "$$list" || exit 0; \
	echo " ( cd '$(DESTDIR)$(bindir)' && rm -f" $$files ")"; \
	cd "$(DESTDIR)$(bindir)" && rm -f $$files

clean-binPROGRAMS:
	-test -z "$(bin_PROGRAMS)" || rm -f $(bin_PROGRAMS)

clean-checkPROGRAMS:
	-test -z "$(check_PROGRAMS)" || rm -f $(check_PROGRAMS)
fabber$(EXEEXT): $(fabber_OBJECTS) $(fabber_DEPENDENCIES) 
	@rm -f fabber$(EXEEXT)
	$(CXXLINK) $(fabber_OBJECTS) $(fabber_LDADD) $(LIBS)
testfabber$(EXEEXT): $(testfabber_OBJECTS) $(testfabber_DEPENDENCIES) 
	@rm -f testfabber$(EXEEXT)
	$(CXXLINK) $(testfabber_OBJECTS) $(testfabber_LDADD) $(LIBS)

mostlyclean-compile:
	-rm -f *.$(OBJEXT)

distclean-compile:
	-rm -f *.tab.c

include ./$(DEPDIR)/convergence.Po
include ./$(DEPDIR)/dataset.Po
include ./$(DEPDIR)/dist_mvn.Po
include ./$(DEPDIR)/easylog.Po
include ./$(DEPDIR)/fabber-fabber_main.Po
include ./$(DEPDIR)/fabber_core.Po
include ./$(DEPDIR)/fwdmodel.Po
include ./$(DEPDIR)/fwdmodel_linear.Po
include ./$(DEPDIR)/fwdmodel_poly.Po
include ./$(DEPDIR)/fwdmodel_trivial.Po
include ./$(DEPDIR)/inference.Po
include ./$(DEPDIR)/inference_nlls.Po
include ./$(DEPDIR)/inference_spatialvb.Po
include ./$(DEPDIR)/inference_vb.Po
include ./$(DEPDIR)/noisemodel.Po
include ./$(DEPDIR)/noisemodel_ar.Po
include ./$(DEPDIR)/noisemodel_white.Po
include ./$(DEPDIR)/setup.Po
include ./$(DEPDIR)/testfabber-fabbertest.Po
include ./$(DEPDIR)/testfabber-test_convergence.Po
include ./$(DEPDIR)/testfabber-test_inference.Po
include ./$(DEPDIR)/testfabber-test_rundata.Po
include ./$(DEPDIR)/testfabber-test_spatialvb.Po
include ./$(DEPDIR)/testfabber-test_vb.Po
include ./$(DEPDIR)/tools.Po
include ./$(DEPDIR)/utils.Po

.cc.o:
	$(CXXCOMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $<
	$(am__mv) $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Po
#	source='$<' object='$@' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXXCOMPILE) -c -o $@ $<

.cc.obj:
	$(CXXCOMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ `$(CYGPATH_W) '$<'`
	$(am__mv) $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Po
#	source='$<' object='$@' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXXCOMPILE) -c -o $@ `$(CYGPATH_W) '$<'`

fabber-fabber_main.o: fabber_main.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(fabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT fabber-fabber_main.o -MD -MP -MF $(DEPDIR)/fabber-fabber_main.Tpo -c -o fabber-fabber_main.o `test -f 'fabber_main.cc' || echo '$(srcdir)/'`fabber_main.cc
	$(am__mv) $(DEPDIR)/fabber-fabber_main.Tpo $(DEPDIR)/fabber-fabber_main.Po
#	source='fabber_main.cc' object='fabber-fabber_main.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(fabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o fabber-fabber_main.o `test -f 'fabber_main.cc' || echo '$(srcdir)/'`fabber_main.cc

fabber-fabber_main.obj: fabber_main.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(fabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT fabber-fabber_main.obj -MD -MP -MF $(DEPDIR)/fabber-fabber_main.Tpo -c -o fabber-fabber_main.obj `if test -f 'fabber_main.cc'; then $(CYGPATH_W) 'fabber_main.cc'; else $(CYGPATH_W) '$(srcdir)/fabber_main.cc'; fi`
	$(am__mv) $(DEPDIR)/fabber-fabber_main.Tpo $(DEPDIR)/fabber-fabber_main.Po
#	source='fabber_main.cc' object='fabber-fabber_main.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(fabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o fabber-fabber_main.obj `if test -f 'fabber_main.cc'; then $(CYGPATH_W) 'fabber_main.cc'; else $(CYGPATH_W) '$(srcdir)/fabber_main.cc'; fi`

testfabber-fabbertest.o: test/fabbertest.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-fabbertest.o -MD -MP -MF $(DEPDIR)/testfabber-fabbertest.Tpo -c -o testfabber-fabbertest.o `test -f 'test/fabbertest.cc' || echo '$(srcdir)/'`test/fabbertest.cc
	$(am__mv) $(DEPDIR)/testfabber-fabbertest.Tpo $(DEPDIR)/testfabber-fabbertest.Po
#	source='test/fabbertest.cc' object='testfabber-fabbertest.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-fabbertest.o `test -f 'test/fabbertest.cc' || echo '$(srcdir)/'`test/fabbertest.cc

testfabber-fabbertest.obj: test/fabbertest.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-fabbertest.obj -MD -MP -MF $(DEPDIR)/testfabber-fabbertest.Tpo -c -o testfabber-fabbertest.obj `if test -f 'test/fabbertest.cc'; then $(CYGPATH_W) 'test/fabbertest.cc'; else $(CYGPATH_W) '$(srcdir)/test/fabbertest.cc'; fi`
	$(am__mv) $(DEPDIR)/testfabber-fabbertest.Tpo $(DEPDIR)/testfabber-fabbertest.Po
#	source='test/fabbertest.cc' object='testfabber-fabbertest.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-fabbertest.obj `if test -f 'test/fabbertest.cc'; then $(CYGPATH_W) 'test/fabbertest.cc'; else $(CYGPATH_W) '$(srcdir)/test/fabbertest.cc'; fi`

testfabber-test_inference.o: test/test_inference.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_inference.o -MD -MP -MF $(DEPDIR)/testfabber-test_inference.Tpo -c -o testfabber-test_inference.o `test -f 'test/test_inference.cc' || echo '$(srcdir)/'`test/test_inference.cc
	$(am__mv) $(DEPDIR)/testfabber-test_inference.Tpo $(DEPDIR)/testfabber-test_inference.Po
#	source='test/test_inference.cc' object='testfabber-test_inference.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_inference.o `test -f 'test/test_inference.cc' || echo '$(srcdir)/'`test/test_inference.cc

testfabber-test_inference.obj: test/test_inference.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_inference.obj -MD -MP -MF $(DEPDIR)/testfabber-test_inference.Tpo -c -o testfabber-test_inference.obj `if test -f 'test/test_inference.cc'; then $(CYGPATH_W) 'test/test_inference.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_inference.cc'; fi`
	$(am__mv) $(DEPDIR)/testfabber-test_inference.Tpo $(DEPDIR)/testfabber-test_inference.Po
#	source='test/test_inference.cc' object='testfabber-test_inference.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_inference.obj `if test -f 'test/test_inference.cc'; then $(CYGPATH_W) 'test/test_inference.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_inference.cc'; fi`

testfabber-test_spatialvb.o: test/test_spatialvb.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_spatialvb.o -MD -MP -MF $(DEPDIR)/testfabber-test_spatialvb.Tpo -c -o testfabber-test_spatialvb.o `test -f 'test/test_spatialvb.cc' || echo '$(srcdir)/'`test/test_spatialvb.cc
	$(am__mv) $(DEPDIR)/testfabber-test_spatialvb.Tpo $(DEPDIR)/testfabber-test_spatialvb.Po
#	source='test/test_spatialvb.cc' object='testfabber-test_spatialvb.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_spatialvb.o `test -f 'test/test_spatialvb.cc' || echo '$(srcdir)/'`test/test_spatialvb.cc

testfabber-test_spatialvb.obj: test/test_spatialvb.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_spatialvb.obj -MD -MP -MF $(DEPDIR)/testfabber-test_spatialvb.Tpo -c -o testfabber-test_spatialvb.obj `if test -f 'test/test_spatialvb.cc'; then $(CYGPATH_W) 'test/test_spatialvb.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_spatialvb.cc'; fi`
	$(am__mv) $(DEPDIR)/testfabber-test_spatialvb.Tpo $(DEPDIR)/testfabber-test_spatialvb.Po
#	source='test/test_spatialvb.cc' object='testfabber-test_spatialvb.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_spatialvb.obj `if test -f 'test/test_spatialvb.cc'; then $(CYGPATH_W) 'test/test_spatialvb.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_spatialvb.cc'; fi`

testfabber-test_vb.o: test/test_vb.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_vb.o -MD -MP -MF $(DEPDIR)/testfabber-test_vb.Tpo -c -o testfabber-test_vb.o `test -f 'test/test_vb.cc' || echo '$(srcdir)/'`test/test_vb.cc
	$(am__mv) $(DEPDIR)/testfabber-test_vb.Tpo $(DEPDIR)/testfabber-test_vb.Po
#	source='test/test_vb.cc' object='testfabber-test_vb.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_vb.o `test -f 'test/test_vb.cc' || echo '$(srcdir)/'`test/test_vb.cc

testfabber-test_vb.obj: test/test_vb.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_vb.obj -MD -MP -MF $(DEPDIR)/testfabber-test_vb.Tpo -c -o testfabber-test_vb.obj `if test -f 'test/test_vb.cc'; then $(CYGPATH_W) 'test/test_vb.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_vb.cc'; fi`
	$(am__mv) $(DEPDIR)/testfabber-test_vb.Tpo $(DEPDIR)/testfabber-test_vb.Po
#	source='test/test_vb.cc' object='testfabber-test_vb.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_vb.obj `if test -f 'test/test_vb.cc'; then $(CYGPATH_W) 'test/test_vb.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_vb.cc'; fi`

testfabber-test_convergence.o: test/test_convergence.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_convergence.o -MD -MP -MF $(DEPDIR)/testfabber-test_convergence.Tpo -c -o testfabber-test_convergence.o `test -f 'test/test_convergence.cc' || echo '$(srcdir)/'`test/test_convergence.cc
	$(am__mv) $(DEPDIR)/testfabber-test_convergence.Tpo $(DEPDIR)/testfabber-test_convergence.Po
#	source='test/test_convergence.cc' object='testfabber-test_convergence.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_convergence.o `test -f 'test/test_convergence.cc' || echo '$(srcdir)/'`test/test_convergence.cc

testfabber-test_convergence.obj: test/test_convergence.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_convergence.obj -MD -MP -MF $(DEPDIR)/testfabber-test_convergence.Tpo -c -o testfabber-test_convergence.obj `if test -f 'test/test_convergence.cc'; then $(CYGPATH_W) 'test/test_convergence.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_convergence.cc'; fi`
	$(am__mv) $(DEPDIR)/testfabber-test_convergence.Tpo $(DEPDIR)/testfabber-test_convergence.Po
#	source='test/test_convergence.cc' object='testfabber-test_convergence.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_convergence.obj `if test -f 'test/test_convergence.cc'; then $(CYGPATH_W) 'test/test_convergence.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_convergence.cc'; fi`

testfabber-test_rundata.o: test/test_rundata.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_rundata.o -MD -MP -MF $(DEPDIR)/testfabber-test_rundata.Tpo -c -o testfabber-test_rundata.o `test -f 'test/test_rundata.cc' || echo '$(srcdir)/'`test/test_rundata.cc
	$(am__mv) $(DEPDIR)/testfabber-test_rundata.Tpo $(DEPDIR)/testfabber-test_rundata.Po
#	source='test/test_rundata.cc' object='testfabber-test_rundata.o' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_rundata.o `test -f 'test/test_rundata.cc' || echo '$(srcdir)/'`test/test_rundata.cc

testfabber-test_rundata.obj: test/test_rundata.cc
	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -MT testfabber-test_rundata.obj -MD -MP -MF $(DEPDIR)/testfabber-test_rundata.Tpo -c -o testfabber-test_rundata.obj `if test -f 'test/test_rundata.cc'; then $(CYGPATH_W) 'test/test_rundata.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_rundata.cc'; fi`
	$(am__mv) $(DEPDIR)/testfabber-test_rundata.Tpo $(DEPDIR)/testfabber-test_rundata.Po
#	source='test/test_rundata.cc' object='testfabber-test_rundata.obj' libtool=no \
#	DEPDIR=$(DEPDIR) $(CXXDEPMODE) $(depcomp) \
#	$(CXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(testfabber_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS) -c -o testfabber-test_rundata.obj `if test -f 'test/test_rundata.cc'; then $(CYGPATH_W) 'test/test_rundata.cc'; else $(CYGPATH_W) '$(srcdir)/test/test_rundata.cc'; fi`

ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	mkid -fID $$unique
tags: TAGS

TAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	set x; \
	here=`pwd`; \
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	shift; \
	if test -z "$(ETAGS_ARGS)$$*$$unique"; then :; else \
	  test -n "$$unique" || unique=$$empty_fix; \
	  if test $$# -gt 0; then \
	    $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	      "$$@" $$unique; \
	  else \
	    $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
	      $$unique; \
	  fi; \
	fi
ctags: CTAGS
CTAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
		$(TAGS_FILES) $(LISP)
	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
	unique=`for i in $$list; do \
	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
	  done | \
	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
	      END { if (nonempty) { for (i in files) print i; }; }'`; \
	test -z "$(CTAGS_ARGS)$$unique" \
	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
	     $$unique

GTAGS:
	here=`$(am__cd) $(top_builddir) && pwd` \
	  && $(am__cd) $(top_srcdir) \
	  && gtags -i $(GTAGS_ARGS) "$$here"

distclean-tags:
	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags

check-TESTS: $(TESTS)
	@failed=0; all=0; xfail=0; xpass=0; skip=0; \
	srcdir=$(srcdir); export srcdir; \
	list=' $(TESTS) '; \
	$(am__tty_colors); \
	if test -n "$$list"; then \
	  for tst in $$list; do \
	    if test -f ./$$tst; then dir=./; \
	    elif test -f $$tst; then dir=; \
	    else dir="$(srcdir)/"; fi; \
	    if $(TESTS_ENVIRONMENT) $${dir}$$tst; then \
	      all=`expr $$all + 1`; \
	      case " $(XFAIL_TESTS) " in \
	      *[\ \	]$$tst[\ \	]*) \
		xpass=`expr $$xpass + 1`; \
		failed=`expr $$failed + 1`; \
		col=$$red; res=XPASS; \
	      ;; \
	      *) \
		col=$$grn; res=PASS; \
	      ;; \
	      esac; \
	    elif test $$? -ne 77; then \
	      all=`expr $$all + 1`; \
	      case " $(XFAIL_TESTS) " in \
	      *[\ \	]$$tst[\ \	]*) \
		xfail=`expr $$xfail + 1`; \
		col=$$lgn; res=XFAIL; \
	      ;; \
	      *) \
		failed=`expr $$failed + 1`; \
		col=$$red; res=FAIL; \
	      ;; \
	      esac; \
	    else \
	      skip=`expr $$skip + 1`; \
	      col=$$blu; res=SKIP; \
	    fi; \
	    echo "$${col}$$res$${std}: $$tst"; \
	  done; \
	  if test "$$all" -eq 1; then \
	    tests="test"; \
	    All=""; \
	  else \
	    tests="tests"; \
	    All="All "; \
	  fi; \
	  if test "$$failed" -eq 0; then \
	    if test "$$xfail" -eq 0; then \
	      banner="$$All$$all $$tests passed"; \
	    else \
	      if test "$$xfail" -eq 1; then failures=failure; else failures=failures; fi; \
	      banner="$$All$$all $$tests behaved as expected ($$xfail expected $$failures)"; \
	    fi; \
	  else \
	    if test "$$xpass" -eq 0; then \
	      banner="$$failed of $$all $$tests failed"; \
	    else \
	      if test "$$xpass" -eq 1; then passes=pass; else passes=passes; fi; \
	      banner="$$failed of $$all $$tests did not behave as expected ($$xpass unexpected $$passes)"; \
	    fi; \
	  fi; \
	  dashes="$$banner"; \
	  skipped=""; \
	  if test "$$skip" -ne 0; then \
	    if test "$$skip" -eq 1; then \
	      skipped="($$skip test was not run)"; \
	    else \
	      skipped="($$skip tests were not run)"; \
	    fi; \
	    test `echo "$$skipped" | wc -c` -le `echo "$$banner" | wc -c` || \
	      dashes="$$skipped"; \
	  fi; \
	  report=""; \
	  if test "$$failed" -ne 0 && test -n "$(PACKAGE_BUGREPORT)"; then \
	    report="Please report to $(PACKAGE_BUGREPORT)"; \
	    test `echo "$$report" | wc -c` -le `echo "$$banner" | wc -c` || \
	      dashes="$$report"; \
	  fi; \
	  dashes=`echo "$$dashes" | sed s/./=/g`; \
	  if test "$$failed" -eq 0; then \
	    echo "$$grn$$dashes"; \
	  else \
	    echo "$$red$$dashes"; \
	  fi; \
	  echo "$$banner"; \
	  test -z "$$skipped" || echo "$$skipped"; \
	  test -z "$$report" || echo "$$report"; \
	  echo "$$dashes$$std"; \
	  test "$$failed" -eq 0; \
	else :; fi

distdir: $(DISTFILES)
	$(am__remove_distdir)
	test -d "$(distdir)" || mkdir "$(distdir)"
	@srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	list='$(DISTFILES)'; \
	  dist_files=`for file in $$list; do echo $$file; done | \
	  sed -e "s|^$$srcdirstrip/||;t" \
	      -e "s|^$$topsrcdirstrip/|$(top_builddir)/|;t"`; \
	case $$dist_files in \
	  */*) $(MKDIR_P) `echo "$$dist_files" | \
			   sed '/\//!d;s|^|$(distdir)/|;s,/[^/]*$$,,' | \
			   sort -u` ;; \
	esac; \
	for file in $$dist_files; do \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  if test -d $$d/$$file; then \
	    dir=`echo "/$$file" | sed -e 's,/[^/]*$$,,'`; \
	    if test -d "$(distdir)/$$file"; then \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -fpR $(srcdir)/$$file "$(distdir)$$dir" || exit 1; \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    cp -fpR $$d/$$file "$(distdir)$$dir" || exit 1; \
	  else \
	    test -f "$(distdir)/$$file" \
	    || cp -p $$d/$$file "$(distdir)/$$file" \
	    || exit 1; \
	  fi; \
	done
	-test -n "$(am__skip_mode_fix)" \
	|| find "$(distdir)" -type d ! -perm -755 \
		-exec chmod u+rwx,go+rx {} \; -o \
	  ! -type d ! -perm -444 -links 1 -exec chmod a+r {} \; -o \
	  ! -type d ! -perm -400 -exec chmod a+r {} \; -o \
	  ! -type d ! -perm -444 -exec $(install_sh) -c -m a+r {} {} \; \
	|| chmod -R a+r "$(distdir)"
dist-gzip: distdir
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
	$(am__remove_distdir)

dist-bzip2: distdir
	tardir=$(distdir) && $(am__tar) | bzip2 -9 -c >$(distdir).tar.bz2
	$(am__remove_distdir)

dist-lzma: distdir
	tardir=$(distdir) && $(am__tar) | lzma -9 -c >$(distdir).tar.lzma
	$(am__remove_distdir)

dist-xz: distdir
	tardir=$(distdir) && $(am__tar) | xz -c >$(distdir).tar.xz
	$(am__remove_distdir)

dist-tarZ: distdir
	tardir=$(distdir) && $(am__tar) | compress -c >$(distdir).tar.Z
	$(am__remove_distdir)

dist-shar: distdir
	shar $(distdir) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).shar.gz
	$(am__remove_distdir)

dist-zip: distdir
	-rm -f $(distdir).zip
	zip -rq $(distdir).zip $(distdir)
	$(am__remove_distdir)

dist dist-all: distdir
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
	$(am__remove_distdir)

# This target untars the dist file and tries a VPATH configuration.  Then
# it guarantees that the distribution is self-contained by making another
# tarfile.
distcheck: dist
	case '$(DIST_ARCHIVES)' in \
	*.tar.gz*) \
	  GZIP=$(GZIP_ENV) gzip -dc $(distdir).tar.gz | $(am__untar) ;;\
	*.tar.bz2*) \
	  bzip2 -dc $(distdir).tar.bz2 | $(am__untar) ;;\
	*.tar.lzma*) \
	  lzma -dc $(distdir).tar.lzma | $(am__untar) ;;\
	*.tar.xz*) \
	  xz -dc $(distdir).tar.xz | $(am__untar) ;;\
	*.tar.Z*) \
	  uncompress -c $(distdir).tar.Z | $(am__untar) ;;\
	*.shar.gz*) \
	  GZIP=$(GZIP_ENV) gzip -dc $(distdir).shar.gz | unshar ;;\
	*.zip*) \
	  unzip $(distdir).zip ;;\
	esac
	chmod -R a-w $(distdir); chmod u+w $(distdir)
	mkdir $(distdir)/_build
	mkdir $(distdir)/_inst
	chmod a-w $(distdir)
	test -d $(distdir)/_build || exit 0; \
	dc_install_base=`$(am__cd) $(distdir)/_inst && pwd | sed -e 's,^[^:\\/]:[\\/],/,'` \
	  && dc_destdir="$${TMPDIR-/tmp}/am-dc-$$$$/" \
	  && am__cwd=`pwd` \
	  && $(am__cd) $(distdir)/_build \
	  && ../configure --srcdir=.. --prefix="$$dc_install_base" \
	    $(DISTCHECK_CONFIGURE_FLAGS) \
	  && $(MAKE) $(AM_MAKEFLAGS) \
	  && $(MAKE) $(AM_MAKEFLAGS) dvi \
	  && $(MAKE) $(AM_MAKEFLAGS) check \
	  && $(MAKE) $(AM_MAKEFLAGS) install \
	  && $(MAKE) $(AM_MAKEFLAGS) installcheck \
	  && $(MAKE) $(AM_MAKEFLAGS) uninstall \
	  && $(MAKE) $(AM_MAKEFLAGS) distuninstallcheck_dir="$$dc_install_base" \
	        distuninstallcheck \
	  && chmod -R a-w "$$dc_install_base" \
	  && ({ \
	       (cd ../.. && umask 077 && mkdir "$$dc_destdir") \
	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" install \
	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" uninstall \
	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" \
	            distuninstallcheck_dir="$$dc_destdir" distuninstallcheck; \
	      } || { rm -rf "$$dc_destdir"; exit 1; }) \
	  && rm -rf "$$dc_destdir" \
	  && $(MAKE) $(AM_MAKEFLAGS) dist \
	  && rm -rf $(DIST_ARCHIVES) \
	  && $(MAKE) $(AM_MAKEFLAGS) distcleancheck \
	  && cd "$$am__cwd" \
	  || exit 1
	$(am__remove_distdir)
	@(echo "$(distdir) archives ready for distribution: "; \
	  list='$(DIST_ARCHIVES)'; for i in $$list; do echo $$i; done) | \
	  sed -e 1h -e 1s/./=/g -e 1p -e 1x -e '$$p' -e '$$x'
distuninstallcheck:
	@$(am__cd) '$(distuninstallcheck_dir)' \
	&& test `$(distuninstallcheck_listfiles) | wc -l` -le 1 \
	   || { echo "ERROR: files left after uninstall:" ; \
	        if test -n "$(DESTDIR)"; then \
	          echo "  (check DESTDIR support)"; \
	        fi ; \
	        $(distuninstallcheck_listfiles) ; \
	        exit 1; } >&2
distcleancheck: distclean
	@if test '$(srcdir)' = . ; then \
	  echo "ERROR: distcleancheck can only run from a VPATH build" ; \
	  exit 1 ; \
	fi
	@test `$(distcleancheck_listfiles) | wc -l` -eq 0 \
	  || { echo "ERROR: files left in build directory after distclean:" ; \
	       $(distcleancheck_listfiles) ; \
	       exit 1; } >&2
check-am: all-am
	$(MAKE) $(AM_MAKEFLAGS) $(check_PROGRAMS)
	$(MAKE) $(AM_MAKEFLAGS) check-TESTS
check: check-am
all-am: Makefile $(LIBRARIES) $(PROGRAMS) all-local
installdirs:
	for dir in "$(DESTDIR)$(bindir)"; do \
	  test -z "$$dir" || $(MKDIR_P) "$$dir"; \
	done
install: install-am
install-exec: install-exec-am
install-data: install-data-am
uninstall: uninstall-am

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-am
install-strip:
	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	  `test -z '$(STRIP)' || \
	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
mostlyclean-generic:

clean-generic:

distclean-generic:
	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
	-test . = "$(srcdir)" || test -z "$(CONFIG_CLEAN_VPATH_FILES)" || rm -f $(CONFIG_CLEAN_VPATH_FILES)

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
clean: clean-am

clean-am: clean-binPROGRAMS clean-checkPROGRAMS clean-generic \
	clean-noinstLIBRARIES mostlyclean-am

distclean: distclean-am
	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
	-rm -rf ./$(DEPDIR)
	-rm -f Makefile
distclean-am: clean-am distclean-compile distclean-generic \
	distclean-tags

dvi: dvi-am

dvi-am:

html: html-am

html-am:

info: info-am

info-am:

install-data-am:

install-dvi: install-dvi-am

install-dvi-am:

install-exec-am: install-binPROGRAMS

install-html: install-html-am

install-html-am:

install-info: install-info-am

install-info-am:

install-man:

install-pdf: install-pdf-am

install-pdf-am:

install-ps: install-ps-am

install-ps-am:

installcheck-am:

maintainer-clean: maintainer-clean-am
	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
	-rm -rf $(top_srcdir)/autom4te.cache
	-rm -rf ./$(DEPDIR)
	-rm -f Makefile
maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-am

mostlyclean-am: mostlyclean-compile mostlyclean-generic

pdf: pdf-am

pdf-am:

ps: ps-am

ps-am:

uninstall-am: uninstall-binPROGRAMS

.MAKE: check-am install-am install-strip

.PHONY: CTAGS GTAGS all all-am all-local am--refresh check check-TESTS \
	check-am clean clean-binPROGRAMS clean-checkPROGRAMS \
	clean-generic clean-noinstLIBRARIES ctags dist dist-all \
	dist-bzip2 dist-gzip dist-lzma dist-shar dist-tarZ dist-xz \
	dist-zip distcheck distclean distclean-compile \
	distclean-generic distclean-tags distcleancheck distdir \
	distuninstallcheck dvi dvi-am html html-am info info-am \
	install install-am install-binPROGRAMS install-data \
	install-data-am install-dvi install-dvi-am install-exec \
	install-exec-am install-html install-html-am install-info \
	install-info-am install-man install-pdf install-pdf-am \
	install-ps install-ps-am install-strip installcheck \
	installcheck-am installdirs maintainer-clean \
	maintainer-clean-generic mostlyclean mostlyclean-compile \
	mostlyclean-generic pdf pdf-am ps ps-am tags uninstall \
	uninstall-am uninstall-binPROGRAMS

fabber_DEPENDENCISE: libfabbercore.a

all-local :
	$(DOXYGEN)

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
