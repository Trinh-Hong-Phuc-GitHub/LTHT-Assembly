include lib1.asm
.model small
.stack 100h
.data
a db 13,10,'vao so phan tu mang: $'
b db 13,10, '[a]= $'
c db 13,10,'mang vua vao la: $'         
d dw ?
e dw 100 dup(?)
f db ' $'
g db 13,10,'tong mang la: $'
min db 13,10,'so min: $'
max db 13,10,'so max: $'
tongle db 13,10,'tong so le: $'
tongchan db 13,10,'tong so chan la: $'
timso db 13,10,'nhap so can tim: $'
socantim db 'so can tim la: $'
kotimthay db 'khong tim thay so vua nhap!$'
tieptuc db 13,10, 'co tiep tuc ct(c/k)?$'
buffvs  db 8
        db ?
        db 8 dup(?)
.code
     L0:
        clrscr
        mov ax,@data
        mov ds,ax

        HienString a
        call VAO_SO_N
        mov d,ax

        mov cx,ax
        lea bx,e
;vao mang a
      L1:
        HienString b
        call VAO_SO_N
        mov [bx],ax        
        add bx,2
        loop L1
;hien mang a
        HienString c
        mov cx,d
        lea bx,e
     L2:
        mov ax,[bx]
        call HIEN_SO_N
        HienString f
        add bx,2
        loop L2
;tong mang a
        lea bx,e
        mov cx,d
        mov ax,0
      L3:
        mov dx,[bx]
        add ax,dx
        add bx,2
        loop L3
        HienString g
        call HIEN_SO_N 
;tim so lon     
        lea bx,e
        mov cx,d
        mov ax,[bx]
     solon:
        cmp [bx],ax
        jle L4
        mov ax,[bx]
     L4:                                                                                                                                                                                                                                                                     
        add bx,2
        loop solon

        HienString max
        call HIEN_SO_N
;tim so be      
        lea bx,e
        mov cx,d
        mov ax,[bx]
     sobe:
        cmp ax,[bx]
        jle L5
        mov ax,[bx]
     L5:                                                                                                                                                                                                                                                                     
        add bx,2
        loop sobe

        HienString min
        call HIEN_SO_N
;tinh tong le
        lea bx,e
        mov cx,d
        xor ax,ax       
      L6:
        mov dx,[bx]
        shr dx,1    ;lay bit cuoi cua phan tu thu i dua vao co carry kiem tra bang 1 so le                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
        jnc sole

        add ax, [bx]   ;neu la so le thi add vao ax
   sole:
        add bx,2
        loop L6
        HienString tongle
        call HIEN_SO_N                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                
;tinh tong chan
        lea bx,e                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        mov cx,d
        mov ax,0
      L7:
        mov dx,[bx]
        shr dx,1    ;lay bit cuoi cua phan tu thu i dua vao co carry kiem tra bang 1 so chan
        jc sochan
        add ax,[bx]   ;neu la so chan thi add vao ax
   sochan:
        add bx,2
        loop L7
        HienString tongchan
        call HIEN_SO_N
;search so trong mang
        lea bx,e
        mov cx,d
        HienString timso
        call VAO_SO_N
     L8:
        mov dx,[bx]
        cmp ax,dx
        jne tim
        HienString socantim
        call HIEN_SO_N
        jmp thoat
    tim:
        add bx,2
        loop L8
        HienString kotimthay
   thoat:
        HienString tieptuc
        mov ah,1
        int 21h
        cmp al,'c'
        jne exit
        jmp L0
        
   exit:
        mov ah,4ch
        int 21h
include lib22.asm
end
