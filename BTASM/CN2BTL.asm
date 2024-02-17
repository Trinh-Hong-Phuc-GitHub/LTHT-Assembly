include lib1.asm
.model small
.stack 100h
.data
n  db 13,10,'                      CHUC NANG TINH TONG CAP SO CONG '
   db 13,10,'                      ---------------o0o------------- '
   db 13,10,13,10,'              Nhap so n : $'
d  db 13,10,'              Nhap so d : $' 
u1 db 13,10,'              Nhap so u1: $'
nhapso db 13,10,'              Chi duoc nhap so lon hon 1$'
kq db 13,10,'              Tong cap so cong vua nhap la: $'
sai db 13,10,'                      CHUC NANG TINH TONG CAP SO CONG '
    db 13,10,'                      ---------------o0o------------- '
    db 13,10,13,10,'              Vao lai so n >1:$'
tieptuc db 13,10,13,10,'              Co tiep tuc CT (c/k)?$'
buffvs  db 8
        db ?
        db 8 dup(?)
.code
PUBLIC @TONGCSC$qv
@TONGCSC$qv PROC         
     L0:
        clrscr
    	mov ax, @data
    	mov ds, ax
        
    	HienString n	;hien thong bao vao so n
        lea dx,buffvs
    	call VAO_SO_N	;nhap vao n
        jmp check
;check chi duoc nhap so      
    check:
        mov si,dx
        add si,1
        mov cl,[si]
        xor ch,ch
     check1:                                                                                                                                                                                                                                                                                                                            
        inc si
        mov bl,[si]
        xor bh,bh
        cmp bl,'-'
        jne tt
        mov bl,[si+1]
     tt:
        cmp bl,30h
        jb tt1
        cmp bl,39h
        ja tt1
        Loop check1
        jmp check2 
     tt1:
        HienString nhapso
        mov ah,1
        int 21h
        jmp L0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
     check2:
        cmp ax,1        ;so sanh n voi 1
        jle tt1          ;n<=1 nhay den L1
        mov cx,ax	;neu n>1 gan cx=n
        jmp L2		;nhay den L2
;     L1:
 ;       clrscr
  ;      HienString sai
   ;     call VAO_SO_N   ;vao lai so n
    ;    cmp ax,1        ;so sanh n voi 1
     ;   jle check          ;n<=1 nhay den L1
      ;  mov cx,ax       ;neu n>1 gan cx=n
       ; jmp L2          ;nhay den L2
     L2:
	HienString d	
	call VAO_SO_N	;nhap vao so d
	mov bx,ax	;gan bx=d
	HienString u1	
	call VAO_SO_N	;vao so u1
	mov dx,ax   	;gan dx,u1
        dec cx		;thuc hien loop, cx giam di 1 moi lan lap
     L3:
        add dx,bx      	;thuc hien tinh toan dx= u1+d       
	add ax,dx	;thuc hien ax = ax+dx
    	loop L3		;lap lai L3
		
        HienString kq	;hien thong bao ket qua
        call HIEN_SO_N	;hien ket qua ra man hinh

        HienString tieptuc
        mov ah,1
        int 21h
	cmp al,'c'
	jne Thoat
	jmp L0
     Thoat:
        ret
@TONGCSC$qv ENDP
include lib22.asm
END
