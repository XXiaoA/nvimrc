#include <iostream>
using namespace std;

int read() {
    int x = 0, w = 1;
    char ch = 0;
    // clang-format off
    while (ch < '0' || ch > '9') { if (ch == '-') w = -1; ch = getchar(); }
    while (ch >= '0' && ch <= '9') { x = x * 10 + (ch - '0'); ch = getchar(); }
    // clang-format on
    return x * w;
}

int main() {
#ifdef LOCAL
    freopen("in", "r", stdin);
#endif
    ios::sync_with_stdio(false);
    int n;
    n = read();

    return 0;
}
