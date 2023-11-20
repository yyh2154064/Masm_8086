data segment
    sum dw ?
    str db 0,0,0,0,'$'
data ends

code segment
assume cs:code,ds:data

start: mov ax,data
    mov ds,ax
    xor ax,ax
    mov cx,100
next: add ax,cx
    loop next ;循环计算1到100的和，和放在ax中
;下面是显示结果
    xor dx,dx
    mov bx,1000             ;除数  千位
    div bx                  
    or al,30h
    mov str,al              ;存结果

    mov ax,dx
    mov bl,100              ;除数  百位
    div bl
    or al,30h     
    mov str+1,al            ;存结果

    mov al,ah
    xor ah,ah
    mov bl,10               ;除数  十位
    div bl
    or ax,3030h
    mov str+2,al            ;存结果
    mov str+3,ah            ;存结果
    mov dx,offset str
    mov ah,9
    int 21h

    mov ax,4c00h             ; 设置DOS功能号为4C00H，用于程序终止
    int 21h                   ; 调用DOS中断以终止程序执行
    
code ends
end start