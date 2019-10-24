#pragma once

#include <algorithm>
#include <string>
#include <vector>
#include "pet.h"

class Rock : public Pet {
  struct Form {
    Form(std::string name, bool isSuper)
        : formName_(name), isSuperDuper_(isSuper) {
      if (isSuper) superFormName_ = new std::string(superfy(name));
    };
    std::string superfy(std::string s) {
      std::transform(s.begin(), s.end(), s.begin(), ::toupper);
      return s;
    };

    std::string formName_;
    std::string* superFormName_ = NULL;
    bool isSuperDuper_;

    ~Form() {
      if (superFormName_ != NULL) {
        delete superFormName_;
      }
    }
  };

 public:
  Rock();
  ~Rock();
  bool isOld();
  void eat();
  void sleep();
  void speak();
  void harden();
  void fetch();
  void play();
  void growUp();

 private:
  bool hasAged_;
  bool timelineRevealed_;
  std::vector<Form*> allForms_;
};
