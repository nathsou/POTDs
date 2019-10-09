#include "potd.h"

string getFortune(const string& s) {
  string fortunes[] = {"As you wish!", "Do, or do not. There is no try.",
                       "This fortune intentionally left blank.", "Amor Fati!",
                       "Nec spe nec metu!"};

  return fortunes[s.length() % 5];
}