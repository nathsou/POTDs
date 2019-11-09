#include <iostream>
#include <sstream>
#include <string>
#include "Pattern.h"

int main() {
  std::string s1 = "dog cat cat cat cat cat cat cat dog";
  std::string p1 = "abbbbbbba";
  std::string s2 = "fish dog dog dog dog dog dog cat";
  std::string p2 = "abbbbbba";
  std::string s3 = "dog cat cat dog";
  std::string p3 = "aaaa";
  std::string s4 = "dog dog dog dog";
  std::string p4 = "abba";

  std::cout << " The pattern p1 matches string s1 " << wordPattern(p1, s1)
            << std::endl;
  std::cout << " The pattern p2 matches string s2 " << wordPattern(p2, s2)
            << std::endl;
  std::cout << " The pattern p3 matches string s3 " << wordPattern(p3, s3)
            << std::endl;
  std::cout << " The pattern p4 matches string s4 " << wordPattern(p4, s4)
            << std::endl;

  return 0;
}
