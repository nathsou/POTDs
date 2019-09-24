#include "potd.h"
#include <iostream>

void insertSorted(Node **head, Node *insert) {
  if (*head == NULL) {
    *head = insert;
    return;
  }

  if ((*head)->data_ >= insert->data_) {
    insert->next_ = *head;
    (*head) = insert;
  }

  Node *node = *head;
  while (node->next_ != NULL && insert->data_ > node->next_->data_) {
    node = node->next_;
  }

  Node *tmp = node->next_;
  node->next_ = insert;
  insert->next_ = tmp;
}
