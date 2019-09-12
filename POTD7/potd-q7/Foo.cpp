#include "Foo.h"
#include <string>

int potd::Foo::count_ = 0;

potd::Foo::Foo(std::string name) {
    this->name_ = name;
    potd::Foo::count_++;
}

potd::Foo::Foo(const potd::Foo &that) {
    this->name_ = that.name_;
    potd::Foo::count_++;
}

potd::Foo::~Foo() {
    potd::Foo::count_--;
}

potd::Foo & potd::Foo::operator=(const potd::Foo &that) {
    this->name_ = that.name_;
    potd::Foo::count_++;
    return *this;
}

int potd::Foo::get_count() {
    return potd::Foo::count_;
}

std::string potd::Foo::get_name() {
    return name_;
}
