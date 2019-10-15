#include "TreeNode.h"
#include <algorithm>

int height(TreeNode* tree) {
  if (tree == NULL) return -1;
  return 1 + std::max(height(tree->left_), height(tree->right_));
}

bool isHeightBalanced(TreeNode* root) {
  if (root == NULL) return true;
  return std::abs(height(root->left_) - height(root->right_)) <= 1;
}

void deleteTree(TreeNode* root) {
  if (root == NULL) return;
  deleteTree(root->left_);
  deleteTree(root->right_);
  delete root;
  root = NULL;
}
