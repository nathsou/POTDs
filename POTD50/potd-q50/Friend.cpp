#include "Friend.h"
using namespace std;

int find(int x, std::vector<int>& parents) { return 0; }

int findCircleNum(std::vector<std::vector<int>>& M) {
  vector<int> sets;

  for (unsigned i = 0; i < M.size(); i++) sets.push_back(-1);

  for (unsigned i = 0; i < M.size(); i++) {
    for (unsigned j = 0; j < M[i].size(); j++) {
      if (M[i][j] == 1) {
        int a = i;
        int b = j;
        while (sets[a] >= 0) a = sets[a];
        while (sets[b] >= 0) b = sets[b];
        int new_size = sets[a] + sets[b];
        if (sets[a] <= sets[b]) {
          sets[b] = a;
          sets[a] = new_size;
        } else {
          sets[a] = b;
          sets[b] = new_size;
        }
      }
    }
  }

  int res = 0;
  for (auto i : sets) {
    if (i < 0) res++;
  }

  return res;
}
