#include "rock.h"

Rock::Rock() {
  name_ = "Rock";
  hasAged_ = false;
  timelineRevealed_ = false;
  allForms_ = {new Form("Pebble", false), new Form("Rock", true),
               new Form("Boulder", false), new Form("Dust", true)};
}

Rock::~Rock() {
  for (Form* form : allForms_) {
    delete form;
  }
}

void Rock::eat() {
  std::cout << "What are you doing? I'm a rock." << std::endl;
}

void Rock::sleep() { std::cout << "Gems don't need to sleep." << std::endl; }

void Rock::speak() { std::cout << ".\n.\n.\n"; }

bool Rock::isOld() { return timelineRevealed_; }

void Rock::growUp() {
  if (!hasAged_) {
    std::cout << "Rock has evolved into Boulder!" << std::endl;
    name_ = "Boulder";
    hasAged_ = true;
  } else {
    std::cout << "Boulder cannot evolve into anything further. Boulder can "
                 "only devolve now."
              << std::endl;
    std::cout << "We can, however, list all of it's previous forms:"
              << std::endl;

    for (size_t i = 0; i < allForms_.size(); i++) {
      Form* form = allForms_[i];
      std::cout << std::to_string(i + 1) + ": " +
                       (form->isSuperDuper_ ? *form->superFormName_
                                            : form->formName_)
                << std::endl;
    }

    timelineRevealed_ = true;
  }
}
