#include "TreeNode.h"
#include <algorithm>

TreeNode* findLastUnbalanced(TreeNode* root) {
  if (root == NULL) return NULL;

  auto left = findLastUnbalanced(root->left_);
  auto right = findLastUnbalanced(root->right_);
  if (left != NULL || right != NULL) {
    return height(root->left_) > height(root->right_) ? left : right;
  }

  return isHeightBalanced(root) ? NULL : root;
}

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
