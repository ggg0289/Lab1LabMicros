%macro Imprimir 2
	mov rax, 1 
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro leer 1
	mov rax, 0 
	mov rdi, 0
	mov rsi, %1
	mov rdx, 10
	syscall
%endmacro

%macro leer_texto 2
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro str2bin 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
;****************
	mov rsi, %1
	mov rbx, 0
	lodsb
comp2:
	cmp rax, 0xff
	jg finalizar2
        cmp rax, 0x3a
	jge error2
	cmp rax, 0x30
	jge ajuste
	cmp rax, 0xa
	jz continuar2
	jmp finalizar2
error2:
	Imprimir error, lerror ;se introdujo alguna letra 
	jmp finalizar2
ajuste:
	shl rbx, 8
	or rbx, rax
	lodsb
	jmp comp2
continuar2:
	mov rax, rbx
	mov r8, 1
	mov r9, 0
comp3:	
	cmp rax, 0
	jz finalizar2
	jnz continuar3
continuar3:
	and rax, 0xff
	sub rax, 0x30
	mul r8
	add r9, rax
	mov rax, r8
	mov r8,10
	mul r8
	mov r8, rax
	shr rbx, 8
	mov rax, rbx
	jmp comp3
finalizar2:
	mov rax, r9
	Imprimir enter,1
%endmacro
;****************************************
%macro espera 0 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	xor rdi, rdi 	
	xor rsi, rsi
	mov rax, 1
	mov rbx, 100
	mul rbx		 ; se le agrega 100 veces 10ms al tiempo 
	mov rbx, rax
	mov rax, 100
	syscall
	add rax, rbx
	mov rbx, rax
cuenta:
	mov rax, 100
	syscall
	cmp rax, rbx
	jg finalizar_2
	jmp cuenta
finalizar_2:
%endmacro
;********************************************************
%macro hex2dec 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 10000000000000000000
	xor rdx,rdx
	xor rcx, rcx
comp:	
	div r8
	cmp rax, 0
	je div
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
	Imprimir numero, 1
	mov rdx, r9
	mov rbx, rdx
	cmp rdx, 0
	jnz div2
	jz finalizar
finalizar:
	Imprimir enter,1
%endmacro
;********************************************
%macro hex2dec4 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 10000000000000000000
	xor rdx,rdx
	xor rcx, rcx
comp_5:	
	div r8
	cmp rax, 0
	je div_5
	jnz continuar_5 
div_5:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	jmp comp_5
div2_5:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	div r8
	jmp continuar_5
continuar_5:
	mov r9, rdx
	mov byte [numero], al
	add byte [numero], 0x30
	Imprimir numero, 1
	mov rdx, r9
	mov rbx, rdx
	cmp rdx, 0
	jnz div2_5
	jz finalizar_5
finalizar_5:
	Imprimir enter,1
%endmacro
;**************************************************
%macro hex2dec2 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 10000000000000000000
	xor rdx,rdx
	xor rcx, rcx
comp_:	
	div r8
	cmp rax, 0
	je div_
	jnz continuar_ 
div_:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	jmp comp_
div2_:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	div r8
	jmp continuar_
continuar_:
	mov r9, rdx
	mov byte [numero], al
	add byte [numero], 0x30
	Imprimir numero, 1
	mov rdx, r9
	mov rbx, rdx
	cmp rdx, 0
	jnz div2_
	jz finalizar_
finalizar_:
	Imprimir enter,1
%endmacro
;**************************************************
%macro hex2dec3 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 10000000000000000000
	xor rdx,rdx
	xor rcx, rcx
comp_1:	
	div r8
	cmp rax, 0
	je div_1
	jnz continuar_1 
div_1:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	jmp comp_1
div2_1:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	div r8
	jmp continuar_1
continuar_1:
	mov r9, rdx
	mov byte [numero], al
	add byte [numero], 0x30
	Imprimir numero, 1
	mov rdx, r9
	mov rbx, rdx
	cmp rdx, 0
	jnz div2_1
	jz finalizar_1
