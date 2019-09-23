#include <stdlib.h>
#include <iostream>

#include "pokeman.h"

int main() {
    Pokeman charmanda(40, 30, 15, 50);
    Pokeman squirrel(25, 35, 20, 35);

    charmanda.fight(squirrel);
    charmanda.defend(squirrel);
    charmanda.run(squirrel);

    std::cout << "Creating a new Pokeman..." << std::endl;
    Pokeman mystery = Pokeman::createPokeman();
    mystery.stats();
    
    std::cout << "Can you do that again?" << std::endl;
    mystery.stats();

    squirrel.fight(charmanda);
    squirrel.defend(charmanda);
    squirrel.run(charmanda);

    mystery.stats();
}
