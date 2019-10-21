#include <vector>
#include "BTreeNode.h"


BTreeNode* find(BTreeNode* root, int key) {
  
  auto keys = root->elements_;

  unsigned idx;
  for (idx = 0; idx < keys.size() && key > keys[idx]; idx++);

  if (idx < keys.size() && keys[idx] == key) return root;

  if (root->is_leaf_) return NULL;
  return find(root->children_[idx], key);
}
