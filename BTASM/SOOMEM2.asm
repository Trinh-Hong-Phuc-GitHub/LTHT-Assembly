INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
 M1  db 'May tinh dang dung co o mem khong? $'
 co  db 'co$'
 khong  db 'khong$'
 M2  db 13,10,'So luong o mem ma may tinh co la : $'
 M3 db 13,10,'Ban co tiep tuc ct khong (c/k)?$'
.CODE
 PS:
mov  ax,@data
mov  ds,ax
CLRSCR
;HienString M1   
int 11h
mov cl,7
shl al,cl            
add al,30h
mov ah, 0eh
int 10h

HienString khong
HienString M3
mov ah,1
int 21h
cmp al,'c'
jne Exit
jmp ps

jmp  Exit               
L1:
HienString co   
HienString M2   
mov cl,5           
shr  al,cl
inc  al              
add  al,30h            
mov  ah,0eh          
int 10h
HienString m3
mov  ah,1            
int  21h
cmp  al,'c'
jne  Exit              
jmp  PS         
Exit:
mov  ah,4ch            
int  21h
END
