#include "potd.h"
#include <iostream>
using namespace std;

int main() {
  // Test 1: An empty list
  Node * head = NULL;
  cout << stringList(head) << endl;

  // Test 2: A list with exactly one node
  Node first = {17, head};

  cout << stringList(&first) << endl;

  // Test 3: A list with more than one node
  Node second = {33, &first};
  Node third = {21, &second};

  cout << stringList(&third) << endl; 

  return 0;
}
