#pragma once
#include <string> 

class Food {
    private:
    std::string name_;
    unsigned quantity_;

    public:
    Food();
    std::string get_name();
    unsigned get_quantity();
    void set_name(std::string name);
    void set_quantity(unsigned quantity);
};