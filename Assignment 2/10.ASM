; Assume that two variables x and y are stored in packed 
; BCD format. Write an 8086 alp to add x and y using DAA 
; and display the result in packed BCD format also. Do 
; the same addition without using DAA.

.MODEL SMALL
.STACK 100H
.DATA
	LF     EQU 0AH
	CR     EQU 0DH
	ENDL   DB  LF, CR, '$'

	MSSG_1 DB  'Using DAA 15 + 23 = $'
	MSSG_2 DB  'Without Using DAA 15 + 23 = $'

	X      DB  15H
	Y      DB  23H

	R1     DB  0                              	;result using DAA
    R2 DB 0 ;result without using DAA
.CODE
MAIN PROC FAR
	         MOV  AX, @DATA
	         MOV  DS, AX

	;using DAA
	         MOV  AL, X
	         MOV  BL, Y
	         ADD  AL, BL
	         DAA
	         MOV  R1, AL

	         LEA  DX, MSSG_1
	         MOV  AH, 09H
	         INT  21H

	         MOV  AL, R1
	         CALL DISP_BCD

	;Print ENDL
	         LEA  DX, ENDL
	         MOV  AH, 09H
	         INT  21H

	;Perfroming same addition without DAA

	         MOV  AH, 0
	         MOV  AL, X
	         MOV  BL, 16
	         DIV  BL        	;divide the number into its two parts
	         MOV  CL, AL    	;AL -  Most Significant Digit of X
	         MOV  CH, AH    	;AH - Least Significant Digit of Y

	         MOV  AH, 0
	         MOV  AL, Y
	         MOV  BL, 16
	         DIV  BL        	;divide the number into its two parts
	         MOV  DL, AL    	;AL -  Most Significant Digit of Y
	         MOV  Dh, AH    	;AH - Least Significant Digit of X


	;first adding LSDs
	         MOV  AH, 0
	         ADD  CH, DH    	;Carry might be generated
	         MOV  AL, CH
	         MOV  BL, 10
	         DIV  BL        	;divide the number into its two parts
	         ADD  CL, AL    	;add carry to MSD of X
	         MOV  DH, AH    	;LSD of result

	;now adding MSDs with carry[added to CL]
	         MOV  AH, 0
	         ADD  DL, CL    	;might generate overflow so need to truncate it in following line
	         MOV  AL, DL    	;truncate the overflow
	         MOV  BL, 10
	         DIV  BL
	         MOV  DL, AH    	;MSD of result

	;form BDC format and store in R2
	         MOV  AH, 0
	         MOV  AL, DL
	         MOV  BL, 16
	         MUL  BL        	;MSD shifted 4bits
	         ADD  AL, DH    	;LSD added
	         MOV  R2, AL

	         LEA  DX, MSSG_2
	         MOV  AH, 09H
	         INT  21H

	         MOV  AL, R2
	         CALL DISP_BCD

	         MOV  AH, 4CH
	         INT  21H
MAIN ENDP

	;displays number stored in AL in BCD format
DISP_BCD PROC
	         MOV  AH, 0
	         MOV  BL, 16
	         DIV  BL        	;divide the number into its two parts
	;AL - Most Significant Digit
	;AH - Least Significant Digit
	         MOV  CL, AL
	         MOV  CH, AH

	;print MSD
	         MOV  DH, 0
	         MOV  DL, CL
	         ADD  DX, '0'
	         MOV  AH, 02H
	         INT  21H

	;print LSD
	         MOV  DH, 0
	         MOV  DL, CH
	         ADD  DX, '0'
	         MOV  AH, 02H
	         INT  21H

	         RET
DISP_BCD ENDP

END MAIN