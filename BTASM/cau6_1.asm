INCLUDE lib1.asm       ; Include file lib1.asm
.MODEL small           ; Chọn mô hình chương trình small
.STACK 100h            ; Đặt kích thước ngăn xếp (stack) là 100h
.DATA                  ; Phần khai báo dữ liệu
; Định nghĩa chuỗivà các biến lưu trữ tên file và dữ liệu.
;Các chuỗi được sử dụng để hiển thị thông điệp trên màn hình.
m1 db 13,10,'          CHUC NANG GOP TEP' ; Định nghĩa chuỗi m1 (dòng 1)
   db 13,10,'          -----------------'   ; Định nghĩa chuỗi m1 (dòng 2)
   db 13,10,13,10,'Hay vao ten tep thu nhat: $' ; Định nghĩa chuỗi m1 (dòng 3)
m2 db 13,10,'Hay vao ten tep thu hai: $' ; Định nghĩa chuỗi m2
m3 db 13,10,'Gop tep thanh cong! $'       ; Định nghĩa chuỗi m3
Err_O db 13,10,'Khong mo duoc tep!$'       ; Định nghĩa chuỗi Err_O
Err_R db 13,10,'Khong doc duoc tep!$'      ; Định nghĩa chuỗi Err_R
Err_W db 13,10,'Khong ghi duoc tep!$'      ; Định nghĩa chuỗi Err_W
Err_C db 13,10,'Khong dong duoc tep!$'     ; Định nghĩa chuỗi Err_C
; Các biến theteps, thetepd lưu trữ handles của tệp nguồn và tệp đích.
; một handle thường được sử dụng để đại diện cho một tài nguyên như tệp (file)
theteps dw ?            ; Khai báo biến theteps (word)
thetepd dw ?            ; Khai báo biến thetep (word)
; buff và dem là vùng đệm để lưu dữ liệu đọc và ghi.
buff db 30              ; Khai báo vùng đệm "buff" có kích thước 30 bytes
     db ?               ; Một byte thừa cho kí tự null-terminated
