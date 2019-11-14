#include <iostream>
#include <vector>
#include "Primes.h"

int main() {
    std::vector<int> * primes = genPrimes(1000);

    std::cout << "The 3rd prime is " << (*primes)[2] << std::endl;
    std::cout << "The 100th prime is " << (*primes)[99] << std::endl;
    std::cout << "The largest prime below 1000 is " << primes->back() << std::endl;

    return 0;
}
