#include <iostream>
#include "Foo.h"
#include "Bar.h"

int main() {
    potd::Bar *b1, *b2, *b3;

    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    b1 = new potd::Bar("aramis");
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    b2 = new potd::Bar(*b1);
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    b3 = new potd::Bar("porthos");
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    std::cout << "b1 is " << b1->get_name() << std::endl ;
    std::cout << "b2 is " << b2->get_name() << std::endl ;
    std::cout << "b3 is " << b3->get_name() << std::endl ;
    *b1 = *b3;
    *b2 = *b3;
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    std::cout << "b1 is " << b1->get_name() << std::endl ;
    std::cout << "b2 is " << b2->get_name() << std::endl ;
    std::cout << "b3 is " << b3->get_name() << std::endl ;
    *b1 = *b3;
    *b2 = *b3;
    delete b1;
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    delete b2;
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
    delete b3;
    std::cout << "There are " << potd::Foo::get_count() << " Foo's in the world." << std::endl;
}
