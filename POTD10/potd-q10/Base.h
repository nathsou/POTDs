#pragma once
#include <string>

class Base {
    public:
    std::string foo();
    virtual std::string bar();
    virtual ~Base();
};