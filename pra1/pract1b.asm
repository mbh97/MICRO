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
	CONTADOR DB ?
	TOME DW 0CAFEH
	TABLA100 DB 100 dup (?) ; Reserva 100 bytes 
	ERROR1 DB "Atención: Entrada de datos incorrecta."
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
	MOV AL, ERROR1[6H-1H]
	MOV TABLA100[63H-1H], AL ; Copia el sexto caracter de ERROR1 en TABLA100[63H] modificando el tipo de datos a BYTE, DS:[0065H]
	MOV AX, TOME
	MOV WORD PTR TABLA100[23H-1H], AX ; Copia TOME en TABLA100[23H] modificando el tipo de datos a WORD, DS:[0025H]
	MOV CONTADOR, AH ; byte mas significativo de TOME en CONTADOR, DS:0000
	; FIN DEL PROGRAMA
	
	MOV AX, 4C00H
	INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO