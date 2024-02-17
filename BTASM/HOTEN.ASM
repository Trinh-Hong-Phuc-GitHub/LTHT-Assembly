
.model small
.stack 100h
.data
    m1 db 10,13,'Hay nhap ten ban la : $'
    tb1 DB 10,13, 'Xin chao, $ ';10 xuong dong , 13 lui dau dong* 
    str DB 100 dup('$') ;
    tb3 db 10,13,'toi thieu 2 tu $'
.code
PUBLIC @CN4$qv
@CN4$qv PROC
        mov ax, @data
        mov ds,ax ;khoi tao thanh ghi ds 
          
        mov  ah,9 ;in mot xau ky tu   
        lea dx,m1 ;
        int 21h 
        ;nhap chuoi ky tu
    L10    mov ah,10 ;    10=0ah
        lea dx,str ; tro den dia chi dau str
        int 21h 
        
        mov al, str + 1
        cmp al,2
        jb L10
        jmp L2
    L1: 

        mov  ah,9 ;in mot xau ky tu   
        lea dx,tb3 ;
        int 21h 

        mov ah,4CH
        int 21h    
    L2: 
        mov  ah,9 ;in mot xau ky tu   
        lea dx,tb1 ;
        int 21h   ;in ra
            
        
        lea dx,str +2     
        int 21h 

       ; mov  ah,9 ;in mot xau ky tu   
       ; lea dx,tb2 ;
       ; int 21h   ;in ra
        
        mov ah,4CH
        int 21h    

@CN4$qv ENDP
END