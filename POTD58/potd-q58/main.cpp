#include <cstdio>
#include <vector>

using namespace std;

#include "buglife.cpp"

int main() {
  int numScenario;

  scanf("%d", &numScenario);

  vector<int> b1;
  vector<int> b2;

  for (int sNum = 1; sNum <= numScenario; sNum++) {
    int numBugs;
    int numInter;
    scanf("%d %d", &numBugs, &numInter);

    b1.clear();
    b2.clear();

    b1.resize(numInter, 0);
    b2.resize(numInter, 0);

    for (int i = 0; i < numInter; i++) {
      int p1, p2;
      scanf("%d %d", &p1, &p2);
      b1[i] = p1;
      b2[i] = p2;
    }

    printf("Scenario #%d:\n", sNum);

    // for(int i=0; i<numInter; i++) {
    //     cout << b1[i] << " " << b2[i] << endl;
    // }

    if (bugLife(numBugs, b1, b2))
      printf("Suspicious bugs found!\n");
    else
      printf("No suspicious bugs found!\n");
  }
}
