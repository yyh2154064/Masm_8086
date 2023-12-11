#include <stdio.h>

// 声明嵌入汇编的函数
extern int asm_add(int a, int b, int c);

int main() {
    int sum = 0, a = 0, b = 0, c = 0;

    // 从键盘输入 a, b, c 的值
    scanf("%d%d%d", &a, &b, &c);

    // 调用嵌入汇编的函数
    sum = asm_add(a, b, c);

    // 输出结果
    printf("%d + %d + %d = %d\n", a, b, c, sum);

    return 0;
}