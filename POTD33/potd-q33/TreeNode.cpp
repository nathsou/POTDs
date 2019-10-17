#include "TreeNode.h"
#include <algorithm>

void rightRotate(TreeNode* root) {
  if (root == NULL) return;
  TreeNode* prev_left = root->left_;
  prev_left->parent_ = root->parent_;
  if (root->parent_ != NULL) {
    root->parent_->left_ = prev_left;
  }
  root->parent_ = prev_left;
  TreeNode* prev_right = prev_left->right_;
  prev_left->right_ = root;
  root->left_ = prev_right;
  if (prev_right != NULL) {
    prev_right->parent_ = root;
  }
}

void leftRotate(TreeNode* root) {
  if (root == NULL) return;
  TreeNode* prev_right = root->right_;
  prev_right->parent_ = root->parent_;
  if (root->parent_ != NULL) {
    root->parent_->right_ = prev_right;
  }
  root->parent_ = prev_right;
  TreeNode* prev_left = prev_right->left_;
  prev_right->left_ = root;
  root->right_ = prev_left;
  if (prev_left != NULL) {
    prev_left->parent_ = root;
  }
}

void deleteTree(TreeNode* root) {
  if (root == NULL) return;
  deleteTree(root->left_);
  deleteTree(root->right_);
  delete root;
  root = NULL;
}
