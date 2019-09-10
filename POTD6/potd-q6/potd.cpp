#include "potd.h"
#include <cmath>

int *potd::raise(int *arr) {

    // compute the length of the array
    unsigned len = 1; // the final negative number
    for (unsigned i = 0; arr[i] > 0; i++) {
        len++;
    }

    int *raised = new int[len];
    for (unsigned i = 0; i < len; i++) {
        if (len >= 2 && i < len - 2) {
            raised[i] = std::pow(arr[i], arr[i + 1]);
        } else {
            raised[i] = arr[i];
        }
    }

    return raised;
}