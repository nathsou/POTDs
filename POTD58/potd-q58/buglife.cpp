#include <iostream>
#include <unordered_map>
#include <vector>

using std::unordered_map;
using std::vector;

struct Vertex {
  bool data;
  vector<int> adj;
};

class Graph {
 private:
  unordered_map<int, Vertex> vertices;

 public:
  void addVertex(int label, bool data);
  void addEdge(int from, int to);
  bool getGender(int label);
  bool has(int label);
  vector<int> &adjacentVertices(int label);
};

void Graph::addVertex(int label, bool gender) {
  vector<int> adj;
  vertices[label] = {gender, adj};
}

void Graph::addEdge(int from, int to) { vertices[from].adj.push_back(to); }

bool Graph::getGender(int v) { return vertices[v].data; }

bool Graph::has(int label) { return vertices.find(label) != vertices.end(); }

vector<int> &Graph::adjacentVertices(int label) { return vertices[label].adj; }

// returns true if a counterexample is found
bool bugLife(int numBugs, vector<int> &b1, vector<int> &b2) {
  Graph g;

  for (int i = 0; i < (int)b1.size(); i++) {
    int a = b1[i];
    int b = b2[i];

    if (g.has(a) && g.has(b)) {
      if (g.getGender(a) == g.getGender(b)) return true;
    } else if (g.has(a)) {
      g.addVertex(b, !g.getGender(a));
    } else if (g.has(b)) {
      g.addVertex(a, !g.getGender(b));
    } else {
      // suppose a and b are of opposite gender
      g.addVertex(a, true);
      g.addVertex(b, false);
    }

    g.addEdge(a, b);
    // g.addEdge(b, a); // not required
  }

  for (int i = 0; i < numBugs; i++) {
    bool gender = g.getGender(i);

    for (int v : g.adjacentVertices(i)) {
      if (g.getGender(v) == gender) return true;
    }
  }

  return false;
}
