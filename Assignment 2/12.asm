.MODEL SMALL
.STACK 64
.DATA
	MSG    DB &#39         	;MEMORY SIZE IN KILO BYTES=&#39;
	ASCRES DB 4 DUP(?),&#39	;HEX&#39;,0CH,0AH,&#39;$&#39;
	RES    DW ?
HEXCODE DB &#39;0123456789ABCDEF&#39;
.CODE
HEX_ASC PROC
	        MOV  DL,10H
	        MOV  AH,0
	        MOV  BX,0
	        DIV  DL
	        MOV  BL,AL
	        MOV  DH,HEXCODE[BX]
	        MOV  BL,AH
	        MOV  DL,HEXCODE[BX]
	        RET
HEX_ASC ENDP
	MAIN:   
	        MOV  AX,@DATA

	        MOV  DS,AX
	        INT  12H
	        MOV  RES,AX
	        MOV  AL,BYTE PTR RES
	        CALL HEX_ASC
	        MOV  ASCRES+2,DH
	        MOV  ASCRES+3,DL
	        MOV  AL,BYTE PTR RES+1
	        CALL HEX_ASC
	        MOV  ASCRES,DH
	        MOV  ASCRES+1,DL
	        MOV  DX,OFFSET MSG
	        MOV  AH,09H
	        INT  21H
	        MOV  AH,4CH
	        INT  21H
ALIGN 16
END MAIN