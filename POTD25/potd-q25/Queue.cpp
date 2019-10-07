#include "Queue.h"

#include <iostream>

Queue::Queue() {
  length = 0;
  capacity = 2;
  front = 0;
  data = new int[capacity];
}

void Queue::_copy(const Queue& other) {
  length = other.length;
  capacity = other.capacity;
  front = other.front;

  data = new int[capacity];
  for (unsigned i = 0; i < capacity; i++) {
    data[i] = other.data[i];
  }
}

Queue::Queue(const Queue& other) {
  _copy(other);
}

void Queue::_clean() {
  if (data != nullptr) {
    delete[] data;
  }
}

Queue::~Queue() {
  _clean();
}

Queue& Queue::operator=(const Queue& other) {
  if (this != &other) {
    _clean();
    _copy(other);
  }

  return *this;
}

// `int size()` - returns the number of elements in the stack (0 if empty)
int Queue::size() const {
  return length;
}

// `bool isEmpty()` - returns if the list has no elements, else false
bool Queue::isEmpty() const {
  return length == 0;
}

// `void enqueue(int val)` - enqueue an item to the queue in O(1) time
void Queue::enqueue(int value) {
  if (length >= capacity) {
    int new_cap = capacity * 2;
    int* new_data = new int[new_cap];
    for (unsigned i = 0; i < capacity; i++) {
      new_data[i] = data[(front + i) % capacity];
    }

    capacity = new_cap;
    delete[] data;
    data = new_data;
    front = 0;
  }

  data[(front + length) % capacity] = value;
  length++;
}

// `int dequeue()` - removes an item off the queue and returns the value in O(1) time
int Queue::dequeue() {
  length--;
  return data[front++];
}
