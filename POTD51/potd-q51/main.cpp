#include <iostream>
#include <vector>
#include "potd.h"
using namespace std;

int main() {
  vector<string> ret = topThree("./in1.txt");

  for (string str : ret) {
    cout << str << endl;
  }

  return 0;
}
