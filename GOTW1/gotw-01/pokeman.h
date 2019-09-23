#pragma once

#include <stdlib.h>
#include <iostream>

class Pokeman {
    public:
       Pokeman(int x);
       Pokeman(int s, int d, int sp, int h);
       static Pokeman createPokeman();
       int fight(Pokeman e);
       bool run(Pokeman e);
       void defend(Pokeman e);
       void stats();

    private:
       void takeDamage(int d);
       int strength;
       int defense;
       int speed;
       int health;
};
