CODESEG SEGMENT
ASSUME CS:CODESEG, 

MAIN PROC FAR

MOV AX, 0          ; 初始累加和为0
MOV CX, 3        ; 循环次数为100

SUM_LOOP:
    ADD AX, CX      ; 将CX的值累加到AX中
    LOOP SUM_LOOP   ; 循环，继续累加

; 显示结果
MOV AH, 02H         ; 设置DOS功能号为2（显示字符）
MOV Dx, AX
ADD DX, 030H
INT 21H             ; 调用DOS中断来显示字符

; 结束程序
MOV AH, 4CH         ; 设置DOS功能号为4C00H，用于程序终止
INT 21H             ; 调用DOS中断以终止程序执行

MAIN ENDP
CODESEG ENDS
END MAIN