#include <stdio.h>
#include <conio.h>
extern KIEMTRA_CONG_MAYIN_NOITIEP();
extern GOPTEP();
extern CSNTONG();
void main()
{
      char tl;
      int cn; /*chuc nang*/
      clrscr();
      printf("\n          Truong Dai hoc Mo Ha Noi");
      printf("\n          KHOA CONG NGHE THONG TIN");
      printf("\n          -----------o0o----------");
      printf("\n\n\n           BAI TAP LON MON LTHT");
      printf("\n\n\n     Cac SV thuc hien:");
      printf("\n      1. Le Tuan Vu      Lop: 2010A05");
      printf("\n      2. Dinh Van Hao        Lop: 2010A05");
      printf("\n      3. Trinh Hong Phuc      Lop: 2010A05");
      printf("\n\n\n     Co tiep tuc CT (c/k)?");
      tl=getch();
      if(tl=='c')
               {
                 L1:
                 clrscr();
                 printf("\n            CAC CHUC NANG CUA BTL");
                 printf("\n            ---------***----------");
                 printf("\n\n     1. Gop tep");
                 printf("\n     2. Tinh tong cap so nhan");
                 printf("\n     3. Ton tai cong may in noi tiep khong ?");
                 printf("\n\n     Hay chon: ");
                 scanf("%d",&cn);
                 switch(cn)
                 {
                  case 1: GOPTEP(); break;
                 case 2: CSNTONG(); break;
                 case 3: KIEMTRA_CONG_MAYIN_NOITIEP(); break;
                 default: printf("\n     Vao sai roi, cao to oi!");
                 }
     printf("\n     Co thuc hien CN khac(c/k): ");
     tl=getch();
     if(tl=='c'){
      goto L1;
      }
      }
      }