file_name db 30 dup(?)  ; Khai báo mảng "file_name" có 30 bytes lưu tên file
dem db 512 dup(?)       ; Khai báo vùng đệm "dem" có kích thước 512 bytes
tieptuc db 13,10,'Co tiep tuc chuong trinh (c/k):$' ; Định nghĩa chuỗi "tieptuc"
.CODE                  ; Phần mã lệnh
PUBLIC _GOPTEP          ; Khai báo hàm _GOPTEP là public
_GOPTEP PROC
   START:              ; Nhãn START: bắt đầu của chương trình
        mov ax, @data   ; Đưa địa chỉ của phân vùng dữ liệu vào thanh ghi AX
        mov ds, ax      ; Sao chép giá trị của AX vào DS để trỏ đến phân vùng dữ liệu
      ; Đoạn mã  thực hiệnđể mở một tệp và xử lý lỗi nếu việc mở tệp gặp sự cố.
     L0:
        clrscr           ; Gọi hàm CLRSCR để xóa màn hình
        HienString m1   ; Hiển thị chuỗi m1 ra màn hình
        lea dx, buff     ; Đưa địa chỉ của vùng đệm buff vào thanh ghi DX
        call GET_FILE_NAME ; Gọi hàm GET_FILE_NAME để nhập tên tệp cần mở và lưu vào buff.
        lea dx, file_name ; Đưa địa chỉ của biến file_name vào thanh ghi DX để sử dụng khi mở tệp.
        mov al, 0         ; Đặt chức năng "mở tệp" (0) trong thanh ghi AL. Trong DOS, mã 0 thường là mã để mở tệp.
        mov ah, 3dh       ; Đặt hàm dịch vụ "mở tệp" (3dh) trong thanh ghi AH. Trong DOS, dịch vụ này được sử dụng để mở tệp.
        int 21h           ; Gọi hàm ngắt 21h để mở tệp
        jnc L1            ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L1
        HienString Err_O  ; Hiển thị thông báo lỗi Err_O nếu việc mở tệp gặp lỗi (CF = 1)
        jmp KT            ; Nhảy đến nhãn KT (kết thúc chương trình)
        ; Đoạn mã này tiếp tục xử lý việc mở tệp, lần này là tệp đích mà chương trình sẽ ghi dữ liệu vào.
     L1:
        mov theteps, ax   ; Lưu handle của tệp đã mở từ lệnh trước vào biến theteps (một cách để theo dõi handle của tệp được mở).
        HienString m2     ; Hiển thị chuỗi m2 để yêu cầu tên tệp đích
        lea dx, buff       ; Đưa địa chỉ của vùng đệm buff vào thanh ghi DX, chuẩn bị để nhập tên tệp đích.
        call GET_FILE_NAME ;  Gọi hàm GET_FILE_NAME để người dùng nhập tên tệp đích và lưu vào buff.
        lea dx, file_name  ; Đưa địa chỉ của biến file_name vào thanh ghi DX để sử dụng khi mở tệp đích.
        mov al, 1          ; Đặt chức năng "mở tệp" (1) trong thanh ghi AL. Trong DOS, mã 1 thường là mã để tạo tệp mới hoặc mở tệp đã có.
        mov ah, 3dh        ; Đặt hàm dịch vụ "mở tệp" (3dh) trong thanh ghi AH. Trong DOS, dịch vụ này được sử dụng để mở tệp.
        int 21h            ; Gọi hàm ngắt 21h để mở tệp đích
        jnc L2             ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L2
        HienString Err_O   ; Hiển thị thông báo lỗi Err_O nếu việc mở tệp đích gặp lỗi (CF = 1)
        jmp DONGTEPS       ; Nhảy đến nhãn DONGTEPS để đóng tệp nguồn và kết thúc chương trình
      ;  thực hiện việc chuẩn bị và tạo tệp đích để ghi dữ liệu từ tệp nguồn vào.
     L2:
        mov thetepd, ax   ; Lưu handle của tệp đã mở (biến được sử dụng để đại diện cho tệp) vào biến thetepd. Đây là việc lưu trữ handle của tệp đích.
        mov bx, ax         ; : Sao chép handle của tệp đích từ AX vào BX. Đây là việc sao chép handle để sử dụng sau này.
        mov al, 2          ; Đặt chức năng "đọc và ghi" (2) trong AL
        xor cx, cx         ; Xóa thanh ghi CX. Việc này thường được thực hiện để đặt CX về giá trị khởi tạo ban đầu là 0.
        mov dx, cx         ; Sao chép giá trị của CX vào DX. Đây có thể làm phần nào để xác định dung lượng tệp cần tạo. lúc này dx = 0
        mov ah, 42h        ; Đặt hàm dịch vụ "tạo tệp và mở" (42h) vào thanh ghi AH. Di chuyển con trỏ của tệp đến vị trí bắt đầu ghi trong tệp đích.
        int 21h            ; Gọi hàm ngắt 21h để tạo tệp đích
      ; đoạn code này thực hiện việc đọc dữ liệu từ tệp nguồn vào bộ đệm để chuẩn bị cho việc ghi vào tệp đích.
     L3:
        mov bx, theteps     ; Đưa handle của tệp nguồn vào BX
        mov cx, 512         ; Đặt CX bằng 512 (số byte cần đọc)
        lea dx, dem         ; Đưa địa chỉ của vùng đệm dem (được khai báo trước đó) vào thanh ghi DX. Dữ liệu sẽ được đọc và lưu trữ tại vùng đệm này.
        mov ah, 3fh         ; Đặt hàm dịch vụ "đọc từ tệp" (3fh) trong AH
        int 21h             ; Gọi hàm ngắt 21h để đọc dữ liệu từ tệp nguồn
        jnc L4              ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L4
        HienString Err_R    ; Hiển thị thông báo lỗi Err_R nếu việc đọc tệp gặp lỗi (CF = 1)
        jmp DONGTEPD        ; Nhảy đến nhãn DONGTEPD để đóng tệp đích và kết thúc chương trình
      ; thực hiện việc ghi dữ liệu từ bộ đệm vào tệp đích và kiểm tra việc ghi xảy ra có thành công hay không.
     L4:
        and ax, ax           ; Kiểm tra xem số lượng byte đã đọc có bằng 0 không
        jz DONGTEPD          ; Nếu bằng 0, nhảy đến nhãn DONGTEPD để đóng tệp và kết thúc chương trình
        mov bx, thetepd      ; Đưa handle của tệp đích vào BX
        mov cx, ax           ; Đưa số lượng byte đã đọc từ tệp nguồn vào thanh ghi CX. Đây là số byte sẽ được ghi vào tệp đích.
        lea dx, dem          ; Đưa địa chỉ của "dem" vào DX để ghi dữ liệu
        mov ah, 40h          ; Đặt hàm dịch vụ "ghi vào tệp" (40h) trong AH
        int 21h              ; Gọi hàm ngắt 21h để ghi dữ liệu vào tệp đích
        jnc L5               ; Nếu không có lỗi (CF = 0), nhảy đến nhãn L5
        HienString Err_W     ; Hiển thị thông báo lỗi Err_W nếu việc ghi tệp gặp lỗi (CF = 1)
        jmp DONGTEPD         ; Nhảy đến nhãn DONGTEPD để đóng tệp đích và kết thúc chương trình
     L5:
        HienString m3        ; Hiển thị thông báo "gộp tệp thành công"
        jmp L3               ; Nhảy đến nhãn L3 để tiếp tục quá trình đọc và ghi tệp
    DONGTEPD:
        mov bx, thetepd      ; Đưa handle của tệp đích vào BX
        mov ah, 3eh          ; Đặt hàm dịch vụ "đóng tệp" (3eh) trong AH
        int 21h              ; Gọi hàm ngắt 21h để đóng tệp đích
        jnc DONGTEPS         ; Nếu không có lỗi (CF = 0), nhảy đến nhãn DONGTEPS
        HienString Err_C     ; Hiển thị thông báo lỗi Err_C nếu việc đóng tệp gặp lỗi (CF = 1)
    DONGTEPS:
        mov bx, theteps      ; Đưa handle của tệp nguồn vào BX
        mov ah, 3eh          ; Đặt hàm dịch vụ "đóng tệp" (3eh) trong AH
        int 21h              ; Gọi hàm ngắt 21h để đóng tệp nguồn
        jnc KT                ; Nếu không có lỗi (CF = 0), nhảy đến nhãn KT
        HienString Err_C     ; Hiển thị thông báo lỗi Err_C nếu việc đóng tệp nguồn gặp lỗi (CF = 1)
    KT:
        HienString tieptuc   ; Hiển thị thông báo "Có tiếp tục chương trình (c/k):"
        mov ah, 1            ; Chờ người dùng nhập một ký tự từ bàn phím
        int 21h              ; Gọi hàm ngắt 21h để đọc ký tự từ bàn phím vào AL
        cmp al, 'c'          ; So sánh ký tự với 'c'
        jne Thoat            ; Nếu không phải 'c', nhảy đến nhãn Thoat (kết thúc chương trình)
        jmp START            ; Nếu là 'c', quay lại nhãn START để tiếp tục chương trình
    Thoat:
       ret                  ; Trả về khỏi hàm _GOPTEP
_GOPTEP endp                ; Kết thúc định nghĩa hàm _GOPTEP

INCLUDE lib3.asm            ; Include file lib3.asm
END