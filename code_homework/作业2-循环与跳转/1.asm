assume cs:codesg,ds:data,ss:stack
 
data segment
    res db 00H,'*',00H,'=',2 dup(2),' ','$' ;结果 res[5]
    line db 13,10,'$';换行
data ends
 
stack segment
    db 100 dup(0) ;代码段
stack ends
 
codesg segment
start:
        mov ax,data
        mov ds,ax
        
        mov bl,1; 外循环开始乘数
        mov cx,9; 循环进行9次
i:
        push cx
        mov cl,bl;内层循环需要的次数
        mov bh,1; 内循环开始被乘数
            
j:
        ;保存原本的乘数与被乘数
        push bx
        ;将转换成可输出的字符
        add bh,30H
        add bl,30H
 
        ;填入res中
        mov res[0],bh
        mov res[2],bl
 
        ;恢复原来的数据
        pop bx
 
        ;保存原本的乘数与被乘数
        push bx
 
        ;相乘结果在ax中
        mov ax,1
        mul bl
        mul bh
 
        ;恢复原来的数据
        pop bx
 
        ;保存原本的乘数与被乘数
        push bx

        ;十进制输出
        mov bh,10
        div bh
            
        add ah,30H
        add al,30H
        mov res[5],ah
        mov res[4],al
 
            
        ;恢复原来的数据
        pop bx
 
        mov dx,offset res;打印res
        mov ah,9h
        int 21h
        inc bh
 
        loop j;结束内循环
 
        mov dx,offset line
        mov ah,9h
        int 21h
        
        inc bl
        pop cx
        loop i;结束外循环
        
        mov ah,4ch
        int 21h
codesg ends
    end start
