#pragma once

#include <cstddef>
#include <iostream>
using namespace std;

class HuffmanNode {
    public:
        HuffmanNode *left_;
        HuffmanNode *right_;
        char char_;
        HuffmanNode();
};
