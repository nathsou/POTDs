#include "potd.h"

double sum(vector<double>::iterator start, vector<double>::iterator end) {
    double sum = 0;
    for (auto it = start; it != end; ++it) {
        sum += *it;
    } 

    return sum;
}

vector<double>::iterator max_iter(vector<double>::iterator start, vector<double>::iterator end) {
    vector<double>::iterator max_it = start;
    for (auto it = start; it != end; ++it) {
        if (*it > *max_it) {
            max_it = it;
        }
    }

    return max_it;
}

void sort_vector(vector<double>::iterator start, vector<double>::iterator end) {
    for (auto it = start; it != end; ++it) {
        auto max_it = max_iter(it, end);
        double max = *max_it; 
        *max_it = *it;
        *it = max;
    }
}