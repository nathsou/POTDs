EXENAME = main
OBJS = main.o pokeman.o

# C++ compiler to use
CXX = clang++
# flags to run with
CXXFLAGS = -std=c++1y -stdlib=libc++ -c -g -O0 -Wall -Wextra -pedantic
LD = clang++
LDFLAGS = -std=c++1y -stdlib=libc++ -lc++abi -lpthread -lm


all: $(EXENAME)

#$(EXENAME) : $(OBJS)
#	$(OBJS) -o $(EXENAME)
$(EXENAME) : $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -o $(EXENAME)


# file.o : dependent files
# 	command to run
main.o : main.cpp
	$(CXX) $(CXXFLAGS) main.cpp

pokeman.o: pokeman.cpp pokeman.h
	$(CXX) $(CXXFLAGS) pokeman.cpp

clean:
	-rm -f *.o $(EXENAME)
