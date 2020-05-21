#include <iostream>
#include <sstream>
#include <vector>
#include <string>
using namespace std;
 
int main()
{
    unsigned long a(2), b(3), result;
    //cin >> a >> b;
 
    __asm
    {
        mov eax, a
        mov ebx, b
        dec ebx
    L1:
        mul a
        dec ebx
        jnz L1
 
        mov result, eax
    }
 
    cout << result << endl;
 
    system("pause");
}
