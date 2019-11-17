#include <iostream>
#include <vector>
#include "Primes.h"

int main() {
  std::vector<int>* primes = genPrimes(1000);

  for (int i = 2; i < 1000; i++) {
    std::cout << i << " has " << numSequences(primes, i) << " sequence(s)."
              << std::endl;
  }

  return 0;
}
