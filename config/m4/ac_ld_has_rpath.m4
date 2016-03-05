AC_DEFUN([AC_LD_HAS_RPATH],[

  save_libs=$LIBS
  AC_CHECK_LIB(m, main, [LD_HAS_RPATH=true], [LD_HAS_RPATH=false],
               [-Wl,-rpath -Wl,/lib])
  LIBS=$save_libs

  AC_MSG_CHECKING(whether linker supports -rpath)
  if test ${LD_HAS_RPATH} == true; then
    AC_MSG_RESULT(yes)
  else
    AC_MSG_RESULT(no)
  fi

  AC_SUBST(LD_HAS_RPATH)
])
