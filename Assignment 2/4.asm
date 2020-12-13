.MODEL SMALL
.STACK 100H
.DATA
	ARR  DW 12,124,37,322,49,63,26,48,50,25,'$'
	BASE DW 10
.CODE
MAIN PROC
	     MOV  AX,@DATA
	     MOV  DS,AX
	     MOV  CX,10   	;this can be less than 10(for safety we run the loop for MAX 10 times)
	L1:  
	     LEA  SI,ARR  	;SI->Source Index  DI-Destination Index(points to the current pointer)
	     LEA  DI,ARR  	;LEA->Load Effective Address
	     INC  DI      	; incrementing two times as it is DW
	     INC  DI
	L2:  
	     MOV  AX,[SI]
	     MOV  BX,[DI]
	     CMP  AX,[DI] 	;compare if greater
	     JG   L3
	     MOV  [SI],BX
	     MOV  [DI],AX
	L3:  
	     INC  SI
	     INC  SI
	     INC  DI
	     INC  DI
	     MOV  AX,[DI]
	     CMP  AX,'$'  	;check if the last digit is reached
	     JE   L4
	     JMP  L2
	L4:  
	     LOOP L1
	     LEA  SI,ARR  	;pointing again to the start

	;NOW WE PRINT THE NUMBERS
	L5:  
	     MOV  AX,[SI]
	     CMP  AX,'$'  	;check if end of the list is reached
	     JE   L9
	     MOV  BX,BASE
	     MOV  CX,'$'
	     PUSH CX
	L6:  
	     MOV  DX,0
	     DIV  BX      	;The [ax|dx] is being divided bx and the result is stored in [ax]->Q and [dx]->R
	     PUSH DX      	;we are pushing each number digit-by-digit into the stack
	     CMP  AX,0
	     JE   L7
	     JMP  L6
	L7:  
	     POP  DX
	     CMP  DX,'$'
	     JE   L8      	;we are popping and printing each digit of the number that was pushed latest
	     ADD  DX,48
	     MOV  AH,02H
	     INT  21H
	     JMP  L7
	L8:  
	     MOV  DX,' '  	;printing the space between two numbers
	     MOV  AH,02H
	     INT  21H
	     INC  SI      	;incrementing 2 times
	     INC  SI
	     JMP  L5
	L9:  
	     MOV  AH,4CH
	     INT  21H
MAIN ENDP
END  MAIN