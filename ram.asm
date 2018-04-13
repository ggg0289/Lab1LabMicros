;-------------------------  MACRO #1  ----------------------------------
;Macro-1: impr_texto.
;	Imprime un mensaje que se pasa como parametro
;	Recibe 2 parametros de entrada:
;		%1 es la direccion del texto a imprimir
;		%2 es la cantidad de bytes a imprimir
;-----------------------------------------------------------------------
%macro impr_texto 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
%endmacro
;-------------------------  MACRO #2  ----------------------------------
;Macro-2: impr_linea.
;	Imprime un mensaje que se pasa como parametro y un salto de linea
;	Recibe 2 parametros de entrada:
;		%1 es la direccion del texto a imprimir
;		%2 es la cantidad de bytes a imprimir
;-----------------------------------------------------------------------
%macro impr_linea 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: Texto
	mov rdx,%2	;segundo parametro: Tamano texto
	syscall
  	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,cons_nueva_linea	;primer parametro: Texto
	mov rdx,1	;segundo parametro: Tamano texto
	syscall
%endmacro

section .data
 	enter: 		db'', 0ax
	lenter_tamano: equ $-enter
	
	cons_tamtotal db 'Tamano total de la RAM: 0x'
	cons_tam_ram: equ $-cons_tamtotal
	cons_ramdisponible db 'Memoria RAM disponible: 0x'
	cons_tam_disponible: equ $-cons_ramdisponible
	
	tabla: db "0123456789ABCDEF", 0
	cons_nueva_linea: db 0xa
	
	
section .bss

	resultado		resb	64
	dos_byte		resb	1
	tres_byte		resb	1
	reg_copia		resb	8
	byte_uno		resb	1
	result			resb	64
	contenido_archivo:	resb	32

section .text
 	global _start

_start:
			
			mov rdi,resultado
			mov rax,0x63
			syscall
			mov r15, resultado
a:
	
			lea ebx,[tabla]			;direcciona los valores de tabla a ebx
b:

			mov edx,[resultado + 0x20]	;busca el primer registro de memoria total de ram
bb:		
			and edx,0xF0000000		;hace un and y solo deja los 4 bits mas significativos 
			shr edx,28			;hace un corrimiento de 28 espacios a la derecha
			mov al,dl			;pone en al el valor a buscar en tabla
			xlat
			mov [dos_byte],ax			;pone en la direccion de salida el valor del numero ASCII respectivo a esos 4 bits
			impr_texto dos_byte,1
c:

			mov edx,[resultado + 0x20]	;busca el primer registro de memoria total de ram
			and edx,0x0F000000		;hace un and y solo deja los bits entre [28:24]
			shr edx,24			;hace un corrimiento de 24 espacios a la derecha 
			mov al,dl			;pone en al el valor a buscar en tabla
			xlat
			mov [dos_byte],ax			;pone en la direccion de salida el valor del numero ASCII respectivo a esos 4 bits
			impr_texto dos_byte,1
d:

			mov edx,[resultado + 0x20]
			and edx,0x00F00000
			shr edx,20
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1

e:
			mov edx,[resultado + 0x20]
			and edx,0x000F0000
			shr edx,16
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1
f:

			mov edx,[resultado + 0x20]
			and edx,0x0000F000
			shr edx,12
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1
g:

			mov edx,[resultado + 0x20]
			and edx,0x00000F00
			shr edx,8
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1

h:			 
			mov edx,[resultado + 0x20]
			and edx,0x000000F0
			shr edx,4
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1
i:

			mov edx,[resultado + 0x20]
			and edx,0x0000000F
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_linea dos_byte,1
j:

		;-------------------------------------------------------------------
		;-----Ahora se quiere imprimir el tamano disponible de memoria RAM--


			impr_texto cons_ramdisponible,cons_tam_disponible

	
			mov al,0			;pone a al en 0
			mov edx,[resultado + 0x2c]	;busca el segundo registro de memoria total de ram
			and edx,0x000F			;hace un and y deja solo los ultimos 4 bits del registro
			lea ebx,[tabla]			;direcciona los valores de tabla a ebx
			mov al,dl			;pone en al el valor a buscar en tabla
			xlat
			mov [dos_byte],ax			;pone en la direccion de salida el valor del numero ASCII respectivo a esos 4 bits
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]	;busca el primer registro de memoria total de ram
			and edx,0xF0000000		;hace un and y solo deja los 4 bits mas significativos 
			shr edx,28			;hace un corrimiento de 28 espacios a la derecha
			mov al,dl			;pone en al el valor a buscar en tabla
			xlat
			mov [dos_byte],ax			;pone en la direccion de salida el valor del numero ASCII respectivo a esos 4 bits
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]	;busca el primer registro de memoria total de ram
			and edx,0x0F000000		;hace un and y solo deja los bits entre [28:24]
			shr edx,24			;hace un corrimiento de 24 espacios a la derecha 
			mov al,dl			;pone en al el valor a buscar en tabla
			xlat
			mov [dos_byte],ax			;pone en la direccion de salida el valor del numero ASCII respectivo a esos 4 bits
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]
			and edx,0x00F00000
			shr edx,20
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]
			and edx,0x000F0000
			shr edx,16
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]
			and edx,0x0000F000
			shr edx,12
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]
			and edx,0x00000F00
			shr edx,8
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1

			 
			mov edx,[resultado + 0x28]
			and edx,0x000000F0
			shr edx,4
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_texto dos_byte,1


			mov edx,[resultado + 0x28]
			and edx,0x0000000F
			mov al,dl
			xlat
			mov [dos_byte],ax
			impr_linea dos_byte,1

			mov rax, 60
			mov rdi, 0
			syscall