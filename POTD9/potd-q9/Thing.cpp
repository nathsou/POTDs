#include "Thing.h"

potd::Thing::Thing(int max_size) {
    props_ct_ = 0;
    props_max_ = max_size;
    properties_ = new std::string[max_size];
    values_ = new std::string[max_size];
}

potd::Thing::Thing(const potd::Thing& other) {
    _copy(other);
}

potd::Thing& potd::Thing::operator=(const potd::Thing& other) {
    if (this != &other) {
        _destroy();
        _copy(other);
    }
    return *this;
}

potd::Thing::~Thing() {
    _destroy();
}

void potd::Thing::_copy(const potd::Thing& other) {
    props_ct_ = other.props_ct_;
    props_max_ = other.props_max_;

    properties_ = new std::string[props_max_];
    values_ = new std::string[props_max_];

    for (int i = 0; i < props_max_; i++) {
        properties_[i] = other.properties_[i];
        values_[i] = other.values_[i];
    }
}

void potd::Thing::_destroy() {
    delete[] values_;
    delete[] properties_;
}

int potd::Thing::set_property(std::string prop, std::string val) {

    for (int i = 0; i < props_ct_; i++) {
          if (properties_[i] == prop) {
              values_[i] = val;
              return i;
          }
    }

    if (props_ct_ >= props_max_) {
        return -1;
    }

    // this prop doesn't already exist
    properties_[props_ct_] = prop;
    values_[props_ct_] = val;

    return props_ct_++;
}

std::string potd::Thing::get_property(std::string prop) {
    for (int i = 0; i < props_max_; i++) {
          if (properties_[i] == prop) {
              return values_[i];
          }
    }

    return "";
}