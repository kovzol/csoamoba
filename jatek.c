/* Cs�am�ba -- k�zponti file */
#define VERZIO 4
#define ALVERZIO 1
#include <stdio.h>
#include "forms.h" // maga a Forms Library
#include "X1.xpm"  // ikonok 8 soron �t
#include "X2.xpm"
#include "X3.xpm"
#include "X4.xpm"
#include "O1.xpm"
#include "O2.xpm"
#include "O3.xpm"
#include "O4.xpm"
#include "ures.xpm"  // �res ikon
#include "tabla.xpm"  // t�blak�p
#include "uzenet.c"  // magyar nyelv� sz�veggy�jtem�ny

int Tabla[10][10];
int TJ[10]; /* az egyes oszlopok f�r�helyeinek sz�ma */
int utolsolepes,telioszlopok=0;
char J[2][20]; /* j�t�kosok neve */
int KETJATEKOS=0,GEP=1,L=1,MUZIK=2; /* ezt a main()-b�l tett�k �t */
FL_FORM *opsonsz_menu;
FL_OBJECT *gomb[7];
int g[7];

#include "3.4-es_verzio.c" // A 3.4-es verzi� fontos rutinjai (strat�gi�k,
			   // t�blaelemz� rutinok) k�l�n f�jlban vannak.
#include "opsonsz.c" // Az Ops�nsz men� is.
#include "cimoldal.c" // S�t, a C�moldal is.

char pingpong[2][8192], nevetes[32768], dontetlen[32768]; // digitaliz�lt hangok


void Hang(char *s)  // k�ls� hangf�jl lej�tsz�sa (csak p�ldak�nt, nem haszn�ljuk)
{
   char buf[50];
   sprintf(buf,"cat %s >/dev/audio &",s);
   system(buf);    
  }

void Nevetes()      // Ezt sem haszn�ljuk.
{
   Hang("nevetes6.au");
   }

void Dontetlen()
{
   Hang("dontetlen.au");  // Ezt sem.
   }

int GepLep(int L)
{
	return (random()%10);
	}


