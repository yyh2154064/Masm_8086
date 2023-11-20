STKSEG SEGMENT STACK
DW 32 DUP(0)
STKSEG ENDS


CODESEG SEGMENT
ASSUME CS:CODESEG, 

MAIN PROC FAR
    MOV CX, 13           ; 外部循环次数
    MOV DX, 'A'

L:
    MOV AH, 02H        ; 设置DOS功能号为2（显示字符）
    INT 21H            ; 调用DOS功能以显示字符
    INC DX             ; 递增 DX 寄存器，以便读取下一个字符
    LOOP L

    MOV DX, 0DH        ; 打印换行符
    INT 21H             
    MOV DX, 0AH
    INT 21H             
   
    MOV DX, 'A'        ;重置数据寄存器
    ADD DX, 13         
    MOV CX, 13

P:
    MOV AH, 02H        ; 设置DOS功能号为2（显示字符）
    INT 21H            ; 调用DOS功能以显示字符
    INC DX             ; 递增 DX 寄存器，以便读取下一个字符
    LOOP P

    MOV AH, 4CH         ; 设置DOS功能号为4C00H，用于程序终止
    INT 21H             ; 调用DOS功能以终止程序执行

MAIN ENDP
CODESEG ENDS
END MAIN