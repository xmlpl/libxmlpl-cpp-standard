package xmlpl.process 0.0.1;

__native__
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <ext/stdio_filebuf.h> // NOTE: This only works in GCC 3.2 and newer

#include <xmlpl/cpp/runtime/Exception.h>
#include <xmlpl/cpp/runtime/LibXML2XMLSource.h>
#include <xmlpl/cpp/runtime/dom/DOMBuilder.h>

using namespace std;
__native__

integer system(string command) {
  __native__
    return system((const char *)XPL_command.get());
  __native__
}

(: TODO this function should return the pid and pass document by ref. :)
document systemXML(string command) {
  __native__
  int argc = 0;
  char *argv[4];

  argv[argc++] = (char *)"/bin/sh";
  argv[argc++] = (char *)"-c";
  argv[argc++] = (char *)XPL_command.get();
  argv[argc] = 0;

  int pipeFDs[2];

  // TODO get line and column info
  if (pipe(pipeFDs)) throw Exception("couldn't create pipe", 0, 0);

  int pid = fork();

  if (pid == 0) {
    // Close out
    close(pipeFDs[0]);

    // Duplicate pipe fd to fd 1
    if (dup2(pipeFDs[1], 1) != 1) {
      perror("failed to copy child process file descriptor");
      exit(1);
    }

    // Close copy of pipe fd
    close(pipeFDs[1]);

    execvp(argv[0], argv);

    perror("failed to execute child process");
    exit(1);

  } else if (pid == -1) throw Exception("failed to spawn child process", 0, 0);

  // Close in
  close(pipeFDs[1]);

  // C file descriptor to C++ streams magic
  // NOTE: This only works in GCC 3.2 and newer
  //       Hopefully they will leave the API alone now!

#ifdef NO_GC
  __gnu_cxx::stdio_filebuf<char> *pipeBuf =
    new __gnu_cxx::stdio_filebuf<char>(fdopen(pipeFDs[0], "r"), ios::in);

  istream *stream = new istream(pipeBuf);
  IStreamDataSource *input = new IStreamDataSource(*stream);

#else
  __gnu_cxx::stdio_filebuf<char> *pipeBuf =
    new (GC) __gnu_cxx::stdio_filebuf<char>(fdopen(pipeFDs[0], "r"), ios::in);

  istream *stream = new (GC) istream(pipeBuf);
  IStreamDataSource *input = new (GC) IStreamDataSource(*stream);
#endif

  LibXML2XMLSource *source =
    new LibXML2XMLSource(input, DOMFactory::getInstance());
  DOMBuilder *builder = new DOMBuilder(*DOMFactory::getInstance(), *source);

  return builder->adoptRoot();
  __native__
}
