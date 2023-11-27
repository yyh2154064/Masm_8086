assume cs:code, ds:data
;接收数据宏
GetNum macro 
    push ax     ;保存ax
    mov ah, 1   ;数据接收
   	int 21h
    mov ds:[0], al
    pop ax      ;恢复ax
    endm
;原数据 *3 
Disp macro Sta 
    push ax
    push bx      ;数据保存
    push cx
    mov bx, Sta  ;读取输入的数据
    sub bx, 30h
    mov ax, bx
    mov cx, 2       ;求 3 * N
L:  add bx, ax      ;循环加求解
    loop L
    add bx, 30h
    mov ds:[0], bx
    pop cx
    pop bx
    pop ax
    endm

data segment
    N db    00h, 00h, 00h, 00h, '$'
    information db "Please input a number(0~9)", '$'
    separate db "The result is -- ", '$'
    crlf db     0ah, 0dh, '$'   ;回车换行

data ends

code segment
start:
    mov ax, data    ;装载
    mov ds, ax
    lea dx, information  ;输入提示信息
    mov ah, 09h
    int 21h

    mov ah, 02h     ;输出响铃符
    mov dl, 07h
    int 21h

    lea dx, crlf  ;换行
    mov ah, 09h
    int 21h

    GetNum ;接受键盘输入
    
    
    lea dx, crlf  ;换行
    mov ah, 09h
    int 21h


    lea dx, separate  ;输出提示信息
    mov ah, 09h
    int 21h

    push bx
    sub bx, bx
    mov bl, ds:[0]
    Disp bx

    lea dx, N
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h

code ends
    end start