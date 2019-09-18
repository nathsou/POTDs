// Animal.cpp

#include "Animal.h"

Animal::Animal() {
    type = "cat";
    food_ = "fish";
}

Animal::Animal(std::string type_, std::string food) {
    type = type_;
    food_ = food;
}

void Animal::setType(std::string type_) {
    type = type_;
}

void Animal::setFood(std::string food) {
    food_ = food;
}

std::string Animal::getType() {
    return type;
}

std::string Animal::getFood() {
    return food_;
}

std::string Animal::print() {
    return "I am a " + type;
}