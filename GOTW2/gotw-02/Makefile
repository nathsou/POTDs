EXENAME = main
OBJS = main.o pet.o rock.o

CXX = clang++
CXXFLAGS = -std=c++1y -stdlib=libc++ -c -g -O0 -Wall -Wextra -pedantic
LD = clang++
LDFLAGS = -std=c++1y -stdlib=libc++ -lc++abi -lpthread -lm

all: $(EXENAME)

$(EXENAME) : $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -o $(EXENAME)

main.o : main.cpp pet.h rock.h
	$(CXX) $(CXXFLAGS) main.cpp

pet.o: pet.cpp pet.h
	$(CXX) $(CXXFLAGS) pet.cpp

rock.o: rock.cpp rock.h
	$(CXX) $(CXXFLAGS) rock.cpp

clean:
	-rm -f *.o $(EXENAME)
