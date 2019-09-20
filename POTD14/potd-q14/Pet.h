// Pet.h
#pragma once
#include "Animal.h"
#include <string>

class Pet : public Animal {
    private:
    std::string name_;
    std::string owner_name_;
    public:
    Pet();
    Pet(std::string type, std::string food, std::string name, std::string owner_name);
    std::string getName();
    std::string getOwnerName();
    void setName(std::string name);
    void setOwnerName(std::string name);
    std::string print();
};