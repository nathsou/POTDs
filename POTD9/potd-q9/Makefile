EXENAME = main

CXX = clang++
CXXFLAGS = -std=c++0x -g -O0 -Wall -Wextra

# Memory error detector
CXXFLAGS += -fsanitize=address -fno-omit-frame-pointer
LDFLAGS += -fsanitize=address

all: $(EXENAME)

$(EXENAME): Thing.cpp Thing.h main.cpp
	$(CXX) $(CXXFLAGS) main.cpp Thing.cpp -o main

.PHONY: clean
clean:
	rm -f main
