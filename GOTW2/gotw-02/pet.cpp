#include "pet.h"

/*
 * Program has some helper functions.
 */

Pet::Pet() {
  age_ = 0;
  name_ = "Compadre";
}

Pet::Pet(std::string n) {
  age_ = 0;
  name_ = n;
}

int Pet::getAge() { return age_; }

int Pet::getGender() { return gender_; }

std::string Pet::getName() { return name_; }

bool Pet::isOld() { return age_ > 90; }

/* Determine's Pepe's current growth cycle */
void Pet::growUp() {
  if (age_ < 20) {
    firstAgeStage();
  } else if (age_ < 50) {
    secondAgeStage();
  } else if (age_ < 90) {
    thirdAgeStage();
  } else {
    finalAgeStage();
  }
}

/* Increments age by 7 days */
void Pet::firstAgeStage() {
  std::cout << name_ << " is young and growing quickly!" << std::endl;
  age_ += 7;
}

/* Increments age by 5 days */
void Pet::secondAgeStage() {
  std::cout << name_ << " is mature and productive!" << std::endl;
  age_ += 5;
}

/* Increments age by 10 days */
void Pet::thirdAgeStage() {
  std::cout << name_ << " loves blankets and comfort!" << std::endl;
  age_ += 10;
}

/* Increments age by 1 day */
void Pet::finalAgeStage() {
  std::cout << name_ << " has been a wonderful pet!" << std::endl;
  age_ += 1;
}

void Pet::eat() {
  std::cout << name_ << " is consuming something edible." << std::endl;
}

void Pet::sleep() { std::cout << "Only humans need to rest." << std::endl; }

void Pet::speak() { std::cout << "Moo I'm a duck." << std::endl; }
