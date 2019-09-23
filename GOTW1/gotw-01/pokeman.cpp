#include "pokeman.h"

Pokeman::Pokeman(int x) {
    strength = x;
    defense = x;
    speed = x; 
    health = x + 5;
}


Pokeman::Pokeman(int s, int d, int sp, int h) {
    strength = s;
    defense = d;
    speed = sp;
    health = h;
}


Pokeman Pokeman::createPokeman() {
    Pokeman p = Pokeman(1000, 1000, 1000, 5000);
    return p;
}


void Pokeman::takeDamage(int d) {
    if (health == 0) {
        std::cout << "Your Pokeman has fainted! :(" << std::endl;
        return;
    }

    std::cout << "Your Pokeman took " << d << " pts of damage!" << std::endl;
    health -= d;
}


int Pokeman::fight(Pokeman e) {
    int damage = strength - e.strength;

    if (damage > 0) {
        damage += 1;
    } else {
        damage = 1;
    }

    std::cout << "Your Pokeman does " << damage << " pts of damage!" << std::endl;
    return damage;
}


void Pokeman::defend(Pokeman e) {
    int shield = defense - e.defense;

    if (shield > 0) {
        std::cout << "Your Pokeman defends itself." << std::endl;
        return;
    } else {
        takeDamage(-1 * shield);
    }
}


bool Pokeman::run(Pokeman e) {
    if (speed > e.speed) std::cout << "When danger reared it's ugly head, \nYou bravely turned your tail and fled..." << std::endl;
    else std::cout << "Your Pokeman stands its ground." << std::endl;
    return speed > e.speed;
}


void Pokeman::stats() {
    std::cout << "--- Pokeman Stats ---";
    std::cout << "\n- Strength: " << strength;
    std::cout << "\n- Defense: " << defense;
    std::cout << "\n- Speed: " << speed;
    std::cout << "\n- Health: " << health << std::endl;
}
