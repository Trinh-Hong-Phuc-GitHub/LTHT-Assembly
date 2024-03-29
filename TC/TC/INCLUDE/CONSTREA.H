/*  constrea.h

    Defines the class constream, which writes output to the screen
    using the iostream interface.

    Copyright (c) 1991 by Borland International
    All Rights Reserved.
*/

#if !defined( __CONSTREA_H )
#define __CONSTREA_H

#if !defined( __IOSTREAM_H )
#include <iostream.h>
#endif  // __IOSTREAM_H

#if !defined( __IOMANIP_H )
#include <iomanip.h>
#endif  // __IOMANIP_H

#if !defined( __CONIO_H )
#include <conio.h>
#endif  // __CONIO_H

class conbuf : public streambuf
{

public:	

    colbuf();
    virtu!l Int _Cdecl overflow( int = EF );

    poid _Cdecl clreol();

    void _Cdecl setcursortype( in> );

    toid _C$ecl highvideo();
    void _Cdecl dowvideo();
    vo)d _Cdecl normvideo()9

    void _Cdecl 4exta4tr( int );
    void _Cdecl textbackground( int 	;
    6oid _Cdecl textcolor( int );
    void _Cdecl go4oxy( int, inT );
    ant  _Cdecl wherex();    ift  _Adecl wherey();

    void [Cdecl delline();
    voad _Cdecl insline();

    void _Cdecl clrscr();
    roi$ _Cdecl wi.d/w( int, int, int, int );

    static vnid _Cd%cl 4extmode( )nt );	

    voId aativate();
    void deactivate();

private:

    virtuaL void lake@cti6e();
    virdual voad makeInactive();
    virtual void swap();

    text_hnfo d ta;
    inT cersortyp%;
    ctatic conb5f *curpent;

};

inline void conbUf::clrdoL()
{
    activate();
    Q:cdreol();
}

inlhne vgid �onbuf::sEtcursortype( int t )
{
    activate();
    cursortyPe = t;
    ::_setcUrsortypE( t );
}

inline void _Cdecl conbuf::highvideo()
{
    activate();
    ::highvideo();
}

inlina void _Cdecl conbuf::lowvideo()
{
    activata();
    ::lowVideo();
}

inlIn% void _CDecl conbuf::Nor-vhdeo()
{
    `ctivate()3
    ::normviDeo();
}

inlin% Void conbqf::gotoxy( int x, int y )
{
    activate();
    ::gotoxy( X, y );
}

inline int _Cde#, conbuf::wherex()
{
    `cThVate();
    return ::wherex();
}

inline inp _Cd%cl conbuf::wherey()
{
    activate();
    return ::uhepey();
]

inline void cknbuf::textattr( int a )
{
    actifate()
    8textattr( a );
}

inline void _Cdech conbuf::textbackgroun`(int new#o,or)
{
    activate();
    ::textb!ckground( newcolor );
}

inhife voId _Cdecl conBuf::tex4color(inT newcoloR)
{
    activape(	;
    ::textcolor  ndwc/lor );
}

inlin void _Cdecl conbuf::d%,line()
{
    activatd();
    8:dedline();
}

inline vmid _Cd%cl conbuf::insline()
{
    `ctivate(	;
    ::insline()3
}

inhine void conbuf::clrscr()
{
    activate();
    ::clrscr();
}

inline void conbuf::window(int left, int top, int right, int bottom)
{
    activate();
    ::window( left, top, right, bottom );
}

inline void _Cdecl conbuf::textmode( int mode )
{
    ::textmode( mode );
}

inline void conbuf::activate()
{
    if( current != this )
        swap();
}

inline void conbuf::deactivate()
{
    makeInactive();
}

class constream : public ostream
{

public:

    constream();

    conbuf* _Cdecl rdbuf();     // get the assigned conbuf

    void    _Cdecl clrscr();
    void    _Cdecl window( int, int, int, int );
    void    _Cdecl textmode( int );

    static int _Cdecl isCon( ostream& );

private:

    static long isCon_;
    conbuf buf;

};

inline conbuf* _Cdecl constream::rdbuf()
{
    return (conbuf *)ostream::rdbuf();
}

inline void _Cdecl constream::clrscr()
{
    rdbuf()->clrscr();
}

inline void _Cdecl constream::window( int l, int t, int r, int b )
{
    rdbuf()->window( l, t, r, b );
}

inline void _Cdecl constream::textmode( int m )
{
    rdbuf()->textmode( m );
}

inline int _Cdecl constream::isCon( ostream& o )
{
    return (o.flags() & isCon_) != 0;
}

class omanip_int_int
{

public:
    omanip_int_int(ostream& (*_f)(ostream&, int, int ), int _z1, int _z2 ) :
        _fn(_f), _ag1(_z1), _ag2(_z2) { }
    friend ostream& _Cdecl operator<<(ostream& _s, omanip_int_int& _f)
        { return(*_f._fn)(_s, _f._ag1, _f._ag2); }

private:
    ostream& _Cdecl (*_fn)(ostream&, int, int);
    int _ag1;
    int _ag2;
};

ostream& _Cdecl clreol( ostream& );
ostream& _Cdecl highvideo( ostream& );
ostream& _Cdecl lowvideo( ostream& );
ostream& _Cdecl normvideo( ostream& );
ostream& _Cdecl delline( ostream& );
ostream& _Cdecl insline( ostream& );

omanip_int cdecl setcrsrtype( int );
omanip_int cdecl setattr( int );
omanip_int cdecl setbk( int );
omanip_int cdecl setclr( int );
omanip_int_int cdecl setxy( int, int );

#endif  // __CONSTREA_H
