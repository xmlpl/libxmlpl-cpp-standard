# Disable caching
define([AC_CACHE_LOAD], )
define([AC_CACHE_SAVE], )

# Init
AC_PREREQ(2.59)
AC_INIT([libxmlpl-cpp-standard], 0.1.5, bugs@xmlpl.org)
AC_CONFIG_SRCDIR([config.h.in])
AC_CONFIG_AUX_DIR(./config)

AM_INIT_AUTOMAKE([nostdinc])
AM_CONFIG_HEADER(config.h)


# Flags
AC_COMPILE_FLAGS


# Tools
AC_PROG_CPP
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AC_LANG_CPLUSPLUS
AC_PROG_CXX
AC_PROG_CXXCPP
AC_PROG_INSTALL
AM_PROG_LIBTOOL

# Headers
AC_HEADER_STDC
AC_CHECK_HEADERS([stdlib.h string.h unistd.h])


# Typedefs, structures, and compiler characteristics
AC_HEADER_STDBOOL
AC_C_CONST
AC_C_INLINE


# Standard library functions
AC_FUNC_ERROR_AT_LINE
AC_CHECK_FUNCS([strchr strdup])


# Test install -C option
touch install.test
if $INSTALL -C install.test install.test2 >/dev/null 2>/dev/null; then
  INSTALL="${INSTALL} -C"
fi
rm -f install.test install.test2


# libcurl
AC_CHECK_LIB(curl, curl_escape, [true], [
  AC_MSG_ERROR([Could not link required library libcurl!])
])

# XmlPL C++ Runtime
AC_CHECK_CONFIG(libxmlpl_cpp_runtime, $VERSION, , [AC_MSG_ERROR([Required library libxmlpl_cpp_runtime not found!])])
AC_CHECK_LIB(xmlpl_cpp_runtime, main, [true], [
  AC_MSG_ERROR([Could not link required library libxmlpl_cpp_runtime!])],
  [$libxmlpl_cpp_runtime_LIBS])

# XmlPL Compiler
AC_CHECK_CONFIG(xmlplcc, $VERSION, , [AC_MSG_ERROR([Required program xmlplcc not found!])])
XMLPLCC=${xmlplcc_PREFIX}/bin/xmlplcc
AC_SUBST(XMLPLCC)


# Create Makefiles
AC_OUTPUT([Makefile
	  src/Makefile
	  src/xmlpl/Makefile
          scripts/Makefile
          scripts/libxmlpl_cpp_standard-config
	  ], [chmod +x scripts/libxmlpl_cpp_standard-config]
         )

echo
echo
echo "   Everything seems to be ok."
echo "Now run 'make' and 'make install'."
echo
echo
