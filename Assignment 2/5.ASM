.MODEL SMALL
.STACK 100H
.DATA
	

	STR1 DB 'Soumitri','$'
	STR2 DB 'Chattopadhyay','$'

.CODE
MAIN PROC FAR
	         MOV AX,@DATA
	         MOV DS,AX

	         MOV AL,0    	;AL and BL used to store lengths
	         MOV BL,0

	         LEA SI,STR1
	         LEA DI,STR2

	         
           
	L1:      
	         MOV AL,[SI]
	         MOV BL,[DI]

	         CMP AL,BL
	         JL  L2
	         JG  L3
	         INC SI
	         INC DI
	         JMP L1

	L2:      LEA DX,STR1 	;print str1 first
	         MOV AH,09H
	         INT 21H

	        
	         LEA DX,STR2
	         MOV AH,09H
	         INT 21H
	         JMP END_PROG

	L3:      LEA DX,STR2 	;print str2 first
	         MOV AH,09H
	         INT 21H

	         
	         LEA DX,STR1
	         MOV AH,09H
	         INT 21H
	         JMP END_PROG
             
	END_PROG:
	         MOV AH, 4CH
	         INT 21H
MAIN ENDP
END MAIN