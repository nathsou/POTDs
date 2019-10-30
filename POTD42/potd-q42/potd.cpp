#include <unordered_map>
#include <vector>

using namespace std;

unordered_map<string, int> common_elems(unordered_map<string, int>& mapA,
                                        unordered_map<string, int>& mapB) {
  unordered_map<string, int> common;

  for (auto& elem : mapA) {
    if (mapB.find(elem.first) != mapB.end()) {
      string key = elem.first;
      common[key] = elem.second + mapB[key];
    }
  }

  for (auto elem : common) {
    mapA.erase(elem.first);
    mapB.erase(elem.first);
  }

  return common;
}