.model small
.stack 100h
.data
    msg1 db "Nhap co so a: $"
    msg2 db 10, 13, "Nhap so mu n: $"
    msg3 db 10, 13, "a^n = $"
    x    dw ?
    y    dw ?
    z    dw ?
    t    dw ?
.code
main proc
             mov  ax,@data
             mov  ds,ax

             mov  ah, 09
             lea  dx, msg1
             int  21h

             call nhapSo
             mov  ax, x
             mov  z, ax

        
             mov  ah, 09
             lea  dx, msg2
             int  21h

             call nhapSo
             mov  ax, x
             mov  t, ax
                
             mov  ah, 9
             lea  dx, msg3
             int  21h

             mov  ax, z
             mov  bx, z
             mov  cx, t


    repeat:  
             dec  cx
             cmp  cx, 0
             je   complete
             mul  bx
             jmp  repeat
    complete:
             mov  x, ax
             call print
main endp

nhapSo proc
             mov  x, 0
             mov  y, 0
             mov  bx, 10

    nhap:    
             mov  ah, 01
             int  21h
             cmp  al, 13
             je   exit
             sub  al, 30h
             xor  ah, ah
             mov  y, ax
             mov  ax, x
             mul  bx
             add  ax, y
             mov  x, ax
             jmp  nhap
    exit:    
             ret
nhapSo endp

print proc

             mov  ax,x
             mov  bx,10
             mov  cx,0

            
    chia:    
             mov  dx,0
             div  bx
             push dx
             inc  cx
             cmp  ax,0
             je   hienthi
             jmp  chia
    hienthi: 
             pop  dx
             add  dl, 30h
             mov  ah,2
             int  21h
             dec  cx
             cmp  cx, 0
             jne  hienthi
             ret

print endp

end main