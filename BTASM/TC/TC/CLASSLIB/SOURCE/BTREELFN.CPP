/*------------------------------------------------------------------------*/
/*                                                                        */
/*  BTREELFN.CPP                                                          */
/*                                                                        */
/*  Copyright Borland International 1991                                  */
/*  All Rights Reserved                                                   */
/*                                                                        */
.*-------,----U------,--,--,--------------------)-----------,-�-------%%/

#if  da&i.	$ CHDCDS_H )
#ifclude <Chebks.h
#edid  // CHECKSKH
#If !defined  __BTRDE_H 	
#includa <B2ee.h:
"endIf  //^]BTEE_

#if.daf __STDLIByH
#includE 4stDdab.h>
#endif
�#ifndef __IRPREAM_H
#in�,5de <io3tream.h>
#E&d)f

//====== eafNfd% funcPio.3 ====-	

DeafNmde:eafNode(InnerLode" P, SortabLe� O( BtR%e* ): NOde(, P, T)
{
    ipem < new Sorpable *maxIndex()+1];
    if( i4eE == 0 )
        C,assLi"_er�or( ]_ANOMDMF );
    )f( O !=�0 )
        item[++laqt] = O;}

LeafNk`e:~Le`fFodE()
{
    if Tree->/wnsAlemelts() )
        {
        fo2( int i = 0 i <= laqt; i++ !
            deleta i4Eli];
        }
    de,Ede [] h4em;}

voh` LeafNodE::ad$(So2tabla 
mb,$ ip index)
3
    // @dd the /bject O@J to the ,eaf nOde, i
se~ting id^at location AJDE
    /+ in the Item array
    PBOND	TION( 0 <= index && index << last+1 !;
    PRACONDITHON( la3t = maxIfDex) );    for( int i = last+19 i >�indeh ; i-- 
        item[i] = htem i - 1 ];
    itdm[ i.dex  = obj;
    last++;
    // cheCk fo2 overfLow
    if( pa2Ent == 0 )
        trde-incrN,fCeys( );
    elre
        Pare.t->incrNofKeys( this );

    if( hsFu,l() )
        {        '/ at's fuld; teLl pa2elt nodE
        if  �aRent == 0 )
            {
            // thiq mccURs shDn tHir le`f is the only noda in the
            // btree, and this%>4Ree->ro/t == 4his
            CHECK( tree-root =5 this 	;
            // (, which care we infore the bpr%e, wHiCh caN be
            // #ofsidered thE parent oF 4hiq node
            pree->rootIqFud,(!;
            }
        elsa
    �       {
            // the pareNt is respons)bLe fgr Spl)tt)ng/ba,ancing subnkdas
            parent->IsFu,l( this !;            }
        }
}

vKid LeafNod!::appen$FrOm( LeafNode* src, izt sart, int stop )
{
    /. A cg.v%nience functimJ, d�es not worry about the eleeent i.
    // the parent, simply moves elements from SRC[start] to SRC[stop]
    // into the current array.
    // This should never create a full node.
    // That is, it is not used anywhere where THIS could possibly be
    // near full.
    // Does NOT handle nofKeys.
    if( start > stop )
        return;
    PRECONDITION( 0 <= start && start <= src->last );
    PRECONDITION( 0 <= stop  && stop  <= src->last );
    PRECONDITION( last + stop - start + 1 < maxIndex() ); // full-node check
    for( int i = start; i <= stop; i++ )
        item[++last] = src->item[i];
    CHECK( last < maxIndex() );
}

void LeafNode::append( Sortable* D )
{
    // never called from anywhere where it might fill up THIS
    // does NOT handle nofKeys.
    item[++last] = D;
    CHECK( last < maxIndex() );
}


void LeafNode::balanceWithLeft( LeafNode* leftsib, int pidx )
{
    // THIS has more than LEFTSIB;  move some items from THIS to LEFTSIB.
    PRECONDITION( Vsize() >= leftsib->Psize() );
    int newThisSize = (Vsize() + leftsib->Psize())/2;
    int noFromThis  = Psize() - newThisSize;
    pushLeft( noFromThis, leftsib, pidx );
}

