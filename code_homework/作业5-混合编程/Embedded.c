#include<stdio.h> 

int main() 
{ 
    int sum = 0, a = 0, b = 0, c = 0;
    scanf("%d%d%d", &a, &b, &c);   //键盘输入a, b, c的值

    //嵌入汇编代码计算a, b, c的和
    __asm{ 
        mov bx, a 
        add bx, b
        add bx, c
        mov sum, bx
    } 

    printf("%d + %d + %d = %d\n", a, b, c, sum); 
    return 0; 
}