finalizar_1:
	Imprimir enter,1
%endmacro
;*************************************************************
%macro hex2dec5 1 	;Recibe como parametro el numero HEX y el numero de digitos del numero en decimal
	mov rax, %1
	mov rbx, rax
	mov r8, 10000000000000000000
	xor rdx,rdx
	xor rcx, rcx
comp_6:	
	div r8
	cmp rax, 0
	je div_6
	jnz continuar_6 
div_6:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	jmp comp_6
div2_6:
	xor rdx, rdx
	mov rax, r8
	mov r8, 10
	div r8
	mov r8, rax
	mov rax, rbx
	div r8
	jmp continuar_6
continuar_6:
	mov r9, rdx
	mov byte [numero], al
	add byte [numero], 0x30
	Imprimir numero, 1
	mov rdx, r9
	mov rbx, rdx
	cmp rdx, 0
	jnz div2_6
	jz finalizar_6
finalizar_6:
	Imprimir pct,lpct
	Imprimir enter,1
%endmacro
;*************************************************************
%macro monitoreo 1
	mov r10, %1
cuen:
	mov rdi, ram
	mov rax, 0x63
	syscall
	Imprimir linea_8, l8_tamano
	mov edx, [ram + 0x28]
	shr edx, 10 ; ajuste para que quede en kb
	mov rax, rdx
	mov r14, rdx
	hex2dec3  rax
	
	mov r13, r15
	sub r13, r14
	mov rax, r13
	mov rcx, 100
	mul rcx
	div r15
	mov r14, rax
	Imprimir linea_10, l10_tamano
	hex2dec5 r14	
	
	espera

	dec r10
	cmp r10, 0
	je finalizar_3
	jmp cuen
finalizar_3:
%endmacro
;*************************************************************
%macro disco 0
	mov ebx, dirdisco
	mov eax, 5
	mov ecx, 0
	mov edx, 0
	int 80h
	mov eax,3
	mov ebx,3
	mov ecx, disc
	mov edx, 200
	int 80h
	;obtenemos el tamaño del disco duro pero en unidades de bloques 44504672:
	mov edx,[disc + 4]	;busca el segundo registro de memoria total de ram
	and edx,0x0F000000			;hace un and y deja solo los ultimos 4 bits del registro
	shr edx, 24
	mov eax,edx			;pone en la direccion de salida el valor del numero ASCII respectivo a esos 4 bits

	mov edx,[disc + 4]
	and edx,0x000F0000
	shr edx,12
	or eax,edx

	mov edx,[disc + 4]
	and edx,0x00000F00
	or eax,edx

	mov edx,[disc + 4]
	and edx,0x0000000F
	shl edx,12
	or eax,edx

	mov edx,[disc]
	and edx,0x0F000000
	shr edx,8
	or eax,edx

	mov edx,[disc]
	and edx,0x000F0000
	shl edx,4
	or eax,edx

	mov edx,[disc]
	and edx,0x00000F00
	shl edx,16
	or eax,edx

	mov edx,[disc]
	and edx,0x0000000F
	shl edx,28
	or eax,edx
; se convirten el valor de las unidades de bloque a 
	mov r8, 0x512
	mov r9, 0x1000000000
	mul r8
	div r9
%endmacro

