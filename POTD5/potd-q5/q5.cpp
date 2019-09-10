#include "q5.h"

void increase_quantity(Food *food) {
    food->set_quantity(food->get_quantity() + 1);
}