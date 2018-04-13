;-------------------------  MACRO #1  ----------------------------------
;Macro-2: impr_linea.
;	Imprime un mensaje que se pasa como parametro y un salto de linea
;	Recibe 2 parametros de entrada:
;		%1 es la direccion del texto a imprimir
;		%2 es la cantidad de bytes a imprimir
;-----------------------------------------------------------------------
%macro imprimir_linea 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
  	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi, enter	;primer parametro: Texto
	mov rdx,1	;segundo parametro: Tamano texto
	syscall
%endmacro
;------------------------- FIN DE MACRO --------------------------------

;-------------------------  MACRO #2  ----------------------------------
;Macro-1: impr_texto.
;	Imprime un mensaje que se pasa como parametro
;	Recibe 2 parametros de entrada:
;		%1 es la direccion del texto a imprimir
;		%2 es la cantidad de bytes a imprimir
;-----------------------------------------------------------------------
%macro imprimir 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
%endmacro
;------------------------- FIN DE MACRO --------------------------------

;-------------------------  MACRO #3  ----------------------------------
;Macro-1: hex_a_dec
;	Convierte un valor HEX de 1 digitos y lo imprime como decimal en la consola
;	Recibe 1 parametro de entrada:
;		%1 es el valor hex que se desea imprimir en la consola
;-----------------------------------------------------------------------
%macro hex2dec 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 1000000000000000000
comp:	
	div r8
	cmp rax, 0
	jz div
	jnz continuar 
div:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	jmp comp
div2:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	div r8
	jmp continuar
continuar:
	mov r9, rdx
	mov byte [numero], al
	add byte [numero], 0x30
	imprimir numero, 1
	mov rdx, r9
	mov rbx, rdx
	cmp rdx, 0
	jnz div2
	jz finalizar
finalizar:
	imprimir enter,1
%endmacro
;------------------------- FIN DE MACRO --------------------------------

section .data
 	enter: 		db'', 0ax
	lenter_tamano: equ $-enter
section .bss
	numero	resb	4
section .text
 	global _start

_start:
i:	mov r8, 1
a:	
	hex2dec r8

finalizar_programa:
	 mov rax,60
  	mov rdi,0
  syscall
