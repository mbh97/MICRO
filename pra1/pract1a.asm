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
	MOV AX, 15H ; CARGA 15H EN AX
	MOV BX, 0BBH ; CARGA BBH EN BX
	MOV CX, 3412H ; CARGA 3412H EN CX
	MOV DX, CX ; CARGA EL CONTENIDO DE CX EN DX
	; CARGA CONTENIDO DE LA POSICIÓN DE MEMORIA 65636H Y 65637H EN BX
	MOV AX, 6000H ; segmento
	MOV ES, AX
	MOV BX, ES:[5636H] ; direccion física = segmento + offset  
	; CARGA EN LA POSICION DE MEMORIA 50005H EL CONTENIDO DE CH
	MOV AX, 5000H ; segmento
	MOV DS, AX
	MOV BYTE PTR DS:[5H], CH ; direccion física = segmento + offset
	MOV AX, [DI] ; CARGA EN AX EL CONTENIDO DE LA DIRECCION DE MEMORIA APUNTADA POR DI
	MOV BX, [BP+10] ;CARGA EN BX EL CONTENIDO DE LA DIRECCION DE MEMORIA QUE ESTÁ 10 BYTES POR ENCIMA DE LA DIRECCION APUNTADA POR BP
	; FIN DEL PROGRAMA
	
	MOV AX, 4C00H
	INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO