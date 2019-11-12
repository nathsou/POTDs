#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>
using namespace std;

vector<string> topThree(string filename) {
  map<string, int> freqs;
  string line;
  ifstream infile(filename);
  vector<string> ret;
  if (infile.is_open()) {
    while (getline(infile, line)) {
      int count = 0;
      if (freqs.find(line) != freqs.end()) {
        count = freqs[line];
      }

      freqs[line] = count + 1;
    }
  }

  infile.close();

  // selection sort
  for (int i = 0; i < 3; i++) {
    int max = -1;
    string max_str;
    for (auto entry : freqs) {
      if (entry.second > max) {
        max = entry.second;
        max_str = entry.first;
      }
    }

    ret.push_back(max_str);
    freqs.erase(max_str);
  }

  return ret;
}
