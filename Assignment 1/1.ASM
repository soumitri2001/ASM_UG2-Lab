.MODEL SMALL
.STACK 100H
.DATA
	LF   EQU 0AH
	CR   EQU 0DH
	NUM1 DB  10
	NUM2 DB  25
	
.CODE
MAIN PROC FAR
	;Initialize data segment
	     MOV AX,@DATA
	     MOV DS,AX

	     MOV AL,NUM1
	     ADD AL,NUM2
	     MOV AH,0
	     MOV DX,AX

	;Interupt to end program
	     MOV AH,4CH
	     INT 21H
MAIN ENDP
END MAIN