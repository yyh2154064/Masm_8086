STKSEG SEGMENT STACK
DW 32 DUP(0)
STKSEG ENDS


CODESEG SEGMENT
ASSUME CS:CODESEG, 

MAIN PROC FAR
    MOV CX, 26           ; 外部循环次数
    MOV DX, 'A'
    MOV AH, 02H        ; 设置DOS功能号为2（显示字符）
    

L:
    MOV BX, DX
    CMP CX, 13
    JNZ P              ;若CX值不为13，则跳转到P
    MOV DX, 0AH        ; 打印换行符
    INT 21H

P:
    MOV DX, BX
    INT 21H            ; 调用DOS功能以显示字符
    INC DX             ; 递增 DX 寄存器，以便读取下一个字符

    LOOP L

    MOV AH, 4CH         ; 设置DOS功能号为4C00H，用于程序终止
    INT 21H             ; 调用DOS功能以终止程序执行

MAIN ENDP
CODESEG ENDS
END MAIN