; Write a swap procedure that accepts the address of two words and it exchanges the contents of those words. Write a program to initialize two variables and after the 
; execution of the swap, the procedure displays the contents of the words. (Parameter passing needs to be done).

.MODEL SMALL
.STACK 100H
.DATA
	LF     EQU 0AH
	CR     EQU 0DH
	ENDL   DB  LF, CR, '$'

	MSSG_1 DB  'Before swap : $'
	MSSG_2 DB  'After  swap : $'

	VAR1   DW  1729
    VAR2 DW 1971
.CODE
MAIN PROC FAR
	            MOV  AX, @DATA
	            MOV  DS, AX

	            LEA  DX, MSSG_1
	            MOV  AH, 09H
	            INT  21H

	;printing numbers before swap
	            MOV  AX, VAR1
	            CALL DISP_NUMBER

	            MOV  AX, VAR2
	            CALL DISP_NUMBER

	;printing endl
	            LEA  DX, ENDL
	            MOV  AH, 09H
	            INT  21H

	;pushing address of variables onto stack
	            MOV  DX, OFFSET VAR1
	            PUSH DX
	            MOV  DX, OFFSET VAR2
	            PUSH DX

	            CALL SWAP

	            LEA  DX, MSSG_2
	            MOV  AH, 09H
	            INT  21H

	;printing numbers after swap
	            MOV  AX, VAR1
	            CALL DISP_NUMBER

	            MOV  AX, VAR2
	            CALL DISP_NUMBER

	            MOV  AH, 4CH
	            INT  21H
MAIN ENDP

SWAP PROC
	            PUSH BP             	;storing any value bp had on STACK
	            MOV  BP, SP         	;pointer to top of stack

	            MOV  SI, [BP + 4]   	;address of VAR2
	            MOV  DI, [BP + 6]   	;address of VAR1
	            MOV  AX, [SI]
	            MOV  BX, [DI]
	            MOV  [SI], BX
	            MOV  [DI], AX
     
	            POP  BP             	;restoring value of bp that was pushed on STACK
	            RET
SWAP ENDP

	;displays number stored in AX
DISP_NUMBER PROC
	            MOV  BX, 10
	            MOV  CX, 0
	DISP_PUSH:  
	            MOV  DX, 0
	            DIV  BX
	            PUSH DX
	            INC  CX
	            CMP  AX, 0
	            JNE  DISP_PUSH
	DISP_POP:   
	            POP  DX
	            ADD  DX, '0'
	            MOV  AH, 02H
	            INT  21H
	            LOOP DISP_POP
	;separate numbers by a space :
	            MOV  DX, ' '
	            MOV  AH, 02H
	            INT  21H
	            RET
DISP_NUMBER ENDP

END MAIN