EXTRA_DIST =\
	math-0.0.1.xpl\
	process-0.0.1.xpl\
	stdio-0.0.1.xpl\
	stdlib-0.0.1.xpl\
	string-0.0.1.xpl\
	unistd-0.0.1.xpl\
	gen-0.0.1.xpl\
	xml-0.0.1.xpl\
	curl-0.0.1.xpl\
        time-0.0.1.xpl\
        dirent-0.0.1.xpl

xmlpldir = @libdir@/xmlpl/xmlpl

lib_XMLPL =\
	libstring-0.0.1.la\
	libprocess-0.0.1.la\
	libunistd-0.0.1.la\
	libstdio-0.0.1.la\
	libstdlib-0.0.1.la\
	libmath-0.0.1.la\
	libgen-0.0.1.la\
	libxml-0.0.1.la\
	libcurl-0.0.1.la\
	libtime-0.0.1.la\
	libdirent-0.0.1.la

CLEANFILES = $(lib_XMLPL)

all: $(lib_XMLPL)

lib%.la: %.xpl @XMLPLCC@
	@XMLPLCC@ --save-temps -l -L -rpath -L $(xmlpldir) $<

clean-local:
	rm -f *.o *.cpp

install-data-local:
	for i in $(lib_XMLPL); do\
	  $(LIBTOOL) --mode=install $(INSTALL) -D $$i $(xmlpldir)/$$i;\
	done
