//
// Created by wsrnd on 2021/8/5.
//

#include <bits/stdc++.h>

const int ma = 2e4 + 7;
using namespace std;

vector<int> mp[ma];
bool vis[ma];

int main()
{
    int n, a, b;
    scanf("%d",&n);
    for(int i = 1;i <= n;i++)
    {
        scanf("%d%d",&a, &b);
        mp[a].push_back(b);
    }

    return 0;
}