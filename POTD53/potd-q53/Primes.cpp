#include "Primes.h"
#include <vector>

bool isPrime(int n, std::vector<int> &smaller_primes) {
  for (int p : smaller_primes) {
    if (n % p == 0) return false;
  }

  return true;
}

std::vector<int> *genPrimes(int M) {
  std::vector<int> *v = new std::vector<int>();
  v->push_back(2);

  for (int n = 3; n <= M; n += 2) {
    if (isPrime(n, *v)) {
      v->push_back(n);
    }
  }

  return v;
}
