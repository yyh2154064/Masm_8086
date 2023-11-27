assume cs:codesg
data segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	;以上是表示21年的21个字符串，起始地址data:0

	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;以上是表示21年公司收入的21个dword型数据，起始地址data:84

	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	;以上是表示21年公司雇员人数的21个word新数据，起始地址data:168
	;数据段总大小210字节

    crlf db 0ah, 0dh, '$'   ;回车换行
data ends

table segment
	db 21 dup('year summ ne ?? ')
table ends		

str segment			;四字节数字转十进制的中间栈
	db ' ' dup (8)
str ends

codesg segment
	EXTRN transmit:FAR, Print:FAR
start:
	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax

	call transmit		;将数据存入table表

	mov ax,table
	mov ds,ax		;table表段地址

	call Print		;显示ds段的内容

	mov ax,4c00h
	int 21h

codesg ends
end start
