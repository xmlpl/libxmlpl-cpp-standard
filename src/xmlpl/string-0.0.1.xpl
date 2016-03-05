package xmlpl.string 0.0.1;

__native__
#include <xmlpl/cpp/runtime/Memory.h>
#include <string.h>
#include <ctype.h>
__native__

string[] tokenize(string s, string delim) {
  if (s == "") return;

  __native__
  // TODO check to see if this function is UniCode safe

  unsigned int len = strlen((const char *)XPL_s.get());
  char *s = (char *)XMLPL_MALLOC(len + 1);
  unsigned int i = 0;
  for (; i < len; i++)
    s[i] = (char)XPL_s.get()[i];
  s[i] = 0;

  char *ptr = strtok(s, (const char *)XPL_delim.get());

  while (ptr) {
    target.append(String(ptr));
    ptr = strtok(0, (const char *)XPL_delim.get());
  }
  __native__  
}

string transcode(string s, string from, string to) {
  if (length(from) != length(to))
     throw "'from' and 'to' arguments to transcode() must have same length";

  __native__
  const char *s = (const char *)XPL_s.get();
  const char *from = (const char *)XPL_from.get();
  const char *to = (const char *)XPL_to.get();

  unsigned len = strlen(s);
  unsigned chars = strlen(from);
  if (!len || !chars) return XPL_s;

  char *result = (char *)XMLPL_MALLOC(len + 1);

  for (unsigned i = 0; i < len; i++) {
    result[i] = s[i];
    for (unsigned j = 0; j < chars; j++)
      if (s[i] == from[j]) result[i] = to[j];
  }

  return String(result);
  __native__
}

string join(string []s, string delim) {
  string result;

  integer len = size(s);
  integer i = 0;
  foreach (s) {
    if (i++) result += delim;
    result += .;
  }

  return result;
}

string upcase(string s) {
  __native__
  unsigned int len = strlen((const char *)XPL_s.get());
  char *s = (char *)XMLPL_MALLOC(len + 1);

  unsigned int i = 0;
  for (; i < len; i++)
    s[i] = toupper((char)XPL_s[i]);

  s[i] = 0;

  return String(s);
  __native__
}

string downcase(string s) {
  __native__
  unsigned int len = strlen((const char *)XPL_s.get());
  char *s = (char *)XMLPL_MALLOC(len + 1);

  unsigned int i = 0;
  for (; i < len; i++)
    s[i] = tolower((char)XPL_s[i]);

  s[i] = 0;

  return String(s);
  __native__
}

integer atoi(string s) {
  __native__
  return strtoll(XPL_s.cstr(), 0, 0);
  __native__
}

real ator(string s) {
  __native__
  return strtod(XPL_s.cstr(), 0);
  __native__
}

string trim(string s) {
  __native__
  const char *s = XPL_s.cstr();
  int start = 0;
  int len = strlen(s);

  if (!len) return s;

  while (isspace(s[start])) start++;
  if (start == len) return String();

  int end = len - 1;
  while (isspace(s[end])) end--;

  if (start != 0 || end != len - 1)
    return String(s + start, end - start + 1);
  __native__

  return s;
}

string right(string s, integer len);

string left(string s, integer len) {
  if (len == 0) return null;
  integer sLen = length(s);
  if (sLen <= len) return s;
  if (len < 0) return right(s, sLen + len);

  __native__
  return String(XPL_s.get(), XPL_len);
  __native__
}

string right(string s, integer len) {
  if (len == 0) return null;
  integer sLen = length(s);
  if (sLen <= len) return s;
  if (len < 0) return left(s, sLen + len);

  __native__
    return String(&(XPL_s.get()[XPL_s.length() - XPL_len]), true);
  __native__
}

string mid(string s, integer start, integer end) {
  if (end <= start) return null;
  integer sLen = length(s);

  return left(right(s, sLen - start), end - start);
}

string concat(string[] strings, string delim) {
  string result;
  boolean first = true;

  foreach (strings) {
    if (first) first = false;
    else result += delim;
    result += .;
  }

  return result;
}

string concat(string[] strings) {
  return concat(strings, "");
}

boolean contains(string haystack, string needle) {
  __native__
  return strstr(XPL_haystack.cstr(), XPL_needle.cstr()) != 0;
  __native__
}
