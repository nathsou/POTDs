#include "Hash.h"
#include <vector>

void doubleHashInput(std::vector<int> &v, int elem) {
  // your code here

  int idx = firstHash(elem, v.size());
  int step = secondHash(elem);

  while (v[idx] != -1) {
    idx = (idx + step) % v.size();
  }

  v[idx] = elem;
}

// make a hash function called firstHash

int firstHash(int elem, int length) { return (elem * 4) % length; }

// make a second function called secondHash

int secondHash(int elem) { return 3 - (elem % 3); }