#pragma once

#include <stdlib.h>
#include <iostream>
#include <string>

class Pet {
    public:
        Pet();
        Pet(std::string n);
        int getAge();
        int getGender();
        std::string getName();
        bool isOld();
        void eat();
        void sleep();
        void speak();
        void growUp();
        void firstAgeStage();
        void secondAgeStage();
        void thirdAgeStage();
        void finalAgeStage();

    protected:
        int age_;
        int gender_;
        std::string name_;
        std::string owner_;
};
