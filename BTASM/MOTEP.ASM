INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	m db 13,10, 'Hay vao ten tep: $'
	FileExs db 13,10, 'Tep ton tai:$'
	FileNotExs db 13,10, 'Tep khong ton tai$'
	buff db 40
		 db ?
	file_name db 40 dup(?)
.CODE
PS:
	mov ax, @data
	mov ds, ax 
	HienString m
	lea dx, buff
	call GET_FILE_NAME
	lea dx,file_name
	mov ah,43h
	mov al,0h
	jnc L1
	HienString FileNotExs
	jmp Ex2Dos
L1:
	HienString FileExs
Ex2Dos:
	mov ah, 4ch
	int 21h
INCLUDE lib3.asm
END PS