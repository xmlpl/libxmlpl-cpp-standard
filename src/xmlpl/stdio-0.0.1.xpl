package xmlpl.stdio 0.0.1;

__native__
#include <stdio.h>
#include <fstream>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

#include <xmlpl/cpp/runtime/CuRLDataSource.h>
#include <xmlpl/cpp/runtime/IStreamDataSource.h>
#include <xmlpl/cpp/runtime/LibXML2XMLSource.h>
#include <xmlpl/cpp/runtime/LibXML2XMLStream.h>
#include <xmlpl/cpp/runtime/dom/DOMBuilder.h>

using namespace std;
__native__

void flush(node<< stream) {
  __native__
    if (XPL_stream) XPL_stream->flush();
  __native__
}

void flush(string<< stream) {
  __native__
    if (XPL_stream) XPL_stream->flush();
  __native__
}

void close(node<< &stream) {
  __native__
    if (XPL_stream) {
      XPL_stream->close();
      XPL_stream = 0;
    }
 __native__
}

void close(string<< &stream) {
  __native__
    if (XPL_stream) {
      XPL_stream->close();
      XPL_stream = 0;
    }
 __native__
}

__native__
  class StreamCloser : public Memory, public BasicFunctorBase {
    ofstream *stream;
  public:
    StreamCloser(ofstream *stream) : stream(stream) {}
    ~StreamCloser() {}

    virtual void operator()() {if (stream) stream->close();}
  };

  LibXML2XMLStream *openLibXMLStream(String url, bool disableHeader = false) {
#ifdef NO_GC
    ofstream *stream = new ofstream((const char *)url.get());
#else
    ofstream *stream = new (GC) ofstream((const char *)url.get());
#endif

    if (!stream->is_open())
      throw Exception(String("opening string stream '") + url + "'");

    LibXML2XMLStream *x = new LibXML2XMLStream(*stream, "UTF-8", disableHeader);
    x->setCloseFunctor(new StreamCloser(stream));
    return x;
  }
__native__

string<< openStringStream(string url) {
  __native__ return openLibXMLStream(XPL_url, true); __native__
}

node<< openNodeStream(string url, boolean disableHeader) {
  __native__ return openLibXMLStream(XPL_url, XPL_disableHeader); __native__
}

node<< openNodeStream(string url) {
  return openNodeStream(url, false);
}

string<< openStringStream(integer fd) {
  switch (fd) {
  case 1: __native__ return new LibXML2XMLStream(cout); __native__ break;
  case 2: __native__ return new LibXML2XMLStream(cerr); __native__ break;
  default:
    throw "Only stdout (fd=1) and stderr (fd=2) are currently supported";
  }
}

node<< openNodeStream(integer fd) {
  switch (fd) {
  case 1: __native__ return new LibXML2XMLStream(cout); __native__ break;
  case 2: __native__ return new LibXML2XMLStream(cerr); __native__ break;
  default:
    throw "Only stdout (fd=1) and stderr (fd=2) are currently supported";
  }
}

__native__
#include "string.h"
__native__

document open(string url) {
  __native__
  DataSource *input;
  __native__


  __native__
  if (strstr(XPL_url.cstr(), "://") != 0) {
    input = new CuRLDataSource(XPL_url);

  } else {

#ifdef NO_GC
    ifstream *stream = new ifstream((const char *)XPL_url.get());
#else
    ifstream *stream = new (GC) ifstream((const char *)XPL_url.get());
#endif

    if (!stream->is_open()) return 0;

    input = new IStreamDataSource(*stream);
  }

  LibXML2XMLSource *source =
    new LibXML2XMLSource(input, DOMFactory::getInstance());
  DOMBuilder *builder = new DOMBuilder(*DOMFactory::getInstance(), *source);

  return builder->adoptRoot();
  
  __native__
}

boolean exists(string filename) {
  __native__
  struct stat buf;
  return stat(XPL_filename.cstr(), &buf) == 0;
  __native__
}

boolean chdir(string path) {
  __native__
  return chdir(XPL_path.cstr()) == 0;
  __native__
}

boolean mkdir(string name, integer mode) {
  __native__
  return mkdir(XPL_name.cstr(), XPL_mode) == 0;
  __native__
}

void print(string s) {
  __native__
  puts(XPL_s.cstr());
  __native__
}

void warn(string s) {
  string w = "WARNING: " + s + "\n";
  __native__
  fputs(XPL_w.cstr(), stderr);
  __native__
}

void error(string s) {
  string e = "ERROR: " + s + "\n";
  __native__
  fputs(XPL_e.cstr(), stderr);
  __native__
}

boolean rename(string oldpath, string newpath) {
  __native__
  return rename(XPL_oldpath.cstr(), XPL_newpath.cstr()) == 0;
  __native__
}
