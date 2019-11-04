#ifndef _HASH_H
#define _HASH_H

#include <vector>
#include "Hash.h"


void doubleHashInput(std::vector<int> &v, int elem);
int firstHash(int elem, int length);
int secondHash(int elem);

#endif
