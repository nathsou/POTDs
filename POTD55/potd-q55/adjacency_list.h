#include <iostream>
#include <string>

#ifndef _GRAPH_
#define _GRAPH_

using namespace std;

struct LinkedListNode {
    LinkedListNode* next;
    int v;
};

struct AdjacencyList {
    int vertex;
    LinkedListNode* edges;
};

struct Graph {
    AdjacencyList* adjLists;
    int n;
};

Graph* createVertices(int numV);

bool containsEdge(Graph const * const g, int src, int dest);

void addEdge(Graph* g, int src, int dest);

int numOutgoingEdges(Graph const * const g, int v);

int numIncomingEdges(Graph const * const g, int v);

void printGraph(Graph const * const g);

#endif
