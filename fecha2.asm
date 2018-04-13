
section .data
 	enter: 		db'', 0ax
	lenter_tamano: equ $-enter
section .bss
	fecha		resb		4
section .text
 	global _start

_start:
b:
	MOV AH, 2AH
	INT 21H
a: