#include "TreeNode.h"

TreeNode::RotationType balanceTree(TreeNode*& subroot) {
	
  int balance = getHeight(subroot->right_) - getHeight(subroot->left_);

  if (balance == -2) {
    int l_balance = getHeight(subroot->left_->right_) - getHeight(subroot->left_->left_);
    if (l_balance == -1) {
      return TreeNode::right;
    } else {
      return TreeNode::leftRight;
    }
  } else if (balance == 2) {
    int r_balance = getHeight(subroot->right_->right_) - getHeight(subroot->right_->left_);
    if (r_balance == 1) {
      return TreeNode::left;
    } else {
      return TreeNode::rightLeft;
    }
  }

  if (balance < 0) {
    return balanceTree(subroot->left_);
  } else if (balance > 0) {
    return balanceTree(subroot->right_);
  }

  // sentinel value
  return TreeNode::right;
}
