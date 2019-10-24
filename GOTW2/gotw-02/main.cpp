#include "pet.h"
#include "rock.h"

int main() {
    Pet *pepe = new Pet("Pepe");
    Rock *rock = new Rock();

    pepe->eat();
    pepe->speak();
    rock->eat();
    rock->speak();

    while(!rock->isOld()) {
        rock->growUp();
    }

    while(!pepe->isOld()) {
        pepe->growUp();
    }

    delete pepe;
    delete rock;

    return 0;
}
