// #include "HuffmanUtils.h"
#include <map>
#include <sstream>
#include <string>
#include "HuffmanNode.h"

using namespace std;

/**
 * binaryToString
 *
 * Write a function that takes in the root to a huffman tree
 * and a binary string.
 *
 * Remember 0s in the string mean left and 1s mean right.
 */

string binaryToString(string binaryString, HuffmanNode* huffmanTree) {
  stringstream decoded;
  HuffmanNode* curr = huffmanTree;

  for (const char& c : binaryString) {
    curr = c == '0' ? curr->left_ : curr->right_;

    if (curr->left_ == NULL && curr->right_ == NULL) {
      decoded << curr->char_;
      curr = huffmanTree;
    }
  }

  return decoded.str();
}

void getPaths(map<char, string>& codes, HuffmanNode* node, string curr_path) {
  if (node == NULL) return;

  // leaf
  if (node->left_ == NULL && node->right_ == NULL) {
    codes.insert(pair<char, string>(node->char_, curr_path));
    return;
  }

  getPaths(codes, node->left_, curr_path + '0');
  getPaths(codes, node->right_, curr_path + '1');
}

map<char, string> encoding(HuffmanNode* node) {
  map<char, string> codes;
  getPaths(codes, node, "");
  return codes;
}

/**
 * stringToBinary
 *
 * Write a function that takes in the root to a huffman tree
 * and a character string. Return the binary representation of the string
 * using the huffman tree.
 *
 * Remember 0s in the binary string mean left and 1s mean right
 */

string stringToBinary(string charString, HuffmanNode* huffmanTree) {
  map<char, string> codes = encoding(huffmanTree);
  stringstream msg;

  for (const char& c : charString) {
    msg << codes.at(c);
  }

  return msg.str();
}