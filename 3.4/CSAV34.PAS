Program NegyB;
{ CSAV3??.PAS }
{ Futtat†s TP-bìl: 1) File/Change dir/F:\TP70\UNITS.
                   2) Run/Run.
                   3) File/Change dir/C:\CSAV3??.
                   4) Run/Run. }
Uses CRT, Graph;

type koortipus=record
               x,y:word;
               end;
     szin=(fekete,feher,semmi);
     irany=-1..1;
     sortipus=array[1..4] of koortipus;
     tablatipus=array[-1..10,0..11] of szin;
     ponttipus=array[0..9,1..2] of integer;
     ciklus=integer;
const
      iranyc:array[1..4,'x'..'y'] of irany = ((0,-1),(1,-1),(1,0),(1,1));
      pc:ponttipus = ((0,0),(1,1),(4,2),(6,3),(6,4),(6,5),(6,6),(4,7),(1,8),(0,9));

Const szamsor : array[1..2] of string[10] = ('1234567890','0123456789');
      verzio='V3.4';
      utomen='94/06/21';
      mh=10; mv=10;
      pice=8;
      piclen=153600 div pice+6;
      C:array[1..4] of char =('X','O','.',' ');

var opt: array[1..8] of record
                          {t: array[1..5] of string[80];}
                          f: string;
                          z: shortint;
                          m: shortint;
                          end;
Var a: array[1..mh,0..mv] of shortint;
    b: array[1..mh,0..mv] of shortint;
    d: array[1..mh,0..mv] of shortint;

    tabla: tablatipus;
    m:array[0..9] of byte;

    tbl: array[0..39,1..2] of boolean;

    sc1: array[1..piclen] of byte;
    sc2: array[1..piclen] of byte;
    icn: array[1..40,0..486] of char;
    ho: array[1..181] of byte;
    tim: array[1..2,1..2] of word;
    szg,jat: array[1..10] of string[10];
    qqqq: integer;
    SZAG, JATE,szpidi, szamok, utolsolepes, lr, i,j,l,n: byte;
    k: char;
    pp,pq: pointer;
    mu,mi: pointer;
    haltestelle,p,xk: boolean;
    timgep,pnt: longint;
    kkp, acp,vsp,ny,strat, oot: shortint;
    pjat,pszg: word;
    jnev,gnev: string;

var csi,csj,csk,csl:ciklus;
    koordinata:koortipus;
    mood,mon:integer;
    kezd:byte;


Var txtind: file of longint;
    txt: file of char;

Procedure EGAVGADriver; external;
{$L EGAVGA.OBJ}
Procedure TripFont; external;
{$L TRIP.OBJ}

Procedure MakeTextIndexFile(filename: string);
{ Input must be without extension }
Var c: char;
    i, z, w: longint;
Begin
     Assign(txtind,filename+'.txt');
     Assign(txt,filename+'.dtx');
     ReWrite(txtind);
     Reset(txt);
     I:=0; Z:=0;
     Write(txtind,z);
     While not eof(txt) do begin
           Read(txt,c);
           If c=#13 then Begin
              W:=i+2;
              Write(txtind,w);
              End;
           Inc(i);
           End;
     Close(txtind);
     Close(txt);
     End;

Function Message(n: word): string;
Var i: longint;
    c: char;
    s: string;

Begin
     Assign(txtind,'alaphang.dtx');
     Reset(txtind);
     Seek(txtind,n);
     Read(txtind,i);
     Close(txtind);
     Assign(txt,'alaphang.dat');
     Reset(txt);
      Seek(txt,i);
     s:='';
     Repeat
           Read(txt,c);
           c:=chr(255-ord(c));
           s:=s+c;
           Until c=#10;
     Close(txt);
     Message:=s;
     End;

Procedure CBSInit;
Begin
     FillChar(tabla,SizeOf(tabla),semmi);
     FillChar(m,SizeOf(m),10);
     End;

Function CsabciRNDStrat: shortint;

 function szamol(d:koortipus;b,c:irany):byte;
  var a:koortipus;
  begin
       a:=d;
       with a do begin
                      while tabla[x+b,y+c]=tabla[x,y] do begin
                                                              x:=x+b;
                                                              y:=y+c;
                                                         end;
                      b:=-b;c:=-c;csj:=1;
                      while (tabla[x+b,y+c]=tabla[x,y]) do begin
                                                                x:=x+b;
                                                                y:=y+c;
                                                                csj:=csj+1;
                                                           end;
                      szamol:=csj;
                 end;
  end;

function vizsgal(a:koortipus):boolean;
 begin
      vizsgal:=false;
       for csi:=1 to 4 do if szamol(a,iranyc[csi,'x'],iranyc[csi,'y'])>=4 then begin
                                                                              vizsgal:=true;
                                                                              csi:=4;
                                                                         end;
 end;


 procedure rendez(var a:ponttipus);
  var c:byte;
  begin
       for csi:=0 to 8 do
        for csj:=8 downto csi do
           if a[csj,1]<a[csj+1,1] then begin
                                        c:=a[csj,1];a[csj,1]:=a[csj+1,1];a[csj+1,1]:=c;
                                        c:=a[csj,2];a[csj,2]:=a[csj+1,2];a[csj+1,2]:=c;
                                   end;
  end;

 function nyeroe(a:byte):boolean;
  var kp:koortipus;
  begin
       nyeroe:=false;
       with kp do begin
        x:=a;
        for y:=2 to m[a] do begin
                                 tabla[x,y]:=fekete;
                                 if vizsgal(kp) then
                                   begin
                                        tabla[x,y]:=semmi;
                                        y:=y-1;
                                        tabla[x,y]:=fekete;
                                        if vizsgal(kp) then begin
                                                                 nyeroe:=true;
                                                                 tabla[x,y]:=semmi;
                                                                 exit;
                                                            end;
                                        tabla[x,y]:=semmi;
                                        y:=y+1;
                                   end;
                                 tabla[x,y]:=semmi;
                            end;
        end;
  end;

