#include <vector>
#include "BTreeNode.h"

std::vector<int> traverse(BTreeNode* root) {
    // your code here
    std::vector<int> v;
    _traverse(root, v);
    return v;
}

void _traverse(BTreeNode* root, std::vector<int>& vec) {
    if (root == NULL) return;
    
    for (unsigned i = 0; i < root->elements_.size(); i++) {
        if (!root->is_leaf_) {
            _traverse(root->children_[i], vec);
        }

        vec.push_back(root->elements_[i]);
    }

    if (!root->is_leaf_) {
        _traverse(root->children_.back(), vec);
    }
}