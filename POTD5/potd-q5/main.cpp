#include "q5.h"
#include <iostream>

int main(void) {
    Food *split = new Food();
    std::cout << "You have " << split->get_quantity() << " " << split->get_name() << "." << std::endl;
    increase_quantity(split);
    std::cout << "You have " << split->get_quantity() << " " << split->get_name() << "." << std::endl;
    return 0;
}