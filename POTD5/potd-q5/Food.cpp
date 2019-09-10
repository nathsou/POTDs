#include "Food.h"

Food::Food() {
    name_ = "Banana splits";
    quantity_ = 2;
}

std::string Food::get_name() {
    return name_;
}

unsigned Food::get_quantity() {
    return quantity_;
}

void Food::set_name(std::string name) {
    name_ = name;
}

void Food::set_quantity(unsigned quantity) {
    quantity_ = quantity;
}