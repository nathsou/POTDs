#include "potd.h"
#include <iostream>
#include <sstream>

using namespace std;

string stringList(Node *head) {
    if (head == NULL) {
        return "Empty list";
    }

    stringstream acc;
    unsigned i = 0;

    Node *node = head;
    while (node != NULL) {
        acc << "Node " << i << ": " << node->data_;
        if (node->next_ != NULL) {
            acc << " -> ";
        }
        node = node->next_;
        i++;
    }

    return acc.str();
}
