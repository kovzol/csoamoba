/* 3.4-es_verzio.c */

/* Ez a fájl a jatek.c egy darabja, de áttekinthetõségi okok miatt külön
   állományba került. */

/* A "CS_"-vel kezdõdõ eljárások egy az egyben az eredeti -- 3.4-es --
   Csõamõbából lettek áttéve. A különbség annyi, hogy a Tabla tömb
   másképpen van indexelve: C-ben 0-9 van 1-10 helyett, és az egész
   tábla Y-tengely szerint megfordul. */

int CS_V(int u, int i, int j, int k, int l) 
{
   int x,y,z,s=0,stop=0;
   for (z=0;z<4;++z)
   {
      x=i+z*k;
      y=j+z*l;
      if ((x<0) || (x>9) || (y<0) || (y>9)) stop=1;
      if (Tabla[x][y]!=u) stop=1;
      else if (!stop) ++s;
      }
   return s;
}

int CS_HanyVanNeki(int mije, int kinek)
{
   int perjel, fordperjel, vizsz, fugg, szaml=0;
   fordperjel=CS_V(kinek,utolsolepes,TJ[utolsolepes],1,1)+
      CS_V(kinek,utolsolepes,TJ[utolsolepes],-1,-1)-1;
   perjel=CS_V(kinek,utolsolepes,TJ[utolsolepes],1,-1)+
      CS_V(kinek,utolsolepes,TJ[utolsolepes],-1,1)-1;
   vizsz=CS_V(kinek,utolsolepes,TJ[utolsolepes],-1,0)+
      CS_V(kinek,utolsolepes,TJ[utolsolepes],1,0)-1;
   fugg=CS_V(kinek,utolsolepes,TJ[utolsolepes],0,1)+
      CS_V(kinek,utolsolepes,TJ[utolsolepes],0,-1)-1;

   if (fordperjel>4) fordperjel=4;
   if (perjel>4) perjel=4;
   if (vizsz>4) vizsz=4;
   if (fugg>4) fugg=4;

   if (fordperjel==mije) ++szaml;
   if (perjel==mije) ++szaml;
   if (vizsz==mije) ++szaml;
   if (fugg==mije) ++szaml;

   return szaml;
}


//--------------------

/* struct {unsigned int x,y;} koortipus;
struct {int[10][3]} ponttipus; // konverzió miatt a második dimenzióhoz 1-et adtam, KZ

signed int csi,csj;

#define SEMMI 0
#define FEKETE 1
#define FEHER 2

void CS_CBSInit()
{
     int i,sot=sizeof(CS_tabla),som=sizeof(CS_m);
     for (i=0;i<sot;++i)
     	tabla[i]=SEMMI;
     for (i=0;i<sot;++i)
     	m[i]=10;
     }

signed short int CS_CsabciRNDStrat()
{
	unsigned short szamol(koortipus d;signed short b,c)
  	{
		koortipus a;
        	a=d;
                while (a.tabla[a.x+b][a.y+c]==tabla[a.x][a.y]) do
		{
                	a.x+=b;
			a.y+=c;
			}
		b=-b;
		c=-c;
		csj=1;

                while (tabla[a.x+b][a.y+c]==tabla[a.x,a.y]) do
		{
                	x+=b;
                        y+=c;
			++csj;
			}
                return csj;
                } // szamol függvény vége
 
	int vizsgal(koortipus a)
	{
		int vizsg=0;
       		for (csi=1;csi<5;++csi)
		   if (szamol(a,iranyc[csi,'x'],iranyc[csi,'y'])>=4)
		   {
		   	vizsg=1;
			csi=4;
			}
		}

	void rendez(ponttipus *a)
	{
		short c;
		for (csi=0; csi<9; ++csi)
			for (csj=8; csj>=csi; --csj)
			if (*a[csj][1]<*a[csj+1][1])
			{
                        	c=*a[csj][1];
				*a[csj][1]=*a[csj+1,1];
				*a[csj+1][1]:=c;
                                c=*a[csj][2];
				*a[csj][2]=*a[csj+1][2];
				*a[csj+1][2]:=c;
				}
		}

 	int nyeroe(unsigned short a)
	{
  		koortipus kp;
		int nyer=0;
        	kp.x=a;
        	for (kp.y=2;kp.y<=m[a];++(kp.y))
		{
                	tabla[kp.x][kp.y]=FEKETE;
                        if (vizsgal(kp))
                        {
                        	tabla[x][y]=SEMMI;
                                --(kp.y);
                                tabla[x][y]=FEKETE;
                                if (vizsgal(kp))
				{
					NYER=1;
                                        tabla[kp.x][kp.y]=SEMMI;
                                        break; // !!!!!!!!!!!!!!!!!!!
					}
                                tabla[kp.x][kp.y]=SEMMI;
				++kp.y;
				}
                         tabla[kp.x][kp.y]=SEMMI;
                         }
  		}

	unsigned short rnd(unsigned short a)
	{
		koortipus kp;
		tablatipus tabla1;
		unsigned short xx,sz;
		ponttipus p=pc;           .....................az iranyc, pc-tol folyt.kov.

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

   */
