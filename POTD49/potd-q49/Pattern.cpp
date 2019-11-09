#include "Pattern.h"
#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

bool wordPattern(std::string pattern, std::string str) {
  std::vector<std::string> words;
  std::unordered_map<char, std::string> bijection;
  std::unordered_set<std::string> used_words;

  // split str into individual words
  std::string word;
  for (char c : (str + ' ')) {
    if (c == ' ') {
      words.push_back(word);
      word = "";
    } else {
      word += c;
    }
  }

  if (words.size() != pattern.length()) return false;

  // try to find a bijection between the letters and the words
  for (unsigned i = 0; i < words.size(); i++) {
    char c = pattern[i];
    std::string word = words[i];

    if (bijection.find(c) == bijection.end()) {
      if (used_words.find(word) != used_words.end()) return false;
      //   std::cout << c << " --> " << word << std::endl;
      bijection[c] = word;
      used_words.insert(word);
    } else {
      //   std::cout << c << " =? " << word << std::endl;
      if (bijection[c] != word) return false;
    }
  }

  return true;
}
