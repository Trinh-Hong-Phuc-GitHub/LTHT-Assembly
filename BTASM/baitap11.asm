; Gộp 1 sang 3, 2 sang 3
INCLUDE lib1.asm       
.MODEL small           
.STACK 100h            

.DATA                  
m1 db 13,10,' GOP TEP' 
   db 13,10,'   ----'   
   db 13,10,13,10,'Nhap vao ten tep thu nhat : $' 
m2 db 13,10,'Nhap vao ten tep thu hai : $' 
m4 db 13,10,'Nhap vao ten tep dich : $' 
m3 db 13,10,'Gop tep thanh cong! $'       
Err_O db 13,10,'Khong mo duoc tep!$'      
Err_R db 13,10,'Khong doc duoc tep!$'     
Err_W db 13,10,'Khong ghi duoc tep!$'     
Err_C db 13,10,'Khong dong duoc tep!$'    
theteps dw ?            
thetepd dw ? 
thetepc dw ?            
buff db 30              
     db ?               
file_name db 30 dup(?)  
dem db 512 dup(?) 
demd db 512 dup(?)       
tieptuc db 13,10,'Co tiep tuc chuong trinh (c/k):$' 

.CODE                  
PUBLIC _GOPTEP          
_GOPTEP PROC
   START:              
        mov ax, @data   
        mov ds, ax      
     L0:
        CLRSCR           
        HienString m1   
        lea dx, buff     
        call GET_FILE_NAME 
        lea dx, file_name 
        mov al, 0         
        mov ah, 3dh       
        int 21h           
        jnc L1            
        HienString Err_O  
        jmp KT            
     L1:
        mov theteps, ax   
        HienString m2     
        lea dx, buff       
        call GET_FILE_NAME 
        lea dx, file_name  
        mov al, 0          
        mov ah, 3dh        
        int 21h            
        jnc L2             
        HienString Err_O   
        jmp DONGTEPS       
     L2:
        mov thetepd, ax 
        HienString m4     
        lea dx, buff       
        call GET_FILE_NAME 
        lea dx, file_name  
        mov al, 1          
        mov ah, 3dh        
        int 21h            
        jnc P1 
        HienString Err_O   
        jmp DONGTEPC    
      P1:  
        mov thetepc, ax 
        mov bx, ax         
        mov al, 2          
        xor cx, cx         
        mov dx, cx         
        mov ah, 42h        
        int 21h    
     L3:
        mov bx, theteps     
        mov cx, 512         
        lea dx, dem         
        mov ah, 3fh         
        int 21h             
        jnc S1              
        HienString Err_R    
        jmp DONGTEPC 
     S1:
        and ax, ax           
        jz DONGTEPC          
        mov bx, thetepc      
        mov cx, ax           
        lea dx, dem          
        mov ah, 40h          
        int 21h 
        jnc P2              
        HienString Err_R    
        jmp DONGTEPC       
     P2:
        mov bx, thetepd     
        mov cx, 512         
        lea dx, demd         
        mov ah, 3fh         
        int 21h             
        jnc L4              
        HienString Err_R    
        jmp DONGTEPC
     L4:
        and ax, ax           
        jz DONGTEPC          
        mov bx, thetepc      
        mov cx, ax           
        lea dx, demd          
        mov ah, 40h          
        int 21h             
        jnc P3
        HienString Err_W     
        jmp DONGTEPC         
      P3:
        HienString m3        
        jmp L3

      DONGTEPC:
        mov bx, thetepc      
        mov ah, 3eh          
        int 21h              
        jnc DONGTEPD         
        HienString Err_C             
     DONGTEPD:
        mov bx, thetepd      
        mov ah, 3eh          
        int 21h              
        jnc DONGTEPS         
        HienString Err_C     
     DONGTEPS:
        mov bx, theteps      
        mov ah, 3eh          
        int 21h              
        jnc KT                
        HienString Err_C     
     KT:
        HienString tieptuc   
        mov ah, 1            
        int 21h              
        cmp al, 'c'          
        jne Thoat            
        jmp START            
     Thoat:
       ret                 

_GOPTEP endp               

INCLUDE lib3.asm          
END