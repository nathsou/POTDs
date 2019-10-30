#include <iostream>
#include "potd.cpp"

using namespace std;

int main() {
  unordered_map<string, int> mapA({{"common", 13}, {"unique_a", 13}});
  unordered_map<string, int> mapB({{"common", 17}, {"unique_b", 17}});

  unordered_map<string, int> common = common_elems(mapA, mapB);

  // check your outputs here

  cout << "mapA: " << endl;
  for (auto e : mapA) {
    cout << e.first << " : " << e.second << endl;
  }

  cout << "mapB: " << endl;
  for (auto e : mapB) {
    cout << e.first << " : " << e.second << endl;
  }

  cout << "common: " << endl;
  for (auto e : common) {
    cout << e.first << " : " << e.second << endl;
  }
}
