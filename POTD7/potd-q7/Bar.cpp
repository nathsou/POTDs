#include "Bar.h"
#include <string>

potd::Bar::Bar(std::string name) {
    f_ = new Foo(name);
}

potd::Bar::Bar(const potd::Bar& other) {
    f_ = new Foo(other.get_name());
}

std::string potd::Bar::get_name() const {
    return f_->get_name();
}

potd::Bar::~Bar() {
    delete f_;
}

potd::Bar& potd::Bar::operator=(const potd::Bar& other) {
    delete f_;
    f_ = new Foo(other.get_name());
    return *this;
}