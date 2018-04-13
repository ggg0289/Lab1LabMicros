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
%macro str2bin 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 1
	mov r9, 0
comp:	
	cmp rax, 0
	jz finalizar
	jnz continuar 
continuar:
	and rax, 0xff
	sub rax, 0x30
	mul r8
	add r9, rax
c:
	mov rax, r8
	mov r8,10
	mul r8
	mov r8, rax
	shr rbx, 8
	mov rax, rbx
	jmp comp
finalizar:
	mov rax, r9
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
	mov r8, 0x102
	add r8, 0x3030
b:
	str2bin r8
a:
	add r9, 0x30303030
	imprimir r9, 10

finalizar_programa:
	 mov rax,60
  	mov rdi,0
  syscall