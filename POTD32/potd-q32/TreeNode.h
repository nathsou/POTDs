#pragma once

#include <cstddef>

// Definition for a binary tree node.
struct TreeNode {
  int val_;
  int balance_;
  TreeNode* left_;
  TreeNode* right_;
  TreeNode(int x) {
    left_ = NULL;
    right_ = NULL;
    val_ = x;
    balance_ = 0;
  }
};

int height(TreeNode* tree);

bool isHeightBalanced(TreeNode* root);

TreeNode* findLastUnbalanced(TreeNode* root);

void deleteTree(TreeNode* root);
