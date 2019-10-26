#include "Hash.h"
#include <string>
#include <vector>

using namespace std;

int hashFunction(string s, int M) {
  // hash function to sum up the ASCII characters of the letters of the string

  int sum = 0;

  for (char c : s) sum += c;

  return sum % M;
}

int countCollisions(int M, vector<string> inputs) {
  int collisions = 0;

  bool* occupied = new bool[M];

  for (int i = 0; i < M; i++) occupied[i] = false;

  for (const string& str : inputs) {
    int idx = hashFunction(str, M);
    if (!occupied[idx]) {
      occupied[idx] = true;
    } else {
      collisions++;
    }
  }

  delete[] occupied;

  return collisions;
}
