#include <cstdio>
#include <vector>

#include "cycle_detection.cpp"

int main() {
    // Construct graph
    Graph g(3);
    g.addEdge(0, 1);
    g.addEdge(1, 2);
    g.addEdge(2, 0);

    // Print the edges
    printGraph(g);

    bool cycles = hasCycles(g);
    std::cout << "Has cycles: " << cycles << std::endl;
}
