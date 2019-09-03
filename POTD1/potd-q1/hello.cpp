#include "hello.h"

std::string name = "Nathan";
unsigned age = 20;

std::string hello() {
    return "Hello world! My name is " + name + " and I am " + std::to_string(age) + " years old.";
}