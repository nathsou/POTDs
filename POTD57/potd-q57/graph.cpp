#include <iostream>
#include <string>
#include <stack>

struct Node {
    Node(int v): value(v) {};
    int value;
    std::vector<Node*> outgoingNeighbors;

    bool operator==(Node const & other) const {
        return value == other.value && outgoingNeighbors == other.outgoingNeighbors;
    }
};

struct Graph {
    std::vector<Node*> nodes;

    Graph(int n) {
        for (size_t i = 0; i < n; i++) {
            Node* newNode = new Node(i);
            nodes.push_back(newNode);
        }
    };

    ~Graph() {
        for (size_t i = 0; i < nodes.size(); i++) {
            free(nodes[i]);
        }
    }

    void addEdge(int src, int dst) {
        if (containsEdge(src, dst)) {
            return;
        }

        Node* srcNode = nodes[src];
        Node* dstNode = nodes[dst];
        srcNode->outgoingNeighbors.push_back(dstNode);
    }

    bool containsEdge(int src, int dst) {
        Node* srcNode = nodes[src];
        Node* dstNode = nodes[dst];
        for (auto neighborIter = srcNode->outgoingNeighbors.begin(); neighborIter != srcNode->outgoingNeighbors.end(); neighborIter++) {
            Node* neighbor = *neighborIter;
            if (*neighbor == *dstNode) {
                return true;
            }
        }
        return false;
    }
};

void printGraph(Graph const & g) {
    for (auto nodeIter = g.nodes.begin(); nodeIter != g.nodes.end(); nodeIter++) {
        Node * node = *nodeIter;
        std::cout << "Node: " << node->value;
        std::cout << " neighbors: ";
        for (auto neighborIter = node->outgoingNeighbors.begin(); neighborIter != node->outgoingNeighbors.end(); neighborIter++) {
            Node * neighbor = *neighborIter;
             std::cout << neighbor->value << " ";
        }
        std::cout << '\n';
    }
}

bool contains(std::vector<Node*> v, Node* n){
  for (int i = 0; i < v.size(); i++){
    if(*v[i] == *n){
      return true;
    }
  }
  return false;
}
