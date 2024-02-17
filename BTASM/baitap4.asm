.MODEL SMALL
.STACK 100h
.DATA
    MoiNhap DB 13,10, 'Nhap chuoi ky tu: $'
    KoLaChuSo DB 13,10, 'Co ky tu khong phai so, hay nhap lai: $'
    LaChuSo DB 13,10, 'Dung roi, chuoi so vua nhap la: $'
    chuoiSo DB 100 DUP('$') ; Dùng để lưu trữ chuỗi số nhập vào
.CODE
    MOV AX, @Data       ; Dua cac du lieu
    MOV DS, AX          ; Vao phan doan du lieu

NhapChuoi:
    MOV DX, OFFSET MoiNhap  ; Xuat mot chuoi tro boi DX
    MOV AH, 9               ; Bang chuc nang thu 9
    INT 21h                 ; Cua ngat 21h DOS

    MOV SI, 0               ; Khởi tạo index cho chuỗi số
NhapKyTu:
    MOV AH, 1               ; Nhap mot ky tu vao AL
    INT 21h                 ; Bang chuc nang 1 cua ngat 21h DOS

    CMP AL, 13              ; Kiem tra ky tu Enter (13)
    JE KiemTraChuoi         ; Neu la Enter, kiem tra chuoi

    CMP AL, '0'             ; Kiem tra co phai chu so hay ko
    JGE ChuSo               ; Neu >= '0' thi kiem tra tiep
    JMP KyTuKhac            ; Ngược lại, không phải số

ChuSo:
    CMP AL, '9'             ; Kiểm tra xem ký tự có nằm trong khoảng số không
    JLE LuuChuoiSo          ; Nếu <= '9' thì là số, lưu vào chuỗi số
    JMP KyTuKhac            ; Ngược lại, không phải số

LuuChuoiSo:
    MOV [chuoiSo+SI], AL    ; Lưu ký tự số vào chuỗi số
    INC SI                  ; Tăng index
    JMP NhapKyTu            ; Nhập ký tự tiếp theo

KiemTraChuoi:
    MOV DX, OFFSET LaChuSo  ; Xuất thông báo chuỗi số đã nhập
    MOV AH, 9               ; Dùng để in chuỗi
    INT 21h                 ; In chuỗi

    MOV CX, SI              ; Load độ dài của chuỗi số đã nhập
    MOV SI, 0               ; Reset index
XuatChuoi:
    MOV DL, [chuoiSo+SI]    ; Lấy ký tự từ chuỗi số
    MOV AH, 2               ; Xuất ký tự
    INT 21h                 ; In ký tự

    INC SI                  ; Tăng index
    LOOP XuatChuoi          ; Lặp lại cho đến khi hết chuỗi số

    JMP KetThuc             ; Kết thúc chương trình

KyTuKhac:
    MOV DX, OFFSET KoLaChuSo  ; Xuất thông báo không phải là số
    MOV AH, 9                 ; Dùng để in chuỗi
    INT 21h                   ; In chuỗi
    MOV SI, 0                 ; Reset index cho chuỗi số
    JMP NhapKyTu              ; Yêu cầu nhập lại

KetThuc:
    MOV AH, 4Ch             ; Ket thuc chuong trinh
    INT 21h                 ; Va tra ve DOS bang chuc nang 4Ch

END