#include <cmath>
#include "MinHeap.h"

vector<int> lastLevel(MinHeap& heap) {
  vector<int> leafs;

  int size = pow(2.0, ceil(log2(heap.elements.size())));

  for (size_t i = size / 2; i < heap.elements.size(); i++) {
    leafs.push_back(heap.elements[i]);
  }

  return leafs;
}
