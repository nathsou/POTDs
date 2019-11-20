#include <iostream>
#include <stack>
#include <string>
#include <unordered_map>
#include <vector>
#include "graph.cpp"

using std::stack;
using std::string;
using std::unordered_map;
using std::vector;

string createEdge(int a, int b) {
  string a_ = std::to_string(a);
  string b_ = std::to_string(b);
  return a < b ? a_ + ';' + b_ : b_ + ';' + a_;
}

bool hasCycles(Graph const& g) {
  const int n = g.nodes.size();

  vector<bool> visited_vertices(n);
  unordered_map<string, bool> edges;

  for (auto a : g.nodes) {
    visited_vertices[a->value] = false;
    for (auto b : g.nodes) {
      string edge = createEdge(a->value, b->value);
      edges[edge] = false;
    }
  }

  for (int i = n - 1; i >= 0; i--) {
    Node node = *(g.nodes[i]);
    int curr = node.value;
    stack<Node> s;
    s.push(node);

    for (auto v : visited_vertices) {
      visited_vertices[v] = false;
    }

    for (auto edge : edges) edge.second = false;

    while (!s.empty()) {
      Node v = s.top();
      s.pop();
      for (auto a : v.outgoingNeighbors) {
        string edge = createEdge(v.value, a->value);
        if (!visited_vertices[a->value]) {
          visited_vertices[a->value] = true;
          edges[edge] = true;
          s.push(*a);
        } else if (!edges[edge])
          edges[edge] = true;
        if (a->value == curr) {
          return true;
        }
      }
    }
  }

  return false;
}
