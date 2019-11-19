#include <iostream>
#include <string>

#ifndef _GRAPH_
#define _GRAPH_
using namespace std;
struct Graph {
  bool** adjMatrix;
  int n;
};

bool containsEdge(Graph const* const g, int src, int dest);

void addEdge(Graph* g, int src, int dest);

int numOutgoingEdges(Graph const* const g, int v);

int numIncomingEdges(Graph const* const g, int v);

void printGraph(Graph const* const g);

Graph* createVertices(int numV);

#endif
