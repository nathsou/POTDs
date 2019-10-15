#pragma once

#include <cstddef>

// Definition for a binary tree node.
struct TreeNode {
  int val_;
  TreeNode* left_;
  TreeNode* right_;
  TreeNode(int x) {
    left_ = NULL;
    right_ = NULL;
    val_ = x;
  }
};

int height(TreeNode* tree);

bool isHeightBalanced(TreeNode* root);

void deleteTree(TreeNode* root);
