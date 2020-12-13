.MODEL SMALL
.STACK 100H
.DATA
	D1 DW 48
.CODE
MAIN PROC
	     MOV  AX,@DATA
	     MOV  DS,AX


	;DECIMAL
	     MOV  AX,D1

	     MOV  CX,0
	     MOV  DX,0
	L1:  
	     CMP  AX,0
	     JE   P1

	     MOV  BX,10
	
	     DIV  BX

	     PUSH DX
	     INC  CX
	     MOV  DX,0
	     JMP  L1

	P1:  
	     CMP  CX,0
	     JE   DEND

	     POP  DX
	     ADD  DX,48

	     MOV  AH,2
	     INT  21H

	     DEC  CX
	     JMP  P1

	DEND:
	;FOR MOVING TO THE NEXT LINE
	     MOV  DL,10
	     MOV  AH,2
	     INT  21H
	     MOV  DL,13
	     MOV  AH,2
	     INT  21H

	;BINARY
	     MOV  AX,D1

	     MOV  CX,0
	     MOV  DX,0
	L2:  
	     CMP  AX,0
	     JE   P2

	     MOV  BX,2
	
	     DIV  BX

	     PUSH DX
	     INC  CX
	     MOV  DX,0
	     JMP  L2

	P2:  
	     CMP  CX,0
	     JE   BEND

	     POP  DX
	     ADD  DX,48

	     MOV  AH,2
	     INT  21H

	     DEC  CX
	     JMP  P2

	BEND:

	;FOR MOVING TO THE NEXT LINE
	     MOV  DL,10
	     MOV  AH,2
	     INT  21H
	     MOV  DL,13
	     MOV  AH,2
	     INT  21H

	;HEXADECIMAL
	     MOV  AX,D1

	     MOV  CX,0
	     MOV  DX,0
	L3:  
	     CMP  AX,0
	     JE   P3

	     MOV  BX,16
	
	     DIV  BX

	     PUSH DX
	     INC  CX
	     MOV  DX,0
	     JMP  L3

	P3:  
	     CMP  CX,0
	     JE   HEND

	     POP  DX
	     ADD  DX,48

	     MOV  AH,2
	     INT  21H

	     DEC  CX
	     JMP  P3

	HEND:
	     MOV  AH,4CH
	     INT  21H

MAIN ENDP
END MAIN