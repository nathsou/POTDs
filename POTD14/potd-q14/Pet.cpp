// Pet.cpp
#include "Pet.h"

Pet::Pet(): Animal(), name_("Fluffy"), owner_name_("Cinda") {}

Pet::Pet(std::string type, std::string food, std::string name, std::string owner_name):
    Animal(type, food), name_(name), owner_name_(owner_name) {}

std::string Pet::getName() {
    return name_;
}

std::string Pet::getOwnerName() {
    return owner_name_;
}

void Pet::setName(std::string name) {
    name_ = name;
}

void Pet::setOwnerName(std::string name) {
    owner_name_ = name;
}

std::string Pet::print() {
    return "My name is " + name_;
}