assume cs:code, ds:data
data segment
    Month db    00h, 00h, '$'
    Day db      00h, 00h, '$'
    Year db     00h, 00h, '$'
    information db "What is the date(MM/DD/YY)?", '$'
    separate db "--", '$'
    crlf db     0ah, 0dh, '$'   ;回车换行

data ends

code segment
start:
    mov ax, data    ;装载
    mov ds, ax
    lea dx, offset information  ;输出提示信息
    mov ah, 09h
    int 21h

    mov ah, 02h     ;输出响铃符
    mov dl, 07h
    int 21h

    lea dx, offset crlf  ;换行
    mov ah, 09h
    int 21h

    call GetNum ;接受键盘输入
    
    
    lea dx, offset crlf  ;换行
    mov ah, 09h
    int 21h


    call Disp  ;输出年份

    lea dx, offset separate  ;输出月份
    mov ah, 09h
    int 21h
    call Dispp

    lea dx, offset separate  ;输出日值
    mov ah, 09h
    int 21h
    call Disppp

    mov ah, 4Ch
    int 21h

;接受键入的月份、日期、年份
GetNum proc
  	push ax     ;数据入栈，保留数值
  	push bx
  	push cx
    mov cx, 3
    mov bx, 0
receive:   
  	mov ah, 1   ;循环数据接收
   	int 21h
    mov ds:[bx], al
    inc bx

    mov ah, 1   ;循环数据接收
   	int 21h
    mov ds:[bx], al
    add bx, 2

    loop receive

   	pop cx      ;数据出栈，恢复数据
   	pop bx
   	pop ax
    ret    
GetNum endp

;打印年份
Disp proc
    push ax     ;数据入栈，保留数值
    push dx

    lea dx, offset Year  ;输出提示信息
    mov ah, 09h
    int 21h

    pop dx      ;数据出栈，恢复数据
    pop ax      
    ret    
Disp endp

;打印月份
Dispp proc
    push ax     ;数据入栈，保留数值
    push dx

    lea dx, offset Month  ;输出提示信息
    mov ah, 09h
    int 21h

    pop dx      ;数据出栈，恢复数据
    pop ax      
    ret    
Dispp endp

;打印日值
Disppp proc
    push ax     ;数据入栈，保留数值
    push dx

    lea dx, offset Day  ;输出提示信息
    mov ah, 09h
    int 21h

    pop dx      ;数据出栈，恢复数据
    pop ax      
    ret    
Disppp endp

code ends
    end start