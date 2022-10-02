/* Csõamõba -- központi file */
#define VERZIO 4
#define ALVERZIO 1
#include <stdio.h>
#include "forms.h" // maga a Forms Library
#include "X1.xpm"  // ikonok 8 soron át
#include "X2.xpm"
#include "X3.xpm"
#include "X4.xpm"
#include "O1.xpm"
#include "O2.xpm"
#include "O3.xpm"
#include "O4.xpm"
#include "ures.xpm"  // üres ikon
#include "tabla.xpm"  // táblakép
#include "uzenet.c"  // magyar nyelvû szöveggyûjtemény

int Tabla[10][10];
int TJ[10]; /* az egyes oszlopok férõhelyeinek száma */
int utolsolepes,telioszlopok=0;
char J[2][20]; /* játékosok neve */
int KETJATEKOS=0,GEP=1,L=1,MUZIK=2; /* ezt a main()-bõl tettük át */
FL_FORM *opsonsz_menu;
FL_OBJECT *gomb[7];
int g[7];

#include "3.4-es_verzio.c" // A 3.4-es verzió fontos rutinjai (stratégiák,
			   // táblaelemzõ rutinok) külön fájlban vannak.
#include "opsonsz.c" // Az Opsönsz menü is.
#include "cimoldal.c" // Sõt, a Címoldal is.

char pingpong[2][8192], nevetes[32768], dontetlen[32768]; // digitalizált hangok


void Hang(char *s)  // külsõ hangfájl lejátszása (csak példaként, nem használjuk)
{
   char buf[50];
   sprintf(buf,"cat %s >/dev/audio &",s);
   system(buf);    
  }

void Nevetes()      // Ezt sem használjuk.
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
	  
   // A gyakran lejátszandó hangokat a memóriából írjuk ki a /dev/audio-ra.

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

   // Létrehozzuk a játékablakot.
   fl_initialize(&argc, argv, "Csõamõba", 0, 0);
   Cimoldal();
   Opsonsz_inic();

   form = fl_bgn_form(FL_UP_BOX,375,479);    // fõdoboz
   tab = fl_add_pixmap(FL_NORMAL_PIXMAP,0,0,375,439,"");  // táblarajz
   uzenet = fl_add_box(FL_FLAT_BOX,0,439,375,41,""); // null-üzenet
   // Kitesszük az alsó üzenetdobozt.
   /* A 13 és 6 az eredeti színek. */
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
   fl_end_form(); // Vége a képernyõ kirajzolásának, pontosabban
  		 // néhány finomság beállítása még hátravan.

  fl_set_pixmap_data(tab,tabla);
 

 
 
  do { /* EZ MEGY KÖRBE-KÖRBE JÁTÉKONKÉNT */
  Opsonsz_aktiv();
  if (MUZIK==1) r=fopen("/dev/audio","w");
  
  // aktualizáljuk az új játékhoz a táblaképet
  if (KETJATEKOS || (GEP!=L)) // két játékos játszik vagy nem a gép kezd
   	sprintf(buf,"%s",M_JatekosKezd(J[L-1]));
     	else sprintf(buf,"%s",M_GepKezd());	  // kezdõ feliratok

   // A 100 négyzetet rajzoljuk ki.
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
     } // Mindig csak az oszlopok legalsó, még üres rubrikái aktívak.
       // Egyelõre viszont mind üres.
  #include "jatek_ablakcim_utf8.c"
  // fl_show_form(form,FL_PLACE_SIZE,FL_FULLBORDER,"Csõamõba");
  // Most tesszük ki a képernyõt.


/* Fõhurok */

  do
  {

   if (KETJATEKOS || (GEP!=L)) I=-1;
   else I=0;
     		// Jelezzük, hogy most nem a gép lép. (Ettõl a változótól függ
	  	// késõbb az, hogy a gép lépett-e vagy egy játékos, ez így
		// kényelmesebben kezelhetõ.)

 
  if (!kezdes)	/* a kezdõlépést már kezeltük korábban */
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
	  fl_check_forms(); // Ha ez nincs itt, az elõzõ lépéshez tartozó kurzor
	  		    // nem tûnik el. (A továbbiakban is használjuk ezt
			    // a fogást.)
	  fl_msleep(2500);
	  }

  v=random()%4;
  for (i=0; i<10; ++i)
     if (
     		(i==I)   /* a gép lépése esetén */
     		||
     		(((obj==rubrika[i][TJ[i]-1])&&(Tabla[i][TJ[i]-1]==0))) /* különben */

		)

                {
                   if (L==1) 
                   	switch(v) /* a megfelelõ rubrika ikonjainak átírása */
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
                                   break; /* négyféle ikonból választhatunk */
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
                                   break; /* itt is 4-féle lehetõség */
                                }

                   if (MUZIK==1) fwrite(pingpong[L-1],1,8192,r); /* Klatty! */

                   Tabla[i][TJ[i]-1]=L; // Meglépjük a lépést az adminisztrációs táblán is.
                   fl_deactivate_object(rubrika[i][TJ[i]-1]); // Leszereljük a már
		   					      // "leszerepelt" mezõt.
                   if (TJ[i]>1) fl_activate_object(rubrika[i][TJ[i]-2]);
                   else +telioszlopok;  // Ha van még az aktuális oszlopban üres rubrika,
		   			// azt aktívvá tesszük, ha nincs, növeljük a
					// teli oszlopok számát.
                   utolsolepes=i; // jó lesz tudni késõbb
                   L=3-L; // a másik játékos jön

                   --(TJ[i]); // az adminisztrációs oszlop magasságát növeljük
                   } // ciklus vége (for)
  } while ((CS_HanyVanNeki(4,3-L)==0)&&(telioszlopok<10)); // Gyõzelem? Döntetlen?
  
  if (telioszlopok==10)
  {
   fl_set_object_label(uzenet,"Döntetlen!");
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
  } /* !!! idáig tart a nagy forgás !!! */

  while (1);

  return 0;
}
