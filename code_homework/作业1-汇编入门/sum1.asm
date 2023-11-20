code segment
assume cs:code

start:
MOV AX, 0         ; 初始累加和为0
MOV CX, 100       ; 循环次数为100

SUM_LOOP:
    ADD AX, CX     ; 将CX的值累加到AX中
    LOOP SUM_LOOP  ; 循环，继续累加

; 将结果转换为字符串
MOV DI, 10        ; 除数  十位
DIV DI                  
OR AL, 30h
MOV BH, AL        ; 存储十位

MOV AH, 4          ; 十位移到高位
MOV AL, BH
OR AL, 30h
XCHG AH, AL

MOV DI, 10        ; 除数  个位
DIV DI
OR AL, 30h
MOV BL, AL        ; 存储个位

MOV AH, 2          ; 设置AH为2，表示显示字符
MOV DL, BH         ; 显示十位
INT 21h

MOV AH, 2          ; 显示字符
MOV DL, BL         ; 显示个位
INT 21h

; 结束程序
MOV AH, 4Ch        ; 设置DOS功能号为4C00H，用于程序终止
INT 21h            ; 调用DOS中断以终止程序执行

code ends
end start