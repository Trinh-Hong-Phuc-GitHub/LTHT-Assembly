include lib1.asm
.model small
.stack 100h
.data
a db  13,10,'Nhap vao so phan tu trong day: $'
b db  13,10, 'Vui long nhap: $'
c db  13,10,'Day so ban vua nhap la: $'        
d dw ?
e dw 100 dup(?)
f db ' $'
min db  13,10,'So be nhat trong day la: $'
min2 db  13,10,'So be thu 2 trong day la: $'
tieptuc db  13,10, 'co tiep tuc ct(c/k)?$'
buffvs db 8
  db ?
  db 8 dup(?)
.code
PUBLIC _MINDAYSO
_MINDAYSO PROC
  clrscr
  L0:
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
    ;tim so be      
    lea bx,e
    mov cx,d
    mov ax,[bx]
    sobe:
    cmp ax,[bx]
    jle L5
    mov ax,[bx]
L5:     mov [e],ax  ; save the smallest element
        add bx,2
        loop sobe

        lea bx,e
        mov cx,d
        mov ax,[bx]
        sobe2:
        cmp ax,[bx]
        jle L6
        cmp ax,[e] ; compare with the smallest element
        jle L6
        mov ax,[bx]
L6:      mov [e+2],ax ; save the second smallest element
            add bx,2
            loop sobe2

            HienString min
            call HIEN_SO_N
            mov ax,[e] ; retrieve the smallest element
            call HIEN_SO_N

            HienString min2
            mov ax,[e+2] ; retrieve the second smallest element
            call HIEN_SO_N

            KT:
            HienString tieptuc  ; Hien thong bao tiep tuc
            mov ah, 1 ; Cho mot ky tu nhap tu ban phim
            int 21h
            cmp al, 'c'  ; Ky tu co phai 'c'
            jnc Thoat  ; Khong phai c thi nhay den Thoat
            jmp L0   ; Con dung la c thi nhay den L0

            Thoat:
            ret
    _MINDAYSO endp
include lib22.asm
end
