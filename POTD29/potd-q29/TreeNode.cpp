#include "TreeNode.h"
#include <iostream>

TreeNode* deleteNode(TreeNode* root, int key) {
  if (root == NULL) return root;

  if (key > root->val_) {
    root->right_ = deleteNode(root->right_, key);
    return root;
  } else if (key < root->val_) {
    root->left_ = deleteNode(root->left_, key);
    return root;
  }

  if (root->left_ == NULL) {
    TreeNode* tmp = root->right_;
    delete root;
    return tmp;
  }

  if (root->right_ == NULL) {
    TreeNode* tmp = root->left_;
    delete root;
    return tmp;
  }

  TreeNode* succ = root->right_;
  while (succ->left_ != NULL) {
    succ = succ->left_;
  }

  root->val_ = succ->val_;
  root->right_ = deleteNode(root->right_, succ->val_);

  return root;
}

void inorderPrint(TreeNode* node) {
  if (!node) return;
  inorderPrint(node->left_);
  std::cout << node->val_ << " ";
  inorderPrint(node->right_);
}

void deleteTree(TreeNode* root) {
  if (root == NULL) return;
  deleteTree(root->left_);
  deleteTree(root->right_);
  delete root;
  root = NULL;
}
