#include "Stack.h"

Stack::Stack() {
  len = 0;
  tail = nullptr;
}

// `int size()` - returns the number of elements in the stack (0 if empty)
int Stack::size() const { return len; }

// `bool isEmpty()` - returns if the list has no elements, else false
bool Stack::isEmpty() const { return len == 0; }

// `void push(int val)` - pushes an item to the stack in O(1) time
void Stack::push(int value) {
  _push(tail, value);
  len++;
}

// `int pop()` - removes an item off the stack and returns the value in O(1)
// time
int Stack::pop() {
  Node* tmp = tail->prev;
  int val = tail->data;
  if (tail != nullptr) delete tail;
  tail = tmp;
  len--;

  return val;
}

Stack::Node::Node(int value) {
  prev = nullptr;
  data = value;
}

void Stack::_clean() {
  Node* curr = tail;
  while (curr != nullptr) {
    Node* prev = curr->prev;
    delete curr;
    curr = prev;
  }
}

void Stack::_copy(const Stack& other) {
  len = other.len;
  Node* curr = nullptr;
  tail = nullptr;
  Node* curr_other = other.tail;
  while (curr_other != nullptr) {
    Node* prev = curr_other->prev;
    _push(curr, curr_other->data);
    if (tail == nullptr) tail = curr;
    curr_other = prev;
  }
}

void Stack::_push(Node*& tail, int value) {
  Node* new_node = new Node(value);
  new_node->prev = tail;
  tail = new_node;
}

Stack::~Stack() { _clean(); }

Stack::Stack(const Stack& other) { _copy(other); }

Stack& Stack::operator=(const Stack& other) {
  if (this != &other) {
    _clean();
    _copy(other);
  }

  return *this;
}