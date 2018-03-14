;**************************************************************************
;
; AUTORES: María Barroso Honrubia y Lucía Colmenarejo Pérez
; PAREJA: 07
;
;**************************************************************************
; SBM 2015. ESTRUCTURA BÁSICA DE UN PROGRAMA EN ENSAMBLADOR
;**************************************************************************
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
DATOS ENDS

;**************************************************************************
; DEFINICION DEL SEGMENTO DE PILA
PILA SEGMENT STACK "STACK"
	DB 40H DUP (0) ;ejemplo de inicialización, 64 bytes inicializados a 0
PILA ENDS

;**************************************************************************
; DEFINICION DEL SEGMENTO EXTRA
EXTRA SEGMENT
	RESULT DW 0,0 ;ejemplo de inicialización. 2 PALABRAS (4 BYTES)
EXTRA ENDS

;**************************************************************************
; DEFINICION DEL SEGMENTO DE CODIGO
CODE SEGMENT
	ASSUME CS: CODE, DS: DATOS, ES: EXTRA, SS: PILA

; COMIENZO DEL PROCEDIMIENTO PRINCIPAL
INICIO PROC

	; INICIALIZA LOS REGISTROS DE SEGMENTO CON SU VALOR
	MOV AX, DATOS
	MOV DS, AX
	MOV AX, PILA
	MOV SS, AX
	MOV AX, EXTRA
	MOV ES, AX
	MOV SP, 64 ; CARGA EL PUNTERO DE PILA CON EL VALOR MAS ALTO
	; FIN DE LAS INICIALIZACIONES

	; COMIENZO DEL PROGRAMA
	; Inicialización de DS, BX y DI
	MOV AX, 0535H
	MOV DS, AX
	MOV AX, 0210H
	MOV BX, AX
	MOV AX, 1011H
	MOV DI, AX
	
	MOV AL, BYTE PTR DS:[1234H] ; Accede a la dirección de memoria 6584H, que contiene el valor 50H
	MOV AX, DS:[BX] ; Accede a la dirección de memoria 5560H, que contiene 5500H
	MOV BYTE PTR DS:[DI], AL ; Accede a la posición de memoria 6361H
	; FIN DEL PROGRAMA
	
	MOV AX, 4C00H
	INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO