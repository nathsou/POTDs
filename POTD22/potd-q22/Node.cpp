#include "Node.h"

using namespace std;

bool contains(Node* head, int elem) {
    Node* curr = head;

    while (curr != NULL) {
        if (curr->data_ == elem) return true;
        curr = curr->next_;
    }

    return false;
}

Node *listIntersection(Node *first, Node *second) {

    Node* inter = NULL;
    Node* curr = first;

    while (curr != NULL) {
        if (contains(second, curr->data_)) {
            // insert data in inter
            if (inter == NULL) {
                inter = new Node();
                inter->data_ = curr->data_;
                inter->next_ = NULL;
            } else {
                inter->next_ = new Node();
                inter->next_->data_ = curr->data_; 
                inter->next_->next_ = NULL;
            }
        }
        curr = curr->next_;
    }

    return inter;
}

Node::Node() {
    numNodes++;
}

Node::Node(Node &other) {
    this->data_ = other.data_;
    this->next_ = other.next_;
    numNodes++;
}

Node::~Node() {
    numNodes--;
}

int Node::numNodes = 0;
