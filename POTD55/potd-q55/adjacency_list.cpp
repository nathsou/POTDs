#include "adjacency_list.h"
#include <iostream>
#include <string>

using namespace std;

AdjacencyList* findAdj(Graph const* const g, int v) {
  for (int i = 0; i < g->n; i++) {
    if (g->adjLists[i].vertex == v) return &(g->adjLists[i]);
  }

  return NULL;
}

bool containsEdge(Graph const* const g, int src, int dest) {
  LinkedListNode* node = findAdj(g, src)->edges;

  while (node != NULL) {
    if (node->v == dest) return true;
    node = node->next;
  }

  return false;
}

void addEdge(Graph* g, int src, int dest) {
  if (containsEdge(g, src, dest)) return;

  AdjacencyList* next = findAdj(g, src);
  LinkedListNode* node = new LinkedListNode;
  node->next = next->edges;
  node->v = dest;

  next->edges = node;
}

int numOutgoingEdges(Graph const* const g, int v) {
  LinkedListNode* node = findAdj(g, v)->edges;

  int len = 0;

  while (node != NULL) {
    len++;
    node = node->next;
  }

  return len;
}

int numIncomingEdges(Graph const* const g, int v) {
  int incoming = 0;
  for (int i = 0; i < g->n; i++) {
    LinkedListNode* node = g->adjLists[i].edges;

    while (node != NULL) {
      if (node->v == v) incoming++;
      node = node->next;
    }
  }

  return incoming;
}

// No need to modify the functions below

Graph* createVertices(int numV) {
  Graph* g = new Graph();
  g->adjLists = new AdjacencyList[numV];
  g->n = numV;

  // Initialize the vertices
  for (int i = 0; i < numV; i += 1) {
    g->adjLists[i].vertex = i;
    g->adjLists[i].edges = NULL;
  }

  return g;
}

void printGraph(Graph const* const g) {
  for (int i = 0; i < g->n; i += 1) {
    AdjacencyList adjList = g->adjLists[i];

    int v = adjList.vertex;
    // Vertex
    cout << "Vertex: " << v << endl;

    // Print number of incoming and outgoing edges
    int inc = numIncomingEdges(g, v);
    int out = numOutgoingEdges(g, v);
    cout << "Number of incoming edges: " << inc << endl;
    cout << "Number of outgoing edges: " << out << endl;

    cout << "\n" << endl;
  }
}
