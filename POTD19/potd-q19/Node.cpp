#include "Node.h"
#include <iostream>

/** Create a new node and add it to the list, while keeping the list sorted.
*/
Node *insertSorted(Node *&head, int data) {

    Node *insert = new Node();
    insert->data_ = data;
    insert->next_ = NULL;

    if (head == NULL) {
        head = insert;
        return insert;
    }

    if (head->data_ >= data) {
        insert->next_ = head;
        head = insert;
        return insert;
    }

    Node *node = head;
    while (node->next_ != NULL && data > node->next_->data_) {
        node = node->next_;
    }

    Node *tmp = node->next_;
    node->next_ = insert;
    insert->next_ = tmp;

    return insert;
}

// void print_list(Node *head) {
//     Node *curr = head;

//     while (curr != NULL) {
//         std::cout << curr->data_ << " ";
//         curr = curr->next_;
//     }

//     std::cout << std::endl;
// }

bool contains(Node *head, int elem) {
    Node *curr = head;

    while (curr != NULL) {
        if (curr->data_ == elem) return true;
        curr = curr->next_;
    }

    return false;
}

void insertUnique(Node *&head, Node *first) {
    Node *curr = first;

    while (curr != NULL) {
        Node *next = curr->next_;
        if (!contains(head, curr->data_)) {
            insertSorted(head, curr->data_);
        }

        curr = next;
    }
}

/** Creates a new list (containing new nodes, allocated on the heap)
	that contains the set union of the values in both lists.
*/
Node *listUnion(Node *first, Node *second) {
    Node* out = NULL;

    insertUnique(out, first);
    insertUnique(out, second);

    return out;
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
