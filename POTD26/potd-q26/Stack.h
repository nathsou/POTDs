#pragma once

#include <cstddef>

class Stack {
 public:
  Stack();
  Stack(const Stack& other);
  ~Stack();
  Stack& operator=(const Stack& other);
  int size() const;
  bool isEmpty() const;
  void push(int value);
  int pop();

 private:
  class Node {
   public:
    Node(int data);
    int data;
    Node* prev;
  };

  unsigned len;
  Node* tail;
  void _clean();
  void _copy(const Stack& other);
  void _push(Node*& tail, int value);
  void _reverse(Node* tail, Node*& new_tail);
};