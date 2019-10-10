#include "TreeNode.h"

#include <cstddef>
#include <iostream>
using namespace std;

TreeNode::TreeNode() : left_(NULL), right_(NULL) {}

int _height(TreeNode* tree) {
  if (tree == NULL) return -1;
  return 1 + std::max(_height(tree->left_), _height(tree->right_));
}

int TreeNode::getHeight() { return _height(this); }