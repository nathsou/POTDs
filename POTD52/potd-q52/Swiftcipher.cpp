#include "Swiftcipher.h"
#include <fstream>
#include <iostream>
#include <map>
#include <string>
using namespace std;

/* Swift Cipher: Frequency of words in a file corresponds to its location in the
 * decrypted sentence */
string decipherer(string filename) {
  map<string, int> freqs;
  int words = 0;
  string line;
  ifstream infile(filename);
  if (infile.is_open()) {
    while (getline(infile, line)) {
      int count = 0;
      if (freqs.find(line) != freqs.end()) {
        count = freqs[line];
      } else {
        words++;
      }

      freqs[line] = count + 1;
    }
  }

  infile.close();

  string msg = "";

  for (int i = 0; i <= words; i++) {
    for (auto entry : freqs) {
      if (entry.second == i) {
        msg += entry.first;
        if (i < words) {
          msg += " ";
        }
      }
    }
  }

  return msg;
}
