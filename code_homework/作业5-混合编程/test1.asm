section .text
public _asm_add

asm_add:
    ; 输入参数: a - [esp + 4], b - [esp + 8], c - [esp + 12]
    ; 输出结果: eax - 返回值
    mov ax, [esp + 4]  ; a
    add ax, [esp + 8]  ; b
    add ax, [esp + 12] ; c
    ret