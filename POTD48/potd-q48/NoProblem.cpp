
vector<string> NoProblem(int start, vector<int> created, vector<int> needed) {
  int remaining = 0;
  vector<string> out;

  for (int i = 0; i < 12; i++) {
    remaining += i == 0 ? start : created[i - 1];
    int need = needed[i];

    if (remaining >= need) {
      out.push_back("No problem! :D");
      remaining -= need;
    } else {
      out.push_back("No problem. :(");
    }
  }

  return out;
}
