SUBDIRS=src scripts
DIST_SUBDIRS = $(SUBDIRS)
ACLOCAL_AMFLAGS = -I config/m4
EXTRA_DIST = autogen.sh config/m4 debian

mostlyclean-generic: tidy

dist-hook:
	rm -rf `find $(distdir) -name CVS -o -name .svn`

tidy:
	-rm -f `find . -name '#*' -o -name '.\#*'\
	  -o -name '.*~' -o -name '*~' -o -name 'core*'`

maintainer-clean-generic:
	-rm -rf core `find . -name '.deps' -o -name 'autom4te*.cache'`
