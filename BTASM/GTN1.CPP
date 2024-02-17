#include <iostream.h>
#include <conio.h>
int n;
extern int GIAITHUA();     /*Ham khong doi , co gia tri tro ve la int*/
void main()
{
        char tl;
     L1:
        clrscr();
        cout<<"\n Hay vao so n : ";
        cin>>n;
        cout<<"\n Giai thua cua "<<n<<" la : " << GIAITHUA();
        cout<<"\n Co tiep tuc chuong trinh ? (Y/N)";
        tl = getch();
        if(tl == 'Y')
        goto L1;
}

