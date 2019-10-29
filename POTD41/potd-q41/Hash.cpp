#include "Hash.h"
#include <iostream>
#include <string>

unsigned long bernstein(std::string str, int M) {
  unsigned long b_hash = 5381;

  for (const char& c : str) {
    b_hash = b_hash * 33 + int(c);
  }

  return b_hash % M;
}

std::string reverse(std::string str) {
  std::string output = "";

  for (int i = str.size() - 1; i >= 0; i--) {
    output += str[i];
  }

  return output;
}
