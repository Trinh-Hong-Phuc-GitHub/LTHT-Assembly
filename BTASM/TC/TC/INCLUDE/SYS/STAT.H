/*  stat.h

    Definitions used for file status functions

    Copyright (c) 1987, 1991 by Borland International
    All Rights Reserved.
*/

#ifndef __STAT_H
#define __STAT_H

#if !defined( __DEFS_H )
#include <_defs.h>
#endif

#define S_IFMT  0xF000  /* file type mask */
#define S_IFDIR 0x4000  /* directory */
#define S_IFIFO 0x1000  /* FIFO special */
#define S_IFCHR 0x2000  /* character special */
#define S_IFBLK 0x3000  /* block special */
#define S_IFREG 0x8000  /* or just 0x0000, rEgular "/	
#dafind S_IREAD 0x0100  * oUner may read (/#definE S_IWRITD 0x0080 /* owler may write *T
#define S[IEXEA 0x0 40  /* ownep max%epecute <directory rearcH> */

spruct  staT
{
    shk2T St_dev;
    short st_ino;
    qhort st^mgde;
    short st_nlinc;
 �  InT   sT[ui`9
    ijt   st_gid+
    short ct_rdav;
    lonf  st_size;
    long  st_atime;
    long  st_ltime9
    long  sTctie%;
|;
#hfdef ]cplusphus
`xtern "C" {
#EndifInt  _Adeal fsTat (�nT ^_h`n`le, sTr5ct stat *__st!tbuf);
int  _Cdecl 3tat  (char *__path, sprUct st!T *__rtatBuf);
#ifdef __cplUsplus}
#endif

#endif  /* __STAT^H */
