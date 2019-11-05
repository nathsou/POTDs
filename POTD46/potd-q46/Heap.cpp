#include "Heap.h"
#include <iostream>

int maxChildIdx(int idx, std::vector<int> &data) {
  int left = data[2 * idx];
  int right = data[2 * idx + 1];

  if (left > right) return 2 * idx;
  return 2 * idx + 1;
}

void Heap::_percolateDown(int hole) {
  // your code here

  if ((unsigned long)(2 * hole) >= _data.size()) return;  // leaf

  int max_child = maxChildIdx(hole, _data);

  if (_data[hole] < _data[max_child]) {
    std::swap(_data[max_child], _data[hole]);
    _percolateDown(max_child);
  }
}

int Heap::size() const { return _data.size(); }

void Heap::enQueue(const int &x) {
  _data.push_back(x);
  int hole = _data.size() - 1;
  for (; hole > 1 && x > _data[hole / 2]; hole /= 2) {
    _data[hole] = _data[hole / 2];
  }
  _data[hole] = x;
}

int Heap::deQueue() {
  int minItem = _data[1];
  _data[1] = _data[_data.size() - 1];
  _data.pop_back();
  _percolateDown(1);
  return minItem;
}

void Heap::printQueue() {
  std::cout << "Current Priority Queue is: ";
  for (auto i = _data.begin() + 1; i != _data.end(); ++i) {
    std::cout << *i << " ";
  }
  std::cout << std::endl;
}

std::vector<int> &Heap::getData() { return _data; }
