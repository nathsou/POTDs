// Animal.h
#pragma once
#include <string>

class Animal {
    private:
        std::string type;
    public:
        Animal();
        Animal(std::string type, std::string food);
        std::string food_;
        std::string getType();
        std::string getFood();
        void setType(std::string type_);
        void setFood(std::string food);
        virtual std::string print();
};