int main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *jel, *tab, *obj, *rubrika[10][10], *uzenet;
  FILE *p,*r;
  int i,I,j,kezdes=1;
  int v;
  char buf[30];
  char sc[2]; /* "shortcut" */
  sc[1]=0;

 

  strcpy(J[0],"X");
  strcpy(J[1],"O");
	  
   // A gyakran lej�tszand� hangokat a mem�ri�b�l �rjuk ki a /dev/audio-ra.

   p=fopen("Q1.au","r");
   fseek(p,1000,SEEK_SET);
   fread(pingpong[0],1,8192,p);
   fclose(p);
   p=fopen("Q2.au","r");
   fseek(p,1000,SEEK_SET);
   fread(pingpong[1],1,8192,p);
   fclose(p);
   p=fopen("nevetes6.au","r");
   fread(nevetes,1,32768,p);
   fclose(p);
   p=fopen("dontetlen.au","r");
   fread(dontetlen,1,32768,p);
   fclose(p);

   // L�trehozzuk a j�t�kablakot.
   fl_initialize(&argc, argv, "Cs�am�ba", 0, 0);
   Cimoldal();
   Opsonsz_inic();

   form = fl_bgn_form(FL_UP_BOX,375,479);    // f�doboz
   tab = fl_add_pixmap(FL_NORMAL_PIXMAP,0,0,375,439,"");  // t�blarajz
   uzenet = fl_add_box(FL_FLAT_BOX,0,439,375,41,""); // null-�zenet
   // Kitessz�k az als� �zenetdobozt.
   /* A 13 �s 6 az eredeti sz�nek. */
   fl_set_object_color(uzenet,13,13);
   fl_set_object_lcol(uzenet,6);
   fl_set_object_lsize(uzenet,FL_HUGE_SIZE);
   fl_set_object_lstyle(uzenet,FL_TIMESBOLD_STYLE);
   for (i=0; i<10; ++i)
      for (j=0; j<10; ++j)
      {
      	 rubrika[i][j]=fl_add_pixmapbutton(FL_NORMAL_BUTTON,i*36+8,
            j*36+40,35,35,"");
	 fl_set_object_color(rubrika[i][j],FL_BLACK,FL_YELLOW);
	 fl_set_object_lcol(rubrika[i][j],FL_BLACK);
	 }
   fl_end_form(); // V�ge a k�perny� kirajzol�s�nak, pontosabban
  		 // n�h�ny finoms�g be�ll�t�sa m�g h�travan.

  fl_set_pixmap_data(tab,tabla);
 

 
 
  do { /* EZ MEGY K�RBE-K�RBE J�T�KONK�NT */
  Opsonsz_aktiv();
  if (MUZIK==1) r=fopen("/dev/audio","w");
  
  // aktualiz�ljuk az �j j�t�khoz a t�blak�pet
  if (KETJATEKOS || (GEP!=L)) // k�t j�t�kos j�tszik vagy nem a g�p kezd
   	sprintf(buf,"%s",M_JatekosKezd(J[L-1]));
     	else sprintf(buf,"%s",M_GepKezd());	  // kezd� feliratok

   // A 100 n�gyzetet rajzoljuk ki.
 for (i=0; i<10; ++i)
  {
     TJ[i]=10;
     for (j=0; j<10; ++j)
     {
        fl_set_pixmap_data(rubrika[i][j],ures);
        Tabla[i][j]=0;
	sc[1]=((i+1)%10)+48;
	fl_set_object_shortcut(rubrika[i][j],sc,1);
        fl_deactivate_object(rubrika[i][j]);
        }
     fl_activate_object(rubrika[i][9]);
     } // Mindig csak az oszlopok legals�, m�g �res rubrik�i akt�vak.
       // Egyel�re viszont mind �res.
  #include "jatek_ablakcim_utf8.c"
  // fl_show_form(form,FL_PLACE_SIZE,FL_FULLBORDER,"Cs�am�ba");
  // Most tessz�k ki a k�perny�t.


/* F�hurok */

  do
  {

   if (KETJATEKOS || (GEP!=L)) I=-1;
   else I=0;
     		// Jelezz�k, hogy most nem a g�p l�p. (Ett�l a v�ltoz�t�l f�gg
	  	// k�s�bb az, hogy a g�p l�pett-e vagy egy j�t�kos, ez �gy
		// k�nyelmesebben kezelhet�.)

 
  if (!kezdes)	/* a kezd�l�p�st m�r kezelt�k kor�bban */
  {
  if (I==-1)
   	sprintf(buf,"%s",M_JatekosLep(J[L-1]));
   else sprintf(buf,"%s",M_GepLep(random()%21-11));
   fl_set_object_label(uzenet,buf);
   XFlush(fl_get_display());
   fl_msleep(50);
   }
  else kezdes=0;

  if (I==-1) obj=fl_do_forms();
  else {
  	  I=GepLep(L);
	  fl_check_forms(); // Ha ez nincs itt, az el�z� l�p�shez tartoz� kurzor
	  		    // nem t�nik el. (A tov�bbiakban is haszn�ljuk ezt
			    // a fog�st.)
	  fl_msleep(2500);
	  }

  v=random()%4;
  for (i=0; i<10; ++i)
     if (
     		(i==I)   /* a g�p l�p�se eset�n */
     		||
     		(((obj==rubrika[i][TJ[i]-1])&&(Tabla[i][TJ[i]-1]==0))) /* k�l�nben */

		)

                {
                   if (L==1) 
                   	switch(v) /* a megfelel� rubrika ikonjainak �t�r�sa */
                        {
                        	case 0:
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],X1);
                                   break;
                        	case 1 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],X2);
                                   break;
                        	case 2 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],X3);
                                   break;
                        	case 3 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],X4);
                                   break; /* n�gyf�le ikonb�l v�laszthatunk */
                                }
                   else 
                        switch(v)
                        {
                        	case 0 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],O1);
                                   break;
                        	case 1 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],O2);
                                   break;
                        	case 2 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],O3);
                                   break;
                        	case 3 :
                                   fl_set_pixmap_data(rubrika[i][TJ[i]-1],O4);
                                   break; /* itt is 4-f�le lehet�s�g */
                                }

                   if (MUZIK==1) fwrite(pingpong[L-1],1,8192,r); /* Klatty! */

                   Tabla[i][TJ[i]-1]=L; // Megl�pj�k a l�p�st az adminisztr�ci�s t�bl�n is.
                   fl_deactivate_object(rubrika[i][TJ[i]-1]); // Leszerelj�k a m�r
		   					      // "leszerepelt" mez�t.
                   if (TJ[i]>1) fl_activate_object(rubrika[i][TJ[i]-2]);
                   else +telioszlopok;  // Ha van m�g az aktu�lis oszlopban �res rubrika,
		   			// azt akt�vv� tessz�k, ha nincs, n�velj�k a
					// teli oszlopok sz�m�t.
                   utolsolepes=i; // j� lesz tudni k�s�bb
                   L=3-L; // a m�sik j�t�kos j�n

                   --(TJ[i]); // az adminisztr�ci�s oszlop magass�g�t n�velj�k
                   } // ciklus v�ge (for)
  } while ((CS_HanyVanNeki(4,3-L)==0)&&(telioszlopok<10)); // Gy�zelem? D�ntetlen?
  
  if (telioszlopok==10)
  {
   fl_set_object_label(uzenet,"D�ntetlen!");
   if (MUZIK==1) fwrite(dontetlen,1,32768,r);
   }
  else 
  {
   sprintf(buf,"%s nyert!",J[2-L]);
   fl_set_object_label(uzenet,buf);
   fl_check_forms();
   fl_msleep(500);
   if (MUZIK==1) fwrite(nevetes,1,32768,r);
   }
   XFlush(fl_get_display());
   fl_msleep(10000);

  /* do {} while (1); */
  fl_hide_form(form);
  if (MUZIK==1) fclose(r);
  } /* !!! id�ig tart a nagy forg�s !!! */

  while (1);

  return 0;
}
