section .data
 	enter: 		db '', 0ax
	lenter_tamano: equ $-enter


section .bss
	numero	resb	10
section .text
 	global _start

_start:
;	mov rax, 3
;	mov rbx, 0
;	mov rcx, numero
;	mov rdx, 10
;	int 80h
;	mov r8, numero
a:
	
	mov rax,0
  	mov rdi,0
	mov rsi, numero
	mov rdx, 10
	syscall
	mov r8, numero
b:	
	;mov rax,1	;sys_write
	;mov rdi,1	;std_out
	;mov rsi, numero	;primer parametro: Texto
	;mov rdx, 5	;segundo parametro: Tamano texto
	;syscall
c:
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi, enter	;primer parametro: Texto
	mov rdx, 10	;segundo parametro: Tamano texto
	syscall

finalizar_programa:
	 mov rax,60
  	mov rdi,0
	syscall