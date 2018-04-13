%macro Imprimir_pantalla 2
	mov rax, 1 
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro leer_texto 2
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro hex_a_dec 1

%endmacro

section .data
	
	linea_0: 	db '*********************************************', 0ax				
	l0_tamano: equ $-linea_0

	enter: 		db'', 0ax
	lenter_tamano: equ $-enter

	linea_1: 	db '*********************************************', 0ax
	l1_tamano: equ $-linea_1
	
	linea_2: 	db 'No contiene las llamadas cpuid',0xa
	l2_tamano: equ $-linea_2
	
	linea_3: 	db 'Vendedor: "xxxxxxxxxxxx"', 0ax
	l3_tamano: equ $-linea_3

section .bss
	infoCPU: 	resb	16
	infoCPU2: 	resb	16
	vendor_id	resd	12
	version	resd	4
	features	resb	16
	i			resd	4
	curfeat	resd	4	
	prueba	resd	4	
	unidades	resb	4
	decenas	resb	4
	centenas	resd	4
	cuenta		resb	4
	numero	resb	4
section .text
	global _start
	global _primera
	global _segunda
	global _tercera
	global _cuarta

_start:
	
	;mov rax,80000002H
	;mov rcx,0
	;mov eax, 80000006H
	;mov ecx, 0
	;cpuid
	;mov [features], ecx
	;and dword [features], 0x
	 
	;mov [infoCPU],eax
	;mov [infoCPU + 0x4],ebx
	;mov [infoCPU + 0x8],ecx
	;mov [infoCPU + 0xc],edx

	;Imprimir_pantalla enter, lenter_tamano
	;Imprimir_pantalla features, 32
	;Imprimir_pantalla enter, lenter_tamano
	;Imprimir_pantalla enter, lenter_tamano
	
	mov ax, 0x343
	mov  [cuenta], ax
	mov r8, 100
	div r8
	mov byte [centenas], al
	add byte [centenas], 0x30
	mov rax, rdx				
	mov [cuenta], ax
	mov r8, 10
	xor rdx, rdx
	div r8
	mov byte [decenas], al
	add byte [decenas], 0x30
	mov rax,rdx
	mov  byte [unidades], al
	add byte [unidades], 0x30
	Imprimir_pantalla enter, lenter_tamano
	Imprimir_pantalla centenas, 1
	Imprimir_pantalla decenas, 1
	Imprimir_pantalla unidades, 1
	Imprimir_pantalla enter, lenter_tamano

	mov rax,60
	mov rdi,0
	syscall







