#include "Primes.h"
#include <vector>

std::vector<int> *genPrimes(int M) {
  std::vector<int> *v = new std::vector<int>();
  std::vector<int> *t = new std::vector<int>(M);
  int i = 0;
  int nextPrime = 2;

  for (i = 0; i < M; i++) (*t)[i] = 1;

  (*t)[0] = 0;
  (*t)[1] = 0;

  v->push_back(2);

  while (nextPrime < M) {
    for (i = nextPrime * nextPrime; i < M; i += nextPrime) (*t)[i] = 0;
    for (++nextPrime; nextPrime < M; nextPrime++)
      if ((*t)[nextPrime] == 1) {
        v->push_back(nextPrime);
        break;
      }
  }

  delete t;
  return v;
}

bool isValidSeq(std::vector<int> *primes, int n, int first_idx) {
  int sum = 0;
  for (int i = first_idx; i < (int)primes->size(); i++) {
    sum += primes->at(i);
    if (sum == n) return true;
    if (sum > n) break;
  }

  return false;
}

int numSequences(std::vector<int> *primes, int n) {
  int seqs = 0;

  for (int i = 0; i < (int)primes->size(); i++) {
    int p = (*primes)[i];
    if (p > n) break;
    if (isValidSeq(primes, n, i)) seqs++;
  }

  return seqs;
}
