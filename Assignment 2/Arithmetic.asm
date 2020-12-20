.MODEL SMALL
.STACK 100H

PRINTSTR MACRO STRVAL  		;FOR PRINTING A STRING
	         LEA DX, STRVAL
	         MOV AH, 09H
	         INT 21H
ENDM

ACCVAL MACRO VAL  		;ACCEPTING A CHARACTER
	       MOV AH, 1H
	       INT 21H
	       SUB AL, 48
	       MOV VAL, AL
ENDM

ACCNUM MACRO NUM, FL
	         LOCAL ACCNUML1, ACCNUML2, X1, X2
	         MOV   NUM, 0
	         MOV   CL, 10
	         MOV   CH, 00
	         MOV   BL, 0
	         MOV   DX, 0
	         MOV   FL, 0
  
	ACCNUML1:
	         MOV   AX, NUM
	         MUL   CX
	         MOV   BX, AX
	         MOV   AH, 01H
	         INT   21H
	         CMP   AL, 13
	         JE    SHORT ACCNUML2
	         CMP   AL, '-'
	         JNE   SHORT X1
	         MOV   FL, 1
	         JMP   SHORT ACCNUML1
  
	X1:      
	         SUB   AL, 48
	         MOV   AH, 00H
	         ADD   BX, AX
	         MOV   NUM, BX
	         JMP   SHORT ACCNUML1
  
	ACCNUML2:
	         CMP   FL, 0
	         JE    X2
	         MOV   AX, NUM
	         NOT   AX
	         ADD   AX, 1
	         MOV   NUM, AX
	X2:      
ENDM
    
PRINTNUM MACRO NUM
	           LOCAL PRINTNUML1, PRINTNUML2, PRINTNUML3, X1, X2
	           MOV   CL, 10
	           MOV   CH, 00
	           MOV   AX, '$'
	           PUSH  AX
	           MOV   AX, NUM
	           MOV   BX, NUM
	           ROL   BX, 1
	           JNC   SHORT PRINTNUML1
	           NOT   AX                                        	;THE MAGNITUDE
	           ADD   AX, 1
  
	PRINTNUML1:
	           MOV   DX, 0
	           DIV   CX
	           PUSH  DX
	           CMP   AX, 0
	           JE    SHORT PRINTNUML2
	           JMP   SHORT PRINTNUML1
  
	PRINTNUML2:
	           MOV   BX, NUM
	           ROL   BX, 1
	           JNC   SHORT X1
	           MOV   AX, '-'
	           PUSH  AX
	
	X1:        
	           POP   DX
	           CMP   DX, '$'
	           JE    SHORT PRINTNUML3
	           CMP   DX, '-'
	           JE    SHORT X2
	           ADD   DX, 48
	
	X2:        
	           MOV   AH, 02H
	           INT   21H
	           JMP   SHORT X1
  
	PRINTNUML3:
ENDM

ADDN MACRO NUM1, NUM2, R
	     MOV AX, NUM1
	     MOV BX, NUM2
	     ADD AX, BX
	     MOV R, AX
ENDM

SUBS MACRO NUM1, NUM2, R
	     MOV AX, NUM1
	     MOV BX, NUM2
	     SUB AX, BX
	     MOV R, AX
ENDM

MULT MACRO NUM1, NUM2, R
	     MOV AX, NUM1
	     MOV CX, NUM2
	     MUL CX
	     MOV R, AX
ENDM

DIVD MACRO NUM1, NUM2, R
	     MOV AX, NUM1
	     MOV DX, 0000H
	     MOV CX, NUM2
	     DIV CX
	     MOV R, AX
ENDM

MODL MACRO NUM1, NUM2, R
	     MOV AX, NUM1
	     MOV DX, 0000H
	     MOV CX, NUM2
	     DIV CX
	     MOV R, DX
ENDM

.DATA
	LF     EQU 0AH
	CR     EQU 0DH
	STROPT DB  "1. ADD",LF,CR,"2. SUBTRACT",LF,CR,"3. MULTIPLY",LF,CR,"4. DIVIDE(INTEGER)",LF,CR,"5. MODULO",LF,CR,"ENTER CHOICE: $"
	STR1   DB  " ",LF,CR,"ENTER NUMBER: $"
	STR2   DB  " ",LF,CR,"THE RESULT IS: $"
	OP     DB  ?
	FL     DB  ?
	NO1    DW  ?
	NO2    DW  ?
	RES    DW  ?

.CODE
MAIN PROC
	BEGIN:
	      MOV      AX, @DATA
	      MOV      DS, AX
	      PRINTSTR STROPT
	      ACCVAL   OP
	
	      PRINTSTR STR1
	      ACCNUM   NO1, FL
	
	      PRINTSTR STR1
	      ACCNUM   NO2, FL
    
	;PRINTNUM NO1
	;PRINTNUM NO2
	
	      CMP      OP, 1
	      JNE      OPT2
	      ADDN     NO1, NO2, RES
	      JMP      PRNT
	
	OPT2: 
	      CMP      OP, 2
	      JNE      OPT3
	      SUBS     NO1, NO2, RES
	      JMP      PRNT
	
	OPT3: 
	      CMP      OP, 3
	      JNE      OPT4
	      MULT     NO1, NO2, RES
	      JMP      PRNT
	;JMP ADD
    
	OPT4: 
	      CMP      OP, 4
	      JNE      OPT5
	      DIVD     NO1, NO2, RES
	      JMP      PRNT
    
	OPT5: 
	      CMP      OP, 5
	      JNE      EXIT
	      MODL     NO1, NO2, RES
	
	PRNT: 
	      PRINTSTR STR2
	      PRINTNUM RES
	EXIT: 
	      MOV      AH, 4CH
	      INT      21H
MAIN ENDP

END MAIN