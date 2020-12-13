.MODEL SMALL
.STACK 100H
.DATA
	STRING DB 50 DUP('$')
.CODE
MAIN PROC
	           MOV AX,@DATA
	           MOV DS,AX

	           MOV SI, OFFSET STRING
	L1:        
	           MOV AH,1
	           INT 21H

	           CMP AL,13
	           JE  PROGRAMEND
	
	           MOV [SI],AL
	           INC SI
	           JMP L1
	PROGRAMEND:

	           MOV DX,OFFSET STRING
	           MOV AH,9
	           INT 21H

	           MOV AH,4CH
	           INT 21H
MAIN ENDP
END MAIN