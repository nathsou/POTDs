#include "Node.h"

void mergeList(Node *first, Node *second) {
  
    Node *curr1 = first;
    Node *curr2 = second;
    Node *next1;
    Node *next2;

    while (curr1 != NULL && curr2 != NULL) {
        next1 = curr1->next_;
        next2 = curr2->next_;

        if (curr2 != NULL) {
            curr1->next_ = curr2;
        }

        if (next1 != NULL) {
            curr2->next_ = next1;
        }

        curr1 = next1;
        curr2 = next2;
    }

}

Node::Node() {
    numNodes++;
}

Node::Node(const Node &other) {
    this->data_ = other.data_;
    this->next_ = other.next_;
    numNodes++;
}

Node::~Node() {
    numNodes--;
}

int Node::numNodes = 0;
