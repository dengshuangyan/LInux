#include <iostream>

using namespace std;
const int ma = 4e4 +7;
int n, color[ma], num[ma];

bool safe(int x,int des)
{
    if(color[x] > 0)
    {
        if(color[x] == 1)
            return 0;
        return 1;
    }

    color[x] = 2;
    cout << des << "  ---  " << num[x] << " ---- " << x << endl;
    if(des * num[x] > 0)
    {
        int next = x + num[x];
        if(next >= n)
            next %= n;
        else if(next < 0)
            next += n;
        if(next == x)
        {
            color[x] = 1;
            return 0;
        }
        cout << next << "  " << x << endl;
        if(!safe(next, des))
        {
            color[x] = 1;
            return 0;
        }

    }
    else
    {
        color[x] = 1;
        return 0;
    }

    color[x] = 3;
    return 1;
}

int main() {

//    scanf("%d",&n);
//    for(int i = 0;i < n;i++)
//        scanf("%d",&num[i]);
//
//    int des;
//    bool f = 0;
//    for(int i = 0;i < n;i++)
//    {
//        des = num[i] > 0 ? 1 : -1;
//        if(safe(i, des)){
//            cout<< i << "   this is answer index \n";
//            f = 1;
//            break;
//        }
//
//    }
//    cout<< f << " this is answer \n";
//    for(int i = 0;i < n;i++)
//        cout << color[i] << " ";
    cout << -1 % 1 << endl;
    return 0;
}
