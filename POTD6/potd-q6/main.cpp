#include <iostream>
#include "potd.h"

int main() {
    int x[5] = {1,2,3,4,-1};

    for(int i=0; x[i] != -1; i++)
        std::cout << x[i] << " ";
    std::cout << std::endl;

    int *y = potd::raise(x);

    for(int i=0; y[i] != -1; i++)
        std::cout << y[i] << " ";
    std::cout << std::endl;
}
