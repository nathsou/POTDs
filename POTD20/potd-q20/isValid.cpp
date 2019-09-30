#include <string>
#include <stack>

using namespace std;

bool isValid(string input) {
    stack<char> st;

    for (const auto chr : input) {
        switch (chr) {
            case '{':
            case '[':
            case '(':
                st.push(chr);
                break;
            case '}':
                if (st.empty() || st.top() != '{') return false;
                st.pop();
                break;
            case ']':
                if (st.empty() || st.top() != '[') return false;
                st.pop();
                break;
            case ')':
                if (st.empty() || st.top() != '(') return false;
                st.pop();
                break;   
            default:
                break; 
        }
    }

    return st.empty();
}