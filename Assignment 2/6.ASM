.model small
.stack 100h
.data
oldno dw ?
newno dw 0
count dw 0
str db 'Number : $'
multiplier dw 10
true db 'Palindrome$'
false db 'Not a Palindrome$'
.code
main proc
mov ax,@data
mov ds,ax
mov dx,offset str
mov ah,9
int 21h
mov bx,0
mov cx,10
mov dx,0
inp:
mov ah,1
int 21h
cmp al,13
je outl
mov ah,0
push ax
inc count
mov cx,ax
mov ax,bx
mul multiplier
add ax,cx
mov bx,ax
jmp inp

outl:
mov oldno,bx
mov cx,count
mov ax,0
rev:
pop bx
mov dx,10
mul dx
add ax,bx
loop rev

mov newno,ax
mov bx,oldno
cmp ax,bx
je yeah

mov dx,offset false
mov ah,9
int 21h
mov ah,4ch
int 21h


yeah:
mov dx,offset true
mov ah,9
int 21h



mov ah,4ch
int 21h

main endp
end main