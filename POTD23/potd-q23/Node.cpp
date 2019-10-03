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

void insertBack(Node*& head, Node* node) {

    if (head == NULL) {
        head = node;
        return;
    }

    Node *curr = head;
    while (curr->next_ != NULL) {
        curr = curr->next_;
    }

    curr->next_ = node;
}

Node *listSymmetricDifference(Node *first, Node *second) {
    Node* diff = NULL;
    bool is_first = first != NULL;
    Node* curr = is_first ? first : second;

    while (curr != NULL) {
        bool in_first = is_first || contains(first, curr->data_);
        bool in_second = !is_first || contains(second, curr->data_);

        if (in_first ^ in_second) {
            if (!contains(diff, curr->data_)) {
                Node* node = new Node();
                node->data_ = curr->data_;
                node->next_ = NULL;
                insertBack(diff, node);
            }
        }

        curr = curr->next_;
        if (is_first && curr == NULL) {
            curr = second;
            is_first = false;
        }
    }

    return diff;
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