function rnd(a:byte):byte;
 var kp:koortipus;
     tabla1:tablatipus;
     xx,sz:byte;
     p:ponttipus;
 label 1;
 begin
      p:=pc;
      for csk:=0 to 9 do begin
        tabla1:=tabla;
        with kp do begin
                        if m[csk]=0 then begin
                                            p[csk,1]:=-32768;
                                            goto 1;
                                       end;
                        {-----------------------------------------}
                        x:=csk;y:=m[csk];tabla[x,y]:=fekete;
                          if vizsgal(kp) then begin
                                                   p[csk,1]:=32767;
                                                   goto 1;
                                              end;
                        {----------------------------------------}
                        tabla[x,y]:=feher;
                          if vizsgal(kp) then begin
                                                   p[csk,1]:=32766;
                                                   goto 1;
                                              end;
                        {------------------------------------------}
                        tabla[x,y]:=semmi;y:=m[csk]-1;tabla[x,y]:=feher;
                          if vizsgal(kp) then begin
                                                   p[csk,1]:=-32767;
                                                   goto 1;
                                              end;
                        {-------------------------------------------}
                        tabla:=tabla1;tabla[csk,m[csk]]:=fekete;
                          sz:=0;
                          for x:=csk-3 to csk+3 do begin
                                                    if x<=9 then begin
                                                                      if x=csk then x:=csk+1;
                                                                      y:=m[x];tabla[x,y]:=fekete;
                                                                      if vizsgal(kp) then begin
                                                                                               sz:=sz+1;
                                                                                          end;
                                                                      tabla[x,y]:=semmi;
                                                                 end;
                                               end;
                          if sz>=2 then p[csk,1]:=32500;
                        {-------------------------------------------}
                        tabla[csk,m[csk]]:=feher;
                          sz:=0;
                          x:=csk-3;
                          for x:=csk-3 to csk+3 do begin
                                                    if x<=9 then begin
                                                                      if x=csk then x:=x+1;
                                                                      y:=m[x];tabla[x,y]:=feher;
                                                                      if vizsgal(kp) then sz:=sz+1;
                                                                      tabla[x,y]:=semmi;
                                                                 end;
                                               end;
                          if sz>=2 then p[csk,1]:=32300;
                        {-------------------------------------------}
                        tabla[csk,m[csk]]:=semmi;
                          if nyeroe(csk) then p[csk,1]:=32100;
                        {--------------------------------------------}
                        tabla[csk,m[csk]]:=semmi;x:=csk;y:=m[csk]-1;tabla[x,y]:=fekete;
                          if vizsgal(kp) then p[csk,1]:=p[csk,1]-100;
                        {--------------------------------------------}
                        tabla:=tabla1;
                        x:=csk;y:=m[csk];
                          for csl:=1 to 4 do begin
                                                tabla[x,y]:=fekete;
                                                p[csk,1]:=p[csk,1]+(szamol(kp,iranyc[csl,'x'],iranyc[csl,'y'])-1)*7;
                                                tabla[x,y]:=feher;
                                                p[csk,1]:=p[csk,1]+(szamol(kp,iranyc[csl,'x'],iranyc[csl,'y'])-1)*4;
                                           end;
                      1:tabla:=tabla1;
                   end;
        end;
      rendez(p);
        csi:=0;
        while p[csi,1]=p[csi+1,1] do csi:=csi+1;
      rnd:=p[random(csi),2];
 end;



BEGIN

For csi:=1 to 10 do m[csi-1]:=10-a[csi,0];
For csi:=1 to 10 do
    For csj:=1 to 10 do begin
        Case a[csi,csj] of
        0: tabla[csi-1,11-csj]:=semmi;
        1: tabla[csi-1,11-csj]:=feher;
        2: tabla[csi-1,11-csj]:=fekete
        else Halt(1);
        end;
    end;

CsabciRNDStrat:=rnd(10)+1;

END;

Function FStr(az: longint): string;
Var qs: string;
Begin
     Str(az,qs);
     FStr:=qs;
     End;

Function EgyikJatekos:boolean;
Begin
     If (Jnev='J†tÇkos') or (Gnev='J†tÇkos') then
        EgyikJatekos:=true else EgyikJatekos:=false;
     End;

Procedure ChangeVisualPage;
Begin
     EXIT;
     VSP:=kkp-VSP;
     SetVisualPage(VSP);
     End;

Procedure ChangeActivePage;
Begin
     EXIT;
     ACP:=kkp-ACP;
     SetActivePage(ACP);
     End;

Function Cenzor(a,b: string): string;
Begin
     If a='J†tÇkos' then Cenzor:=b else Cenzor:=a;
     End;

Procedure OXY(a,b: integer; c: string);
Begin
     OutTextXy(a,b,c);
     End;

Procedure NewOXY(a,b: integer; c: string);
{ejtsd: ny£ j¢k szi... (˜New York Ci..)}
Var betlen, totlen, ko1, ko2, ko3, stx: word;
    tset: TextSettingsType;
    e:char;
    f,g,h,j,k:string;
