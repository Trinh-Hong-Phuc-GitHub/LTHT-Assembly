include lib1.asm
.model small
.stack 100h
.data
        m1 db 10,13,'nhap so chia laf : $'
        m2 db 10,13,'nhap so bij chia la : $'
        m3 db 10,13,'so nguyen : $'
        m4 db 10,13,'so du : $'
.code
    main proc

        mov ax,@data
        mov ds,ax

        HienString m1
        call VAO_SO_N
        
        mov bx,ax

        HienString m2
        call VAO_SO_N

        div bl
        ;mov dl,al
        mov dh,ah
        HienString m3

        add al,30h

        mov dl,al
        mov ah,2
        int 21h

        HienString m4
        
       ; call HIEN_SO_N

        add dh,30h

        mov dl,dh
        mov ah,2
        int 21h

        mov ah,4ch
        int 21h

include lib2.asm
    main endp
End
