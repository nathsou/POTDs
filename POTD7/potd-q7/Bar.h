#pragma once
#include "Foo.h"
#include <string>

namespace potd {
    class Bar { 
        public:
        Bar(std::string name);
        Bar(const Bar& other);
        ~Bar();
        std::string get_name() const;
        Bar& operator=(const Bar& other);
        private:
        Foo* f_;
    };
}