section .data
	
	linea_0: 	db '*********************************************', 0ax
				db '*   Instituto tecnologico de Costa Rica     *', 0ax
				db '*   Integrantes:                            *', 0ax
				db '*   Gerardo Esteban Gonzalez Gutierrez      *', 0ax
		 		db '*   Meylin Adrea Chacón Barquero:           *', 0ax
				db '*********************************************', 0ax
	l0_tamano: equ $-linea_0

	enter: 		db'', 0ax
	lenter_tamano: equ $-enter
	
	pct: 		db'%', 0ax
	lpct: 		equ $-pct

	dirdisco: 	db  '/sys/block/sda/size', 0
	
	linea_1: 	db '*********************************************', 0ax
	l1_tamano: equ $-linea_1
	
	linea_2: 	db 'No contiene las llamadas cpuid',0xa
	l2_tamano: equ $-linea_2
	
	linea_3: 	db 'Vendedor: "xxxxxxxxxxxx"', 0ax
	l3_tamano: equ $-linea_3

	linea_4: 	db 'Num de nucleos del procesador: "x"', 0ax
	l4_tamano: equ $-linea_4

	linea_5: 	db 'Linea de cache en bytes del procesador: '
	l5_tamano: equ $-linea_5

	linea_6: 	db 'Ingrese el numero de segundos de monitoreo (max 15):', 0ax
	l6_tamano: equ $-linea_6
	
	linea_7: 	db 'Memoria Ram Total (kb):'
	l7_tamano: equ $-linea_7

	linea_8: 	db 'Memoria Ram disponible (kb):'
	l8_tamano: equ $-linea_8

	linea_9: 	db 'Disco duro total (Gb):'
	l9_tamano: equ $-linea_9

	linea_10: 	db 'Porcentaje de Mem Ram usada:'
	l10_tamano: equ $-linea_10

	error: 		db 'ERROR ingreso un caracter no numerico', 0ax 
	lerror:		equ $-error

section .bss
	numero:	resb	4	;para el macro de hex2dec
	infoCPU: 	resb	48
	num:	resb	10
	ram:	resb	64 		
	disc: 	resb 	32
section .text
	global _start
	global _error
_error:
	Imprimir enter, lenter_tamano
	Imprimir linea_2, l2_tamano
	jmp fin
_start:

	Imprimir linea_0, l0_tamano
	
	mov rax,80000000H
	cpuid
	mov r8,80000004H
	cmp rax,r8
	jb _error

	mov rax,80000002H
	cpuid
	mov [infoCPU],rax
	mov [infoCPU + 0x4],rbx
	mov [infoCPU + 0x8],rcx
	mov [infoCPU + 0xc],rdx

	mov rax,80000003H
        cpuid
        mov [infoCPU + 0x10],rax
        mov [infoCPU + 0x14],rbx
        mov [infoCPU + 0x18],rcx
        mov [infoCPU + 0x1c],rdx

	mov rax,80000004H
        cpuid
        mov [infoCPU + 0x20],rax
        mov [infoCPU + 0x24],rbx
        mov [infoCPU + 0x28],rcx
        mov [infoCPU + 0x2c],rdx
	
	Imprimir infoCPU, 48	
	Imprimir enter, lenter_tamano

	mov eax, 0
	cpuid

	mov [linea_3+11], ebx
	mov [linea_3+15], edx
	mov [linea_3+19], ecx
	Imprimir linea_3, l3_tamano

	mov rax, 0x01
	cpuid
	mov r8, rbx
	shr r8, 16
	add r8, 0x30
	mov rax, r8
	mov [linea_4+32], al
	Imprimir linea_4,l4_tamano
;***************************************************************************************
	Imprimir linea_5, l5_tamano
	mov rax, 0x01
	cpuid
	mov r8, rbx
	and r8, 0xff00
	shr r8, 8
	mov rax, r8
	mov r9, 0x8
	mul r9
	hex2dec rax

;***************************************************************************************
	Imprimir linea_7, l7_tamano
	mov rdi, ram
	mov rax, 0x63
	syscall
	mov edx, [ram + 0x20]
	shr edx, 10 ; ajuste para que quede en kb
	mov rax, rdx
	mov r15, rax
	hex2dec2  rax
;***************************************************************************************
	Imprimir linea_9, l9_tamano
	disco
	hex2dec4 rax
;***************************************************************************************
	Imprimir linea_6, l6_tamano
	leer num
	str2bin num		;el resultado es colocado en r9
;***************************************************************************************

;***************************************************************************************

	monitoreo r9

;*********

fin:
	mov rax,60
	mov rdi,0
	syscall
