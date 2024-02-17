#include <iostream.h>
#include <conio.h>
int n, a[100];
extern int SUM();
void main()
{
        char tl;
     L0:
        clrscr();
        cout<<"\n Nhap n phan tu : ";
        cin>>n;
        for(int i = 0;i < n ; i++)
        {
                cout<<"\n a ["<<i<<"] = ";
                cin>>a[i];
        }
        cout<<"\n Tong day la : "<< SUM();
        cout<<"\n Tiep tuc chuong trinh (Y/N)?";
        tl = getch();
        if(tl == 'Y')
        goto L0;


}