Begin
     Gettextsettings(tset);
     If (tset.horiz=1) then begin
        totlen:=textwidth(c);
        stx:=a-totlen div 2;
        f:='èåïó'; h:='ìñßò';
        g:='AIOU'; j:='ouOU';
        for ko1:=1 to length(c) do begin
         e:=c[ko1];
         betlen:=TextWidth(e);

         If tset.font=triplexfont then begin
         if pos(e,f)<>0 then
            begin
                 e:=g[pos(e,f)];
                 outtextxy(stx+betlen div 2+2,b-3,'''');
                 end;
         if pos(e,h)<>0 then begin
               outtextxy(stx+betlen div 2-3,b-3,'''');
               outtextxy(stx+betlen div 2+4,b-3,'''');
               e:=j[pos(e,h)];
            end;
         End;

         If tset.font=0 then begin
         if pos(e,f)<>0 then
            begin
                 e:=g[pos(e,f)];
                 outtextxy(stx+betlen div 2+1,b-1,'''');
                 end;
         if pos(e,h)<>0 then begin
               Line(stx+betlen div 2-1,b-4,stx+betlen div 2,b-5);
               Line(stx+betlen div 2+1,b-4,stx+betlen div 2+2,b-5);
            e:=j[pos(e,h)];
            end;
         End;

         outtextxy(stx+betlen div 2,b,e);
         stx:=stx+betlen;
         end;
     end;
End;



Procedure OXXY(a,b: integer; c: string);
Begin
     NewOXy(a,b,c);
     SetColor(GetColor+1);
     NewOxy(a+1,b,c);
     SetColor(GetColor-1);
          End;

Procedure XY(c:string);
Begin
     SetColor(11);
     NewOXY(Getmaxx div 2,456,c);
End;


Procedure ClD;
Const th=3;
Begin
     SetColor(Black);
     SetLineStyle(0,0,th);
     For pnt:=0 to getmaxx div (2*th) do begin
         Line(pnt*th,0,pnt*th,GetMaxy);
         Line(pnt*th,3*pnt*th div 4,GetMaxx-th*pnt,3*pnt*th div 4);
         Line(GetMaxx-pnt*th,0,GetMaxx-pnt*th,GetMaxy);
         Line(pnt*th,GetMaxy-(3*pnt*th div 4),GetMaxx-pnt*th,GetMaxy-(3*pnt*th div 4));
         End;
     SetColor(White);
     SetLineStyle(0,0,1);
     End;

Procedure ArcScrLoa(a: string;q1,q2,q3,q4,q5,q6,q7,q8,q9: word);
Var f: file;
    ly,lx,arclen: word;
    aal: byte;
    marad, tormax,arccod,aac: byte;
    LL: array[1..8] of word;
Begin
     LL[1]:=q1; LL[2]:=q2; LL[3]:=q3; LL[4]:=q4;
     LL[5]:=q5; LL[6]:=q6; LL[7]:=q7; LL[8]:=q8;
     ChangeActivePage;
     arccod:=37; tormax:=255;
     Assign(f,a);
     Reset(f,1);
     For i:=0 to pice-1 do begin
         BlockRead(f,sc2,LL[i+1],ly);
         ly:=1; lx:=1;
         While ly<piclen do begin
               Repeat
                     aac:=sc2[lx];
                     sc1[ly]:=aac;
                     Inc(ly); Inc(lx);
                     Until (aac=arccod) or (ly=piclen);
               If ly<piclen then begin
                  aac:=sc2[lx]; Inc(lx);
                  aal:=sc2[lx]; Inc(lx);
                  Dec(ly);
                  While aal>0 do begin
                        sc1[ly]:=aac;
                        Inc(ly); Dec(aal);
                        End;
                  End;
               End;
         If q9<>5 then PutImage(0,i*(480 div pice),sc1,q9);

          End;
     Close(f);
     ChangeVisualPage;
     End;

Procedure ArcScrSav(a: string);
Var f: file of byte;
    lx,ly,arclen: word;
    aal: word;
    marad, tormax,arccod,aac: byte;
Begin
     arccod:=37; tormax:=255;
     Assign(f,a);
     Rewrite(f);
     For i:=0 to pice-1 do begin
         GetImage(0,(480 div pice)*i,639,(480 div pice)*(i+1)-1,sc1);
         ly:=1; lx:=0;
         While ly<piclen do begin
               aac:=sc1[ly];
               aal:=1;
               While aac=sc1[ly+aal] do Inc(aal);
               If (aac<>arccod) and (aal=1) then begin Write(f,aac); Inc(lx); end else begin
                  For l:=1 to aal div tormax do begin
                      Write(f,arccod); Write(f,aac); Write(f,tormax); Inc(lx,3); End;
                  Write(f,arccod); Write(f,aac); Inc(lx,2);
                  marad:=aal mod tormax;
                  Write(f,marad); Inc(lx);
                  End;
               ly:=ly+aal;
               End;
         If ly=piclen then begin Write(f,sc1[ly]); Inc(lx); end;

         End;
     Close(f);
     End;


Procedure ScreenLoad(a: string; puty: shortint);
Var f:file;
Begin
     ChangeActivePage;
     Assign(f,a);
     Reset(f,1);
     For i:=0 to 7 do begin
         BlockRead(f,sc1,19206);
         If puty<>5 then PutImage(0,i*60,sc1,puty);
         end;
     Close(f);
     ChangeVisualPage;
     End;

Procedure ScreenSave(a: string);
Var f:file;
Begin
     Assign(f,a);
     Rewrite(f,1);
     For i:=0 to 7 do begin
         GetImage(0,60*i,639,60*i+59,sc1);
{         Outtextxy(320,200,FSTR(imagesize(0,60*i,639,60*i+59)));
         Delay(1000);                                            }
         BlockWrite(f,sc1,piclen);
         end;
     Close(f);
     End;




Procedure KPress;
Begin
{     SwapVectors;
     Exec(GetEnv('COMSPEC'), '/C PAUSE >NUL');
     SwapVectors;}

     Repeat until readkey<>'@';
end;

Procedure Welcome;
Const durb=22;
Var x,y: word;
    xa,xb: word;
    xc: real;

Begin
     {..}
     {SetFillStyle(1,Black);
     Bar(190,150,450,330);}
     {SetFillStyle (1,Black);
     Bar(190,150+durb,450,330-durb);
     Bar(190+durb,150,450-durb,330);
     SetColor(Black);
     FillEllipse(190+durb,150+durb,durb,durb);
     FillEllipse(450-durb,150+durb,durb,durb);
     FillEllipse(190+durb,330-durb,durb,durb);
     FillEllipse(450-durb,330-durb,durb,durb);}
     xc:=0;
     SetColor(yellow);
     NewOXY(320,200,'Csìamìba');
     SetTextStyle(DefaultFont,HorizDir,1);
     NewOXY(320,230,verzio+' '+'('+utomen+')');
     NewOXY(320,240,'Smith & Matson produkci¢');
     NewOXY(320,252,'KÇsz°tettÇk:');
     NewOXY(320,262,'Kov†cs Zolt†n Çs B°r¢ Csaba');
     NewOXY(320,272,'az 1993. Çvi nemzetkîzi');
     NewOXY(320,282,'Csìamìba Szabv†ny alapj†n');
     NewOXY(320,292,'Kov†cs Zsigmond');
     NewOXY(320,302,'grafik†inak felhaszn†l†s†val');
{     NewOXY(320,470,'Most is az seg°t, ami mindenen tov†bbvisz: az ENTER billentyñ!');}
     x:=408; y:=182; xa:=0; xb:=1;
     Repeat
           SetWriteMode(xorput);
           SetColor((5*xa));
           Line(x,y,x+trunc(Cos(xc)*(100-(80))),y+trunc(Sin(xc)*(20)));
           Line(x,y,x+trunc(Cos(xc+pi/2)*(100-(80))),y+trunc(Sin(xc+pi/2)*(20)));
           Line(x,y,x+trunc(Cos(xc+pi/2*3)*(100-(80))),y+trunc(Sin(xc+pi/2*3)*(20)));
           Line(x,y,x+trunc(Cos(xc+pi)*(100-(80))),y+trunc(Sin(xc+pi)*(20)));
           Inc(xa);
           If xa=128 then begin xa:=0; xc:=0; end;
           xc:=xc+(pi/128);
           Until keypressed;
     KPress;
     SetWriteMode(normalput);
     SetTextStyle(TriplexFont,HorizDir,4);
     { ClearDevice; }
     End;
Procedure OldBoys;
Var
    f: file of char;
    fc: char;
    fd: word;

Begin
     For i:=4 to 4 do begin
         Assign(f,'d'+FStr(i)+'.ICN');
         Reset(f);
         For fd:=0 to 486 do Read(f,icn[i+16,fd]);
         For fd:=0 to 485 do icn[i+16,fd]:=icn[i+16,fd+1];
         Close(f);
         End;
     Assign(f,'ikonok.dat');
     rewrite(f);
     For i:=1 to 30 do For fd:=0 to 485 do Write(f,icn[i,fd]);
     Close(f);
     End;

Procedure FrissitIni;
Var f:text;
    g:text;
    fc: char;
    fd: word;
    p1,p2,pp: byte;
    fs: string;
Begin
     Assign(f,'CSA.CFG');
     Assign(g,'CSA.NEW');
     Reset(f);
     Rewrite(g);
     While not eof(f) do begin
                 ReadLn(f,fs);
                 WriteLn(g,fs);
                 If fs='[MÇrkìzÇsek]' then begin
                 Repeat
                 ReadLn(f,fs);
                 p1:=pos(jnev,fs);
                 p2:=pos(gnev,fs);
                 If (p1=0) or (p2=0) then WriteLn(g,fs);
                 Until ((p1<>0) and (p2<>0)) or eof(f);
                 If (p1<>0) and (p2<>0) then begin
                    Write(g,Jnev,'ƒ',GNev,':');
                    WriteLn(g,pjat,'-',pszg);
                       End;
                    End;
                 If fs='[Alapk¢d]' then begin
                    ReadLn(f,fs);
                    For p1:=1 to 6 do Write(g,Chr(opt[p1].z+48));
                    WriteLn(g,Chr(opt[7].z+48));
                    End;
                 End;
     Close(f);
     Close(g);
     Erase(f);
     Rename(g,'CSA.CFG');
     End;

Procedure ElemezMerkozesek;
Var f:text;
    fc: char;
    fd: word;
    p1,p2,pp: byte;
    p3: boolean;
    fs: string;
Begin
     Assign(f,'CSA.CFG');
     Reset(f);
     While not eof(f) do begin
                 ReadLn(f,fs);
                 If fs='[MÇrkìzÇsek]' then begin
                 Repeat
                 ReadLn(f,fs);
                 p1:=pos(jnev,fs);
                 p2:=pos(gnev,fs);
                 p3:=p1>p2;
                 Until ((p1<>0) and (p2<>0)) or eof(f);
                 If (p1=0) or (p2=0) then Begin
                    Close(f);
                    Append(f);
                    WriteLn(f,jnev,'ƒ',gnev,':0-0');
                    pjat:=0; pszg:=0;
                    End Else Begin
                    p1:=pos(':',fs);
                    p2:=pos('-',fs);
                    If not p3 then begin
                       Val(Copy(fs,p1+1,p2-p1-1),pjat,fd);
                       Val(Copy(fs,p2+1,length(fs)-p2),pszg,fd);
                       End else Begin
                       Val(Copy(fs,p1+1,p2-p1-1),pszg,fd);
                       Val(Copy(fs,p2+1,length(fs)-p2),pjat,fd);
                       End;
                    End;
                    Close(f);
                    Exit;
                    End;
                 End;

     End;



Procedure ElemezIniFajl;
Var f:text;
    fc: char;
    fd: word;
    fs: string;
Begin
     Assign(f,'CSA.CFG');
     Reset(f);
     While not eof(f) do begin
                 ReadLn(f,fs);
                 If fs='[J†tÇkosok]' then begin
                    ReadLn(f,fs);
                    jate:=0;
                    fs:=fs+',';
                    Repeat
                          Inc(jate);
                          fd:=pos(',',fs);
                          jat[jate]:=Copy(fs,1,fd-1);
                          Delete(fs,1,fd);
                          Until (fs='') or (jate=5);
                    End;
                 If fs='[Sz†m°t¢gÇpek]' then begin
                    ReadLn(f,fs);
                    szag:=0;
                    fs:=fs+',';
                    Repeat
                          Inc(szag);
                          fd:=pos(',',fs);
                          szg[szag]:=Copy(fs,1,fd-1);
                          Delete(fs,1,fd);
                          Until fs='';
                    End;
opt[2].m:=jate;
opt[3].m:=szag+jate-1;
If jate>5 then jate:=5; {Korl†tozva a j†tÇkosok sz†m†t, ahogyan meg°gÇrtÅk.}
                 If fs='[Alapk¢d]' then begin
                    ReadLn(f,fs);
                    For fd:=1 to length(fs) do
                        If (Ord(fs[fd])>48) and (Ord(fs[fd])-48<=opt[fd].m)
                           then opt[fd].z:=ord(fs[fd])-48;
                    End;
           End;
           jat[1]:='J†tÇkos';
           szg[1]:='J†tÇkos';
           {szg[2]:='Sz†m°t¢gÇp';}
           Close(f);
           End;

Procedure CallErr(a: string);
Begin
     WriteLn;
     WriteLn(a);
     Delay(5000);
     WriteLn;
     Halt(1);
     End;

Procedure ELOZETES;
Const kom: array[1..2] of byte =(5,0);
Var lzt,tzl: byte;
    tzt: word;
Begin
     Randomize;
     lzt:=random(1)+3;
     For tzl:=1 to 2 do
     CASE lzt of
{          1: ArcScrLoa('#zs2.dat',9748,9993,12834,12694,13416,14102,15137,14668,kom[tzl]);
          2: ArcScrLoa('#zs3.dat',12614,12303,13405,13876,13001,12143,12731,11358,kom[tzl]);}
          3: ArcScrLoa('#szerbia.dat',7367,12086,14524,15794,16222,14987,14386,10067,kom[tzl]);
{          0: ArcScrLoa('#zs4.dat',8463,10273,10116,11099,11973,11229,13064,13328,kom[tzl]);}
          End;
     ARCscrLoa('#opsonsz.dat',6790,9700,12250,2716,4714,2995,1384,616,5);
     ArcScrLoa('#harcmez.dat',9666,12618,12764,12100,12602,12824,11534,11268,5);
     For lzt:=0 to 7 do
         For tzl:=0 to 7 do PutPixel(629+lzt,3+tzl,black);
     SetColor(White);
     Line(628+1,3+4,628+4,3+1);
     Line(628+1,3+4,628+6,3+4);
     Line(628+5,3+3,628+5,3+6);
     {Repeat until readkey<>#0;}
     Delay(5000);
     SetColor(Black);
     For tzt:=0 to 640+480 do
         Line(tzt,0,0,tzt);

     End;

Procedure opsnszinic;
Var
    f: file of char;
    fc: char;
    fd: word;
    g1, g2: integer;
Begin
     kkp:=0;
     acp:=kkp; vsp:=kkp;

     Assign(f,'ikonok.dat');
{$I-}
     Reset(f);
{$I+}
     If IOResult<>0 then CallErr('Nem tal†lom az IKONOK.DAT †llom†nyt. Vajon hol lehet?');
     For i:=1 to 30 do
         For fd:=0 to 485 do Read(f,icn[i,fd]);
     Close(f);
     {OldBoys;}

     Assign(f,'#szerbia.dat');
{$I-}
     Reset(f);
{$I+}
     If IOResult<>0 then CallErr('Hov† tñnt a #SZERBIA.DAT? Nincs a zsebedben?');
     Close(f);

     Assign(f,'csa.cfg');
{$I-}
     Reset(f);
{$I+}
     If IOResult<>0 then CallErr('Jaj, eltñnt a konfigur†ci¢s f†jlam! AnÇlkÅl pedig...');
     Close(f);

     Assign(f,'#harcmez.dat');
{$I-}
     Reset(f);
{$I+}
     If IOResult<>0 then CallErr('Gondolod, hogy ez a program elindul a #HARCMEZ.DAT †llom†ny nÇlkÅl?');
     Close(f);

     Assign(f,'alaphang.DAT');
{$I-}
     Reset(f);
{$I+}

     If IOResult<>0 then CallErr('Nincs meg az ALAPHANG.DAT †llom†ny. ês Çn biza igen szomor£ vagyok.');
     Close(f);

     Assign(f,'alaphang.dtx');
{$I-}
     Reset(f);
{$I+}
     If IOResult<>0 then CallErr('Baj van. Nem lelem az ALAPHANG.DTX †llom†nyt sehol.');
     Close(f);

     If RegisterBGIDriver(@egavgadriver)<0 then CallErr('Hoppszla! Valami cs£nya dolog van a kÇpernyì kîrÅl!');
     If RegisterBGIFont(@tripfont)<0 then CallErr('A hiba az ôn kÇszÅlÇkÇben van. Betñt°pus-regisztr†l†si hiba!');
     Detectgraph(g1,g2);
     If (g1<>6) and (g1<>9) and (g1<>10) then CallErr('A j†tÇk elind°t†s†hoz VGA-kompatibilis monitorra van szÅksÇg.');
     g1:=vga; g2:=vgahi;
     InitGraph(g1,g2,'');
     ChangeActivePage;
     ChangeVisualPage;
     ELOZETES;
{     ScreenLoad('OPSôNSZ.DAT',5);
     ScreenLoad('HARCMEZô.DAT',5);}


     opt[1].f:='SebessÇg';  opt[1].m:=3;
     opt[2].f:='X';           opt[2].m:=1;
     opt[3].f:='O';           opt[3].m:=2;
     opt[4].f:='Kezd';        opt[4].m:=3;
     opt[5].f:='VezÇrlÇs';opt[5].m:=2;
     opt[6].f:='IdìmÇrÇs';    opt[6].m:=3;
     opt[7].f:='Haszn. †llat'; opt[7].m:=2;
     opt[8].f:='Haszn. †llat';
     For i:=1 to 7 do opt[i].z:=1;
     ElemezIniFajl;

     End;

Procedure Atmasol;
Var pol: pointer;
Begin
     GetMem(pol,ImageSize(40,384,640,426));
     GetImage(40,384,640,426,pol^);
     PutImage(0,384,pol^,normalput);
     FreeMem(pol,ImageSize(40,384,640,426));
     SetColor(Green);
     SetTextStyle(DefaultFont,HorizDir,2);
     OXY(590,400,'F7');
     SetTextStyle(DefaultFont,HorizDir,1);
     SetColor(LightGreen);
     OXY(590,420,'Anim†ci¢');
     ArcScrSav('#opsonsz.dat');
     End;

Procedure PutImazs(i: shortint);
Var pix,piy,pic: word;
    pis: string;
    fd: word;
Begin
     pix:=i*90-60;
     piy:=360;
     pic:=i*5-5+opt[i].z;
     pis:='';
              If (i=2) or (i=3) then Begin
                 SetColor(0);
                 For fd:=427 to 440 do Line(i*90-85,fd,i*90+5,fd);
                 SetColor(Green);
                 SettextStyle(DefaultFont, Horizdir,1);
                 If i=2 then Jnev:=JAT[opt[2].z];
                 If i=2 then OXXY(140,432,jnev)
                  else if opt[3].z<=jate then gnev:=JAT[opt[3].z] else
                       gnev:=SZG[opt[3].z-jate+1];
                 If i=3 then OXXY(230,432,gnev);
                 SetColor(White);
                 If i=3 then If opt[3].z<=jate then pic:=5+opt[3].z else
                       pic:=11+opt[3].z-jate;
                 End;
     If i=7 then pic:=3+opt[7].z;
     PutImage(pix,piy,icn[pic],normalput);
     End;

Procedure Opsnsz;
Var
    f: file of char;
    fc: char;
    fd: word;
    Begin

     {SetTextStyle(TriplexFont, HorizDir,15);
     SetColor(LightGreen);
     OXY(320,260,'Opsînsz');}

{     ScreenLoad('OPSîNSZ.DAT',normalput);}
{     ArcscrSav('#o.dat');
     ClearDevice;}

     {ARCscrLoa('#opsôNSZ.dat',6790,9699,12249,2715,4713,2994,1234,541);}
     ARCscrLoa('#opsonsz.dat',6790,9700,12250,2716,4714,2995,1384,616,normalput);
     {AtMasol;}

{     SetColor(black);
     For i:=0 to 200 do Line(0,i,639,i);

     SetColor(White);
     NewOXY(320,30,'Az nyer, aki a saj†t jelÇbìl elìszîr');
     NewOXY(320,65,'rak ki nÇgyet egym†s mellÇ.');
     NewOXY(320,100,'Az ESC kilÇp a programb¢l.');
     NewOXY(320,135,'Az ENTER billentyñ az opci¢k be†ll°t†sa');
     NewOXY(320,170,'Çs a j†tÇk vÇgÇn tov†bblÇpÇst jelent.');

     ScreenSave('OPSîNSZ.DAT');}

         For i:=1 to 7 do
         PutImazs(i);

     Repeat
           Repeat
           fc:=readkey;
           Until ((fc>=#59) and (fc<=#66)) or (fc=#13) or (fc=#27);
           If fc=#27 then begin
              { ClearDevice; }
              CloseGraph;
              Halt(1);
              End;
           If (fc<>#13) then Begin
              i:=Ord(fc)-58;
              Inc(opt[i].z); If opt[i].z>opt[i].m then opt[i].z:=1;
              PutImazs(i);
              End;
           Until  (fc=#13) and ((GNev<>JNev) or ((Gnev='J†tÇkos') and (Gnev=JNev)));
     If opt[4].z=1 then xk:=true else xk:=false;
     If Gnev<>'HT 1080Z' then p:=false else begin
                   p:=true;
                   strat:=2; {.}
                   End;
     If Gnev='ZX81' then begin
        p:=true;
        strat:=3; {..}
        end;

     If opt[4].z=3 then begin
        Randomize;
        If random(100)<50 then xk:=true else xk:=false;
        End;
     szamok:=opt[5].z;
     szpidi:=opt[1].z;
     If opt[6].z=1 then For i:=1 to 180 do begin
                   ho[i]:=trunc(cos(i/360*pi)*40); end;
     j:=140;
     If opt[6].z=2 then For i:=1 to 180 do begin
         If i<=j then ho[i]:=trunc(sqrt(j*j-i*i)*20/j+18);
         If i>j then ho[i]:=trunc(21-sqrt((180-j)*(180-j)-(180-i)*(180-i))*20/(180-j));
         End;
{     If opt[6].z=3 then For i:=1 to 180 do begin
        If i<40 then ho[i]:=(180-i)-139 else ho[i]:=1;}

        If opt[6].z=3 then For i:=1 to 180 do begin
        ho[i]:=trunc( 40 / (i/2+1)) +1; {=}
        End;
        ho[181]:=0;

     { ClearDevice; }
     SetTextStyle(TriplexFont, HorizDir,4);
     SetTextJustify(CenterText,CenterText);
     If not EgyikJatekos then ElemezMerkozesek;
     End;

Function V(u,i,j,k,l:shortint): shortint;
Var x,y,z,s:shortint;
    stop: boolean;
Begin
     S:=0; stop:=false;
     For z:=0 to 3 do begin
         x:=i+z*k;
         y:=j+z*l;
         If (x<1) or (x>mh) or (y<1) or (y>mv) then stop:=true;
         If a[x,y]<>u then stop:=true else If not stop then Inc(s);
         End;
     v:=s;
End;

Procedure Video;
Var g1,g2,g3: integer;
    apo: pointer;
Begin
     GetMem(pp,ImageSize(0,0,34,33));
     GetMem(pq,ImageSize(0,0,34,35));
     SettextJustify(centertext,centertext);
     SettextStyle(TriplexFont,HorizDir,4);
     WelCome;
     Opsnsz;
{     ScreenLoad('harcmezî.DAT',normalput);
     ArcScrSav('#h.dat');}
     ArcScrLoa('#harcmez.dat',9666,12618,12764,12100,12602,12824,11534,11268,normalput);

     SetColor(black);

     If szamok=2 then begin
        GetMem(apo,imagesize(0,0,360,25));
        For g1:=1 to 36 do begin
            GetImage(141,11,141+360,36,apo^);
            PutImage(142,11,apo^,normalput);
            PutImage(142,407,apo^,normalput);
            End;
        Freemem(apo,imagesize(0,0,360,35));
        SetColor(Yellow);
        OXY(158,18,'0');
        OXY(158,414,'0');
        SetColor(Black);
        end;

     For g2:=0 to 1 do
     For g1:=40 to 399 do begin
         Line(g2*520,g1,g2*520+120,g1);
         Line(g2*520+120,g1,g2*520+120,g1);
         SetColor(g2*3+9);
         If g1<220 then
            Line (g2*540+50-ho[181-abs(g1-220)],g1,g2*540+51+ho[181-abs(g1-220)],g1) else begin
                 PutPixel(g2*540+50-ho[181-abs(g1-220)],g1,g2*3+9);
                 PutPixel(g2*540+51+ho[181-abs(g1-220)],g1,g2*3+9);
                 End;

         SetColor(black);
         End;

     Getmem(mu,imagesize(0,0,639,36));
     Getimage(0,443,639,479,mu^);

     PutImage(30,408,icn[opt[2].z+5],normalput);
     g3:=0;
     If opt[3].z<=jate then g3:=5+opt[3].z else
                       g3:=11+opt[3].z-jate;
     PutImage(570,408,icn[g3],normalput);

     For g1:=408 to 435 do begin
         g3:=0;

         If (g1/2)=(g1 div 2) then begin
         For g2:=0 to 39 do begin
             tbl[g2,1]:=false; tbl[g2,2]:=false;
             If (getpixel(g2+31,g1)=0) and (getpixel(g2+30,g1)=0) and (getpixel(g2+29,g1)=0)
             and (getpixel(g2+30,g1+1)=0) and (getpixel(g2+30,g1-1)=0) then
                tbl[g2,1]:=true;
             If (getpixel(g2+571,g1)=0) and (getpixel(g2+570,g1)=0) and (getpixel(g2+569,g1)=0)
             and (getpixel(g2+570,g1+1)=0) and (getpixel(g2+570,g1-1)=0) then
                tbl[g2,2]:=true;
                End;
         For g2:=0 to 39 do begin
             If (tbl[g2,1]) or (g2=0) or (g2=39) then Putpixel(g2+30,g1,lightblue);
             If (tbl[g2,2]) or (g2=0) or (g2=39) then Putpixel(g2+570,g1,lightred);
             End;
             End;


{             For g2:=0 to 19 do begin
                If (g3 mod 2=0) and (getpixel(g2+31,g1)=0) and ((g1/2)=(g1 div 2)) then
                   putpixel(g2+30,g1,lightblue) else g3:=g3 div 2+1;
                If (g3 div 2=0) and (getpixel(g2+571,g1)=0) and ((g1/2)=(g1 div 2)) then
                   putpixel(g2+570,g1,lightred) else g3:=g3 mod 2+2;
                End;
         g3:=0;
         For g2:=39 downto 19 do begin
                If (g3 mod 2=0) and (getpixel(g2+29,g1)=0) and ((g1/2)=(g1 div 2)) then
                   putpixel(g2+30,g1,lightblue) else g3:=g3 div 2+1;
                If (g3 div 2=0) and (getpixel(g2+569,g1)=0) and ((g1/2)=(g1 div 2)) then
                   putpixel(g2+570,g1,lightred) else g3:=g3 mod 2+2;
                End;}
         End;

     SetColor(14);
     SetTextStyle(DefaultFont, HorizDir, 1);
     If not EgyikJatekos then Begin
        OXXY(50,13,Jnev);
        OXXY(590,13,Gnev);
        SetColor(10);
        OXXY(50,26,FStr(pjat));
        OXXY(590,26,FStr(pszg));
        End Else Begin
        OXXY(50,20,Jnev);
        OXXY(590,20,Gnev);
        End;
     SetColor(White);
     SettextStyle(TriplexFont,HorizDir,4);

End;

Procedure Snd(a,b: word);
Var bm, bn, bo: word;
Begin
     NoSound;
     For bm:=1 to b do begin
         Case a of
              1: Sound(Random(50)+50);
              2: Begin
                      bn:=Random(200)+200;
                      For bn:=bn to bn+20 do begin
                          Sound(bn); Delay(1); end;
                      End;
              3: Begin
                      bn:=Random(200)+400;
                      For bo:=1 to 20 do begin
                          Sound(bn+Random(bo)); delay(1); end;
                      End;
              End;
         Delay(1);
         End;
     NoSound
     End;

Procedure Vars;
Begin

     Tim[1,1]:=1; Tim[1,2]:=0; Tim[2,1]:=1; Tim[2,2]:=0;
     oot:=0;
     pnt:=0;
     For i:=0 to mv do
         For j:=1 to mh do a[j,i]:=0;
     Lr:=1;
     n:=0;
End;

Function Time(pl: shortint):boolean;
Var qb: integer;
Begin
     { tim[pl,1..2] tartalmazza a sort + oszlopot }
     Time:=false;
     If tim[pl,2]<=ho[Tim[pl,1]] then Begin
        PutPixel((pl-1)*540+51-tim[pl,2],39+tim[pl,1],black);
        PutPixel((pl-1)*540+50+tim[pl,2],39+tim[pl,1],black);
        For qb:=223 to 399-tim[pl,1] do begin
            PutPixel((pl-1)*540+50,qb,pl*3+6);
            PutPixel((pl-1)*540+51,qb,pl*3+6);
            PutPixel((pl-1)*540+50,qb,black);
            PutPixel((pl-1)*540+51,qb,black);
            End;

        PutPixel((pl-1)*540+51-tim[pl,2],400-tim[pl,1],pl*3+6);
        PutPixel((pl-1)*540+50+tim[pl,2],400-tim[pl,1],pl*3+6);
        Inc(tim[pl,2]);
        End Else Begin
            Tim[pl,2]:=0;
            Inc(Tim[pl,1]);
            If Tim[pl,1]=181 then Time:=true; {=}
            End;
     End;


Procedure Cl1;
Begin
     PutImage(0,443,mu^,normalput);
     End;

Function Fer(i:byte):boolean;
Begin
     If a[i,0]<mv then Fer:=true else Fer:=false;
End;

Procedure Put(l:byte;X:shortint);
Const jn: array[1..2,0..3] of byte=((16,23,24,29),(17,19,20,25));
Var elozo,s1,v1,lep,dif,g1,janka: integer;
    vege,voltmar: boolean;
    fixy:integer;
Begin
     Janka:=Random(4);
     elozo:=0;
     s1:=41; v1:=401-a[l,0]*36;
     If szpidi=2 then dif:=4 else if szpidi=3 then dif:=7 else dif:=2;
     Lep:=0;
     vege:=false;
     voltmar:=false;
     Repeat
           lep:=lep+dif;
           s1:=s1+lep;
           If s1>v1 then begin
              s1:=v1;
              lep:=-(lep div 2);
              If (lep=-1) or (lep=0) or (lep=-2) then vege:=true;

              end;
           SetActivePage(1);
           
           {ClearDevice;} { Ez valamiert nem mukodik Turbo Pascal 7.0-n. Beletorol a masik active page-be is. }
           { Az alabbi ket sor javitja ezt. Nem a teljes kepernyot toroljuk, csak egy kis reszletet. KZ, 2022-10-04 }
           SetColor(black);
           for fixy:=41 to 41+35 do Line(100,fixy,175,fixy);
           
           SetColor(x*3+6);
           If opt[7].z=2 then OXY(156,55,C[x]) else
                PutImage(138,46,icn[jn[x,janka]],normalput);
           SetColor(White);
           For g1:=s1 to s1+35 do
               If (g1-4) mod 36=0 then Line(100,41+(g1-s1),175,41+(g1-s1));
           GetImage(141,41,175,41+33,pp^);
           SetActivePage(0);
           If voltmar then PutImage(105+l*36,elozo,pq^,normalput);
           PutImage(105+l*36,s1,pp^,normalput);
           SetActivePage(1);
           GetImage(100,41,134,41+35,pq^);
           SetActivePage(0);
           voltmar:=true;
           elozo:=s1;
           Until vege;
End;

Procedure LepX(z:shortint);
Begin
     Inc(a[z,0]);
     a[z,a[z,0]]:=1;
     End;

Procedure LepO(z:shortint);
Begin
     Inc(a[z,0]);
     a[z,a[z,0]]:=2;
     End;


Procedure X;
Var qw: string;
    qs: word;
    csams: char;
Begin

     qw:='';
     Cl1;
     If p then begin
        If pnt<-80 then qw:=Message(Random(5)+45);
        If (pnt<-50) and (pnt>-81) then qw:=Message(Random(5)+40)+' ';
        If (pnt<-11) and (pnt>-51) then qw:=Message(Random(10)+30)+' ';
        if pnt>-2 then qw:=qw+Message((Random(5)+20));
        If (pnt>-81) and (pnt<-1) then qw:=qw+Message(Random(5)+15);
        End
         Else qw:=qw+Cenzor(Jnev,'X')+' lÇp.';
     XY(qw);
     qs:=0;
     Repeat
          Repeat
                k:=#00;
                Inc(qs);
                If keypressed then k:=readkey;
                If qs=1 then If Time(1) then begin
                   oot:=1; exit; end;
                If (szpidi=1) and (qs=260)
                   or (szpidi=2) and (qs=155)
                   or (szpidi=3) and (qs=32) then qs:=0;
                i:=pos(k,szamsor[szamok]+#27);
          Until i<>0;
     If i=11 then Begin
        Haltestelle:=true;
        Exit;
        End;
     Until Fer(i);
     LepX(i);
     utolsolepes:=i;
     Put(i,1);
     End;

Procedure OJ;
Var qs: word;
Begin
     If not p then begin
        Cl1; XY(Cenzor(Gnev,'O')+' lÇp.'); End;
     qs:=0;
     Repeat
          Repeat
                k:=#00;
                Inc(qs);

                If qs=130 then qs:=0;
                If qs=1 then If time(2) then begin
                   oot:=2; exit; end;
                if keypressed then k:=readkey;
                i:=pos(k,szamsor[szamok]+#27);
          Until i<>0;
     If i=11 then Begin
        Haltestelle:=true;
        Exit;
        End;
     Until Fer(i);
     LepO(i);
     utolsolepes:=i;
     Put(i,2);
     End;

Function HanyVanNeki(mije, kinek: shortint): integer;
Var perjel, fordperjel, vizsz, fugg, szaml: integer;
Begin
     szaml:=0;
             fordperjel:=V(kinek,utolsolepes,a[utolsolepes,0],-1,1)+
                     V(kinek,utolsolepes,a[utolsolepes,0],1,-1)-1;
             perjel:=V(kinek,utolsolepes,a[utolsolepes,0],1,1)+
                     V(kinek,utolsolepes,a[utolsolepes,0],-1,-1)-1;
             vizsz:=V(kinek,utolsolepes,a[utolsolepes,0],-1,0)+
                     V(kinek,utolsolepes,a[utolsolepes,0],1,0)-1;
             fugg:=V(kinek,utolsolepes,a[utolsolepes,0],0,1)+
                     V(kinek,utolsolepes,a[utolsolepes,0],0,-1)-1;

             If fordperjel>4 then fordperjel:=4;
             If perjel>4 then perjel:=4;
             If vizsz>4 then vizsz:=4;
             If fugg>4 then fugg:=4;

             {Cl1;
             XY(c[kinek]+FStr(utolsolepes)+' '+FStr(fordperjel)+'\ '+FStr(perjel)+'/ '+FStr(vizsz)+'- '+FStr(fugg)+'|');}
             If fordperjel=mije then Inc(szaml);
             If perjel=mije then Inc(szaml);
             If vizsz=mije then Inc(szaml);
             If fugg=mije then Inc(szaml);

     HanyVanNeki:=szaml;
End;


Procedure AtoC;
Begin
     For i:=0 to mv do
         For j:=1 to mh do d[j,i]:=a[j,i];
     End;

Procedure CtoA;
Begin
     For i:=0 to mv do
         For j:=1 to mh do a[j,i]:=d[j,i];
     End;

Procedure AtoB;
Begin
     For i:=0 to mv do
         For j:=1 to mh do b[j,i]:=a[j,i];
     End;

Procedure BtoA;
Begin
     For i:=0 to mv do
         For j:=1 to mh do a[j,i]:=b[j,i];
     End;


Function ertekAllas(jt:byte): longint;
Const PT: array[1..2,1..4] of byte = ((1,4,10,100),(1,4,9,255));

{ Const PT: array[1..2,1..4] of word = ((0,2,20,100),(0,3,15,65535));}
Var pont: longint;
    iq: shortint;
    iz: longint;
Begin
     { Pontozas: 4-es 16 pont. 3-as 9 pont. 2-es 4 pont. 1-es 1 pont. }
     pont:=0;
     For iq:=2 to 4 do begin
     iz:=HanyVanNeki(iq,jt);
         Inc(pont,iz*(PT[jt,iq]{-PT[jt,iq-1]}));
     End;
     ertekAllas:=pont;
     End;

Function KovLepesX: shortint;
Const rossz=-maxlongint;
      tz=4;
Var pszu, pszr, comm: longint;
    e,f: shortint;
Begin
     e:=1; f:=5;
     pszr:=rossz+1;
     AtoC;
     Repeat
           Inc(timgep);
           If timgep=2 then begin
              timgep:=0;
              If time(2) then begin
                 oot:=2; exit; end;
              end;
           comm:=1;
           If fer(e) then begin
              LepX(e);
              utolsolepes:=e;
              pszu:=ertekAllas(1);
              end else pszu:=rossz;

           If pszu>=pszr then if (pszu>pszr) or ((pszu=pszr) and (random(3)=2)) then begin
              f:=e;
              pszr:=pszu;
              End;

           Inc(e);
           CtoA;
           Until (e=11) or (oot=2);
     If (f<1) or (f>10) then XY('Morbid kr¢nikus tranfuzion†lis t£lcsordul†s. H°vjon szakembert!');
     KovlepesX:=f;
     End;

Function KovLepesO: shortint;
Const rossz=-maxlongint;
Var pszu, Oe, Xe, pszr, comm: longint;
    e,f,g: shortint;
Begin
     timgep:=0;
     e:=1; f:=5;
     pszr:=rossz+1;
     AtoB;
     Repeat
           comm:=1;
           If fer(e) then begin
              LepO(e);
              utolsolepes:=e;
              Oe:=ertekAllas(2);
              g:=kovlepesX;
{.}           LepX(g);
              utolsolepes:=g;
              Inc(oe,ertekallas(2));
              utolsolepes:=e;
              Xe:=ertekAllas(1);
              utolsolepes:=g;
              Inc(xe,ertekallas(1));
              pszu:=oe-xe;

              Randomize;
{!!!}         Inc(pszu,Random(3));
              Dec(pszu,Random(3));

              end else pszu:=rossz;
{           Cl1;
           XY('O:'+FStr(oe)+'('+FStr(e)+')-X:'+FStr(xe)+'('+FStr(g)+')='+FStr(pszu));}
           {KPress;}
           If pszu>pszr then begin
              f:=e;
              pszr:=pszu;
              End;

           e:=e+1;
           BtoA;
           Until e=11;
     If (f<1) or (f>10) then XY('Morbid kr¢nikus tranfuzion†lis t£lcsordul†s. H°vjon szakembert!');
     kovlepesO:=f;
     pnt:=pszr;
     End;


Function STRAT2: shortint;
Begin
     AtoB;
     strat2:=KovLepesO;
     BtoA;
End;

Procedure OG;
Var s: shortint;
Begin
     Cl1;
     XY(Message(Random(5)+25));
 { STRATEGY #0 }
If strat=0 then begin
    Randomize;
    Repeat
           i:=Random(10)+1;
     Until Fer(i);
     End;

 { STRATEGY #1 }
If strat=1 then begin
    Randomize;
    Repeat
    Repeat
           i:=i+random(5)-2;
     Until (i<10) and (i>0);
     Until Fer(i);
     End;
 { STRATEGY #2 CBS }

 If strat=3 then
   if n=1 then if a[5,1]=1 then i:=6 else i:=5 else i:=STRAT2;

 If strat=3 then i:=CsabciRNDStrat;

 { STRATEGY #3 }
If strat=2 then
   if n=1 then if a[5,1]=1 then i:=6 else i:=5 else i:=STRAT2;


If oot=0 then begin
     Inc(a[i,0]);
     a[i,a[i,0]]:=2;
     Put(i,2);
     utolsolepes:=i;
     end;
End;

Procedure O;
Begin
     If p then OG else OJ;
     End;

Function Nyert(x:shortint): boolean;
Var iq,iz: longint;
Begin
     Nyert:=false;
     If HanyVanNeki(4,x)>0 then Nyert:=true;

     If abs(x-3)=oot then begin
            Cl1;
            XY('Out of time error');
            Snd(1,5000);
            Cl1;
        Nyert:=true;
        End;

End;

Function NOHely: boolean;
Begin
     j:=0;
     For i:=1 to mh do If a[i,0]=mv then Inc(j);
     If j=mh then NOHely:=true else NOHEly:=false;
End;

Function Sgn(a: shortint): shortint;
Begin
     If a>0 then Sgn:=1;
     If a=0 then Sgn:=0;
     If a<0 then Sgn:=-1;
     End;

Procedure Szinez(x,y: shortint);
Var ex,ey: integer;
Begin
     ex:=Random(34)+105+x*36; ey:=401-(y*36)+Random(34);
             If (getpixel(ex,ey)=0) and (Random(10)<5) then
                PutPixel(ex,ey,ny*3-2);
     End;

Procedure Villant(ki: shortint);
Var sx,sy,zx,zy,plx,ply,q1,q2,q3,q4,q6,q7,q8,q9,zz: shortint;
    ol: array[1..4,1..2] of shortint;
    ii: longint;
Begin
     zx:=utolsolepes;
     zy:=a[utolsolepes,0];
             q7:=V(ki,utolsolepes,a[utolsolepes,0],-1,1);
             q3:=V(ki,utolsolepes,a[utolsolepes,0],1,-1);
             q9:=V(ki,utolsolepes,a[utolsolepes,0],1,1);
             q1:=V(ki,utolsolepes,a[utolsolepes,0],-1,-1);
             q4:=V(ki,utolsolepes,a[utolsolepes,0],-1,0);
             q6:=V(ki,utolsolepes,a[utolsolepes,0],1,0);
             q8:=V(ki,utolsolepes,a[utolsolepes,0],0,1);
             q2:=V(ki,utolsolepes,a[utolsolepes,0],0,-1);
     If q3+q7>=5 then begin sx:=zx-q7; sy:=zy+q7; end;
     If q9+q1>=5 then begin sx:=zx-q1; sy:=zy-q1; end;
     If q4+q6>=5 then begin sx:=zx-q4; sy:=zy; end;
     If q2+q8>=5 then begin sx:=zx; sy:=zy-q2; end;

     plx:=sgn(zx-sx); ply:=sgn(zy-sy);
     For i:=1 to 4 do begin
         Inc(sx,plx);
         Inc(sy,ply);
         ol[i,1]:=sx;
         ol[i,2]:=sy;
         End;
     For ii:=1 to 8000 do begin
         zz:=random(4)+1;
         Szinez(ol[zz,1],ol[zz,2]);
         End;

End;

Function Kilep: boolean;
Var kkkkk: char;
    kali, ilak, ilka: word;
    Tset: textsettingstype;
Begin
    If not egyikJatekos then begin
       kali:=getcolor;
       For ilka:=22 to 31 do
                If ilka div 2<>ilka/2 then begin
                   SetColor(lightblue);
                   Line(2,ilka,90,ilka);
                   SetColor(lightred);
                   Line(542, ilka, 632, ilka);
                   end else begin
                       SetColor(black);
                       Line(2,ilka,90,ilka);
                       Line(542, ilka, 632, ilka);
                       end;
        SetColor(10);
        GetTextSettings(Tset);
        Settextjustify(centertext,centertext);
        SettextStyle(defaultfont,horizdir,1);
        OXXY(50,26,FStr(pjat));
        OXXY(590,26,FStr(pszg));
        SettextJustify(tset.horiz, tset.vert);
        SettextStyle(tset.font, tset.direction, tset.charsize);
        SetColor(kali);
        End;

    KiLep:=false;
    kkkkk:=readkey;
    If (kkkkk=#13) or (kkkkk=#27) then Kilep:=true;
    End;

Procedure VegeE;
Begin
     Cl1;
     ny:=0;
     If oot<>0 then ny:=3-oot;
     If Nyert(1) then ny:=1;
     If Nyert(2) then ny:=2;
     If ny<>0 then Villant(ny);
     If Ny=1 then Begin If not p then XY(Cenzor(Jnev,'X')+' nyert. Gratul†lok.') else
           XY(Message(random(10)+50));
           Snd(2,100);
           Inc(pjat);
           If not EgyikJatekos then FrissitIni;
        Repeat until Kilep; Haltestelle:=true; End;
     If Ny=2 then Begin
        If not p then XY(Cenzor(GNev,'O')+' nyert. Gratul†lok.') else
           XY(Message(random(11)+4));
        If not p then Snd(2,100) else Snd(3,100);
        Inc(pszg);
        If not EgyikJatekos then FrissitIni;
        Repeat until KiLep; Haltestelle:=true; End;
     If NOHely then Begin XY('Dîntetlen.'); Inc(pjat); Inc(pszg);
     If not EgyikJatekos then FrissitIni;
        Repeat until KiLep; Haltestelle:=true; End;
End;



Begin
     opsnszinic;
     {MakeTextIndexFile('öZENETEK');}
Repeat
     haltestelle:=false;
     Vars;
     CBSInit;
     Video;
     {Players;}
     If not XK then begin
        Inc(n);
        O; VegeE; Cl1;
        End;
     Repeat
           If not haltestelle then begin Randomize;
           X; Cl1; Inc(n);
            VegeE; end;
            If not haltestelle then begin
                               O; Inc(n); VegeE; End;
           Until haltestelle;
           Freemem(pp,ImageSize(0,0,34,33));
           Freemem(pq,ImageSize(0,0,34,35));
           Freemem(mu,ImageSize(0,0,639,36));
           Cld;
           Until false;
     End.


{ End of source file. 94/03/17 }