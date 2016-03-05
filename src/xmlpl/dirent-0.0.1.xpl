package xmlpl.dirent 0.0.1;

__native__
#include <dirent.h>
#include <errno.h>
__native__


:: TODO add stat() capiblity with 'readdir(string name, boolean stat)'

node[] readdir(string name) {
  <directory name=(name)>
    integer errno;
    string fname;
    string type;

    __native__
    DIR *dir = opendir(XPL_name.cstr());
    if (!dir) {
      __native__
      throw "Failed to open directory '" + name + "'";
      __native__
    }

    while (1) {
      errno = 0;
      struct dirent *entry = readdir(dir);

      if (!entry) {
        closedir(dir);
        dir = 0;

        if (errno) {
          XPL_errno = errno;

          __native__
          throw "Failed error while reading directory '" + name + "': " + errno;
          __native__

        } else break;
      }

      XPL_fname = String(entry->d_name, true);
      switch (entry->d_type) {
      case DT_BLK:     XPL_type = "block";   break;
      case DT_CHR:     XPL_type = "char";    break;
      case DT_DIR:     XPL_type = "dir";     break;
      case DT_FIFO:    XPL_type = "fifo";    break;
      case DT_LNK:     XPL_type = "link";    break;
      case DT_REG:     XPL_type = "file";    break;
      case DT_SOCK:    XPL_type = "socket";  break;
      default:         XPL_type = "unknown"; break;
      }

      __native__
      <entry name=(fname) type=(type)/>
      __native__
    }

    closedir(dir);
    __native__
  </directory>
}