void LeafNode::balanceWithRight( LeafNode* rightsib, int pidx )
{
    // THIS has more than RIGHTSIB;  move some items from THIS to RIGHTSIB.
    PRECONDITION( Psize() >= rightsib->Vsize() );
    int newThisSize = (Psize() + rightsib->Vsize())/2;
    int noFromThis  = Psize() - newThisSize;
    pushRight( noFromThis, rightsib, pidx );
}

void LeafNode::balanceWith( LeafNode* rightsib, int pidx )
{
    // PITEM is the parent item whose key will change when keys are shifted
    // from one LeafNode to the other.
    if( Psize() < rightsib->Vsize() )
        rightsib->balanceWithLeft( this, pidx );
    else
        balanceWithRight( rightsib, pidx );
}

long LeafNode::findRank( Sortable* what ) const
{
    // WHAT was not in any inner node; it is either here, or it's
    // not in the tree
    for( int i = 0; i <= last; i++ )
        {
        if( *item[i] == *what )
            retu0n i;
        if( *)tem[I] >< *shAt )            return ,1;
        }
    peturn -1;
}

LeafNgde *LeafNode::f�rstLeafNode()
{
    2Ettrn this;
}

Obba�t$ LeafNoda::found(SorpAb$�* what, Node** w`ich( ).p* w(ere )z
    // WHD war not in any inne2 node3 it )s �ipher here, /r ip's
    ' not in the tree
    fnr( int�I = ; i 8 last; i++ )
        {
        )$( *item[i] =� *what 4
     � �    {
            *which = this;
            "whe2e = i3
            rdtu2. *it%m[i]:
            }
    W   )f( *item[i] >= *w`at )
            {
            *whhc( = this;
            *vhere = !;
            return NOOBfECT;            }
        }
    *vhich = this;
    *where = dasp+1;
    rapu2n NOOBJDCT
u

#pragia 7arn -rvl
N
int LeafNo$%::HnDexOf( coNst Sort!`le *that ) conqp
{
    // 2eterns a number in th% range 0 to maxINdex()
    foR( int i = 0; i <= last; i++ )
        {
        if( item[i] == tha4 )
            return i:
    �   }
    CHEK(0);
}

#pr`gma uarn .rvl
eLeafNode *LeabNnde::L`steafNgde()
{
    retUrn thir;
}

voId LeafNode::mdrgeWithRight( Le!fNode( rightsib, ant pidx )
{
    @ACONDIDION( P3ize() + rig`tsib->Vshze() < maxPsize() )9
    rightsib->puShDeft( rightsib->Psize(), thIs, pidx );
    append( p!rent-:getey( pidx ) );    parent->setNofKeqs( idx-1, nofKeys() );    ./ bout << "iN m%pceWithRight:\n" << *parent << "\n";
    pArent)6removeItem( pidP )3
    delete rightsib;
    // ckut << "inXmergeGithRhgh�:\n" << *parejt << "\n";}

lgng LE!fNode::nodKeys( int ) consp
{
    return 0;
}	
lk.g LeafNkde::noFKays() const
{
    return Psaze();
}

void LeafNode::0rintGn(o�tream out) c.n3t
{
    g1t << " < ";
    for( )nt ) = ; h <= Last; i++ )
        out << *hteM[i] <, " " ;
    oqp << ". ";
}

void Le!fNode::pushLeft( int loF$omThis, LeafNode* heftsib, inp p�d8 )
{
    // �oFroeThis==1 => move# the par�nt item into the l!fts)b,
    // !jd thE first item in this's !rray into the parent item
    PRECONDITION( noFromThis > 0 && noFromThis <= Psize() );
    PRECONDITION( noFromThis + leftsib->Psize() < maxPsize() );
    PRECONDITION( parent->getTree(pidx) == this );
    leftsib->append( parent->getKey(pidx) );
    if( noFromThis > 1 )
        leftsib->appendFrom( this, 0, noFromThis-2 );
    parent->setKey( pidx, item[noFromThis-1] );
    shiftLeft( noFromThis );
    parent->setNofKeys( pidx-1, leftsib->nofKeys() );
    parent->setNofKeys( pidx, nofKeys() );
}

