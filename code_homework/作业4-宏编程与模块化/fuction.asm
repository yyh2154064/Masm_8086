codesg segment
	ASSUME CS:codesg
	PUBLIC transmit, Print
	EXTRN data:FAR
	EXTRN table:FAR
	EXTRN str:FAR
	MAIN PROC 
		MOV AX, data
        MOV DS, AX
		MOV AX, table
        MOV ES, AX

	;将data段数据填入表table中
	transmit proc far
		mov bp,0 		;用于table表寻址，每次循环自增16
		mov si,0 		;用于数据中summ寻址，每次循环自增4
		mov di,0 		;用于数据中ne寻址，每次循环自增2
		mov cx,21
	transmit_s0:
		push cx
		mov bx,si  		;year寻址
		push si
		mov si,0
		mov cx,4
	transmit_s1:
		mov al,ds:[bx+si]
		mov es:[bp+si],al
		inc si
		loop transmit_s1
		pop si

		mov ax,ds:[di+168]
		mov es:[bp+0ah],ax	

		mov ax,ds:[si+84]	;双字型数据的低16位
		mov dx,ds:[si+86]	;双字型数据的高16位
		mov es:[bp+5],ax
		mov es:[bp+7],dx	;table表存入summ

		div word ptr es:[bp+0ah]
		mov es:[bp+0dh],ax	;除法计算，table表存入ave

		add bp,16
		add si,4
		add di,2
		pop cx
		loop transmit_s0
		ret
	transmit endp

	;打印函数
	Print proc far
		mov dx,0	
		mov ax,0007h		
		mov bp,0		;bp确定table中的位置信息（行）
		mov cx,21		;循环21次
	L1:
		push cx			;循环次数
		push dx			;行列信息
		push ax			;字体属性

		call str_ini		;中间栈初始化

		mov ax,str
		mov es,ax		;str字符串的段地址
		mov cx,4
		mov si,0
	Years:
		mov al,ds:[bp+si]
		mov es:[si],al
		inc si
		loop Years	;将年份信息复制到str中
		pop cx			;字体
		pop dx			;行列
		call show_str		;显示年份

		call str_ini
		add dl,8		;列数+8
		push dx
		push cx
		mov ax,ds:[bp+5]
		mov dx,ds:[bp+7]
		call Dtoc		;将summ数值转成字符串存放在str中
		pop cx
		pop dx
		call show_str		;显示summ

		call str_ini
		add dl,8
		push dx
		push cx
		mov dx,0
		mov ax,ds:[bp+0ah]
		call Dtoc
		pop cx
		pop dx
		call show_str		;显示ne

		call str_ini
		add dl,8
		push dx
		push cx
		mov dx,0
		mov ax,ds:[bp+0dh]
		call Dtoc
		pop cx
		pop dx
		call show_str	        ;显示平均值

		;一行所有信息显示完后
		add bp,16
		mov ax,cx		
		inc dh			;行数+1
		mov dl,0		;列数设为0
		pop cx			;循环次数出栈
		loop L1
		ret
	Print endp

	;进行不会产生溢出的除法运算
	Divdw proc
			push ax			;将低16位入栈保存
			mov ax,dx
		sub dx,dx
		div cx			;计算H/N以及H%N, 得到的H/N(ax)就是最终结果的高16位
		pop bx			;取出L
		push ax			;最终结果的高16位入栈
		mov ax,bx
		div cx			;计算结果的低16位商放在ax
		mov cx,dx		;将结果的余数放在cx
		pop dx			;将结果的高16位放在dx
		ret
	Divdw endp
			
	;将16进制数转成10进制数的字符形式, 存放在str段中
	Dtoc proc
			push ds
		mov bx,str
		mov ds,bx

		mov si,0
	Dtoc_s0:
		mov cx,10		;除数设为10
		call Divdw
		push cx			;余数入栈
		inc si
		mov cx,ax
		add cx,dx		;cx判断商是否为0
	jcxz ok_
		jmp short Dtoc_s0
	ok_:			        ;处理完最高位数字后
		mov cx,si
		sub si,si
	Dtoc_s1:
		pop bx
		add bx,'0'
		mov ds:[si],bl
		inc si
		loop Dtoc_s1
		pop ds
		ret
	Dtoc endp
			
	;显示str段的内容在屏幕上
	show_str proc
		push dx
		push cx
		push ds			;table表的ds入栈
		mov ax,str
		mov ds,ax
		mov al,0ah
		mul dh
		add ax,0b800h
		mov es,ax		;获取具体行的段地址
		mov bh,0
		mov bl,dl
		add bl,dl		;es:bx定位地址显示字符
		mov si,0
		mov dl,cl		;dl存储要显示的color
		mov cx,8
	s0:
		mov al,ds:[si]
		mov es:[bx],al		;设置字符
		mov es:[bx+1],dl	;设置color
		inc si
		add bx,2
		loop s0

	show_str_ok:
		pop ds
		pop cx
		pop dx
		ret
	show_str endp

	;将str段字符串初始化
	str_ini proc
		push ax
		push bx
		push cx
		push es
		mov ax,str
		mov es,ax
		mov bx,0
		mov cx,8
	ini:mov byte ptr es:[bx],' '
		inc bx
		loop ini		;将str数据全部设为' '(空格)
		pop es
		pop cx
		pop bx
		pop ax
		ret
	str_ini endp
	;str_ini函数结束


        MOV AH, 4CH
        INT 21H
    MAIN ENDP
codesg ENDS
	END MAIN
