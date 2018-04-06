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

section .data
	
	linea_0: 	db '*********************************************', 0ax
				db '*   Instituto tecnologico de Costa Rica     *', 0ax
				db '*   Integrantes:                            *', 0ax
				db '*   Gerardo Esteban Gonzalez Gutierrez      *', 0ax
	 			db '*   Diego Aníbal Navarro Carrillo           *', 0ax
		 		db '*   Meylin Adrea Chacón Barquero:           *', 0ax
				db '*********************************************', 0ax
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
	infoCPU: 	resb	48
	vendor_id	resd	12
	version	resd	4
	features	resd	4
	i			resd	4
	curfeat	resd	4	
	prueba	resd	4	
section .text
	global _start
	global _primera
	global _segunda
	global _tercera
	global _cuarta
names db 'FPU VME DE PSE TSC MSR PAE MCE CX8 APIC RESV SEP MTRR PGE MCA CMOV PAT PSE3 PSN CLFS RESV DS ACPI MMX FXSR SSE SEE2 SS HTT TM RESV PBE'

_start:

	Imprimir_pantalla linea_0, l0_tamano
	
	mov rax,80000000H
	cpuid
	mov r8,80000004H
	cmp rax,r8
	jb .error

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
	
	Imprimir_pantalla infoCPU, 48	
	Imprimir_pantalla enter, lenter_tamano

	mov eax, 0
	cpuid

	mov [linea_3+11], ebx
	mov [linea_3+15], edx
	mov [linea_3+19], ecx
	Imprimir_pantalla linea_3, l3_tamano
;***************************************************************************************
	mov [version],eax
	mov [features],ebp
	mov [i], esi
	mov [curfeat], edi
	mov [prueba], esp
	
	Imprimir_pantalla vendor_id, 12
Imprimir_pantalla enter, 1
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1
	Imprimir_pantalla features, 4
Imprimir_pantalla enter, 1
	Imprimir_pantalla i, 4
Imprimir_pantalla enter, 1
	Imprimir_pantalla curfeat, 4
Imprimir_pantalla enter, 1
	Imprimir_pantalla prueba, 4
Imprimir_pantalla enter, 1
	
	Imprimir_pantalla linea_1, l1_tamano
	
	mov eax, 0h
	cpuid

	mov [version], ebx
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version], edx
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version], ecx
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version],eax
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version],ebp
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version], esi
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version], edi
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1

	mov [version], esp
	add dword [version], 30303030h
	Imprimir_pantalla version, 4
Imprimir_pantalla enter, 1


	Imprimir_pantalla linea_1, l1_tamano

;mov [100000f0h],ebx ;break program for debugging

;;########################## A FOR LOOP ###################################################
;;for(i = 8; i != 0; i++){
mov	eax,00000001h
mov	[curfeat],eax
mov     eax,-1
mov     [i],eax
.loop:
;;--i
	mov     eax,[i] 
	inc eax         ;(i++)
	cmp     eax,31
	jz     .quitloop   ;quit loop if reached limit
	mov     [i],eax    ;put updated value on stack

;get current feature
        mov ebx,[curfeat]
;test for feature - if feature exists ebx is non zero
	and ebx,[features]
;left shift to test for next feature (will be used in next iteration of loop)
	mov eax,[curfeat]
        shl eax,1
        mov [curfeat],eax


;jump if feaure not exist
cmp ebx,0 
jz .loop ;check if zero flag is set - if it is it means that the feature didn't exist so we don't want to print anything out
;;otherwise this feature must exist lets print it out...
        mov     eax,[i] ;get value from stack           0x080480bf
        mov     edx,5   ;message length
        mov     ecx,names     ;message to write (msg is a pointer to the start of the string
times 5	add	ecx,eax
	
        mov     ebx,1   ;file descriptor (stdout)
        mov     eax,4   ;system call number (sys_write) 0x080480b7
        int     0x80    ;call kernel                    0x080480be

	jmp .loop ; unconditional jump
;}
.quitloop:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov	eax,1	;system call number (sys_exit)
	mov	ebx,0	;exit status 0 (if not used is 1 as set before) "echo $?" to check
	int	0x80	;call kernel

	mov rax, 60
	mov rdi, 0
	syscall


;##################################################
;;;;el siguiente contenido es parte de la primera progra 
.error:
	Imprimir_pantalla enter, lenter_tamano

	
	Imprimir_pantalla linea_2, l2_tamano

	mov rax,60
	mov rdi,0
	syscall
