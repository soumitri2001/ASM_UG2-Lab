.MODEL SMALL
.STACK 100H
.DATA
	LF   EQU 0AH
	CR   EQU 0DH
	NM   DB  'Soumitri Chattopadhyay',LF,CR,'$'

    
.CODE
MAIN PROC FAR
	;Initialize data segment
	     MOV AX,@DATA
	     MOV DS,AX

	     LEA DX,NM
	     MOV AH,09H
	     INT 21H

	;Interupt to end program
	     MOV AH,4CH
	     INT 21H
MAIN ENDP
END MAIN