package xmlpl.gen 0.0.1;

__native__
#include <libgen.h>
__native__

string dirname(string path) {
  __native__
  String p = String(XPL_path, true);
  return String(dirname((char *)p.cstr()));
  __native__
}

string basename(string path) {
  __native__
  String p = String(XPL_path, true);
  return String(basename((char *)p.cstr()));
  __native__
}