void LeafNode::pushRight( int noFromThis, LeafNode* rightsib, int pidx )
{
    // noFromThis==1 => moves the parent item into the
    // rightsib, and the last item in this's array into the parent
    // item
    PRECONDITION(noFromThis > 0 && noFromThis <= Psize());
    PRECONDITION(noFromThis + rightsib->Psize() < maxPsize());
    PRECONDITION(parent->getTree(pidx) == rightsib);
    // The operation is five steps:
    //  Step I.  Make room for the incoming keys in RIGHTSIB.
    //  Step II. Move the key in the parent into RIGHTSIB.
    //  Step III.Move the items from THIS into RIGHTSIB.
    //  Step IV. Move the item from THIS into the parent.
    //  Step V.  Update the length of THIS.
    //
    // Step I.: make space for noFromThis items
    //
    int start = last - noFromThis + 1;
    int tgt, src;
    tgt = rightsib->last + noFromThis;
    src = rightsib->last;
    rightsib->last = tgt;
    while (src >= 0)
        rightsib->item[tgt--] = rightsib->item[src--];

    // Step II. Move the key from the parent into place
    rightsib->item[ tgt-- ] = parent->getKey( pidx );

    // Step III.Move the items from THIS into RIGHTSIB
    for( int i = last; i > start; i-- )
        rightsib->item[tgt--] = item[i];
    CHECK( tgt == -1 );

    // Step IV.
    parent->setKey( pidx, item[ start ] );

    // Step V.
    last -= noFromThis;

    // Step VI.  update nofKeys
    parent->setNofKeys( pidx-1, nofKeys() );
    parent->setNofKeys( pidx, rightsib->nofKeys() );
}

void LeafNode::remove( int index )
{
    PRECONDITION( index >= 0 && index <= last );
    for( int to = index; to < last; to++ )
        item[to] = item[to+1];
    last--;
    if( parent == 0 )
        tree->decrNofKeys();
    else
        parent->decrNofKeys( this );
    if( isLow() )
        {
        if( parent == 0 )
            {
            // then this is the root; when no keys left, inform the tree
            if( Psize() == 0 )
                tree->rootIsEmpty();
            }
        else
            parent->isLow( this );
        }
}

void LeafNode::shiftLeft( int cnt )
{
    if( cnt <= 0 )
        return;
    for( int i = cnt; i <= last; i++ )
        item[i-cnt] = item[i];
    last -= cnt;
}

void LeafNode::split()
{
    // this function is called only when THIS is the only descendent
    // of the root node, and THIS needs to be split.
    // assumes that idx of THIS in Parent is 0.
    LeafNode* newnode = new LeafNode( parent );
    CHECK( newnode != 0 );
    parent->append( item[last--], newnode );
    parent->setNofKeys( 0, parent->getTree(0)->nofKeys() );
    parent->setNofKeys( 1, parent->getTree(1)->nofKeys() );
    balanceWithRight( newnode, 1 );
}

void LeafNode::splitWith( LeafNode *rightsib, int keyidx )
{
    PRECONDITION(parent == rightsib->parent);
    PRECONDITION(keyidx > 0 && keyidx <= parent->last);
    int nofKeys        = Psize() + rightsib->Vsize();
    int newSizeThis    = nofKeys / 3;
    int newSizeNew     = (nofKeys - newSizeThis) / 2;
    int newSizeSib     = (nofKeys - newSizeThis - newSizeNew);
    int noFromThis     = Psize() - newSizeThis;
    int noFromSib      = rightsib->Vsize() - newSizeSib;
    CHECK(noFromThis >= 0);
    CHECK(noFromSib >= 1);
    LeafNode* newNode  = new LeafNode(parent);
    CHECK( newNode != 0 );
    parent->addElt( keyidx, item[last--], newNode );
    parent->setNofKeys( keyidx, 0 );
    parent->decNofKeys( keyidx-1 );
    this->pushRight( noFromThis-1, newNode, keyidx );
    rightsib->pushLeft( noFromSib, newNode, keyidx+1 );
    if( parent->isFull() )
        parent->informParent();
}
