/* opsonsz.c */

#include "opsonsz.xpm"

void Opsonsz_inic(void)
{
  FL_OBJECT *felirat,*obj;
  opsonsz_menu=fl_bgn_form(FL_NO_BOX, 330, 510);
     
  obj=fl_add_box(FL_FLAT_BOX,0,0,330,510,"");
    fl_set_object_color(obj,FL_WHITE,FL_MCOL);
  gomb[1] = obj = fl_add_choice(FL_NORMAL_CHOICE,100,130,130,20,"Kik játsszanak egymás ellen?");
    fl_addto_choice(obj,"Két emberi játékos");
    fl_addto_choice(obj,"Ember és számítógép");
    fl_set_object_shortcut(obj,"k",1);
    fl_set_object_boxtype(obj,FL_RFLAT_BOX);
    fl_set_object_color(obj,FL_INDIANRED,FL_RIGHT_BCOL);
    fl_set_object_lcol(obj,FL_BLACK);
    fl_set_object_lsize(obj,FL_MEDIUM_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);

  gomb[2] = obj = fl_add_choice(FL_NORMAL_CHOICE,100,180,130,20,"Kikezdjen (Rita Johnnyval)?");
    fl_addto_choice(obj,"Az X jelû játékos");
    fl_addto_choice(obj,"A O jelû játékos");
    fl_set_object_shortcut(obj,"z",1);
    fl_set_object_boxtype(obj,FL_RFLAT_BOX);
    fl_set_object_color(obj,FL_INDIANRED,FL_BLACK);
    fl_set_object_lcol(obj,FL_BLACK);
    fl_set_object_lsize(obj,FL_MEDIUM_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);

  gomb[3] = obj = fl_add_choice(FL_NORMAL_CHOICE,100,230,130,20,"Milyen jelû legyen a számítógép, ha játszik?");
    fl_addto_choice(obj,"X");
    fl_addto_choice(obj,"O");
    fl_set_object_shortcut(obj,"p",1);
    fl_set_object_boxtype(obj,FL_RFLAT_BOX);
    fl_set_object_color(obj,FL_INDIANRED,FL_BLACK);
    fl_set_object_lcol(obj,FL_BLACK);
    fl_set_object_lsize(obj,FL_MEDIUM_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);

  gomb[4] = obj = fl_add_choice(FL_NORMAL_CHOICE,100,280,130,20,"Legyen zenei aláfestés?");
    fl_addto_choice(obj,"Igen");
    fl_addto_choice(obj,"Inkább ne");
    fl_set_object_shortcut(obj,"a",1);
    fl_set_object_boxtype(obj,FL_RFLAT_BOX);
    fl_set_object_color(obj,FL_INDIANRED,FL_BLACK);
    fl_set_object_lcol(obj,FL_BLACK);
    fl_set_object_lsize(obj,FL_MEDIUM_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
  gomb[5] = obj = fl_add_choice(FL_NORMAL_CHOICE,100,330,130,20,"Kire szavaznál a választásokon?");
    fl_addto_choice(obj,"A kisgazdákra");
    fl_addto_choice(obj,"A kereszténydemokratákra");
    fl_addto_choice(obj,"A FIDESZ-re");
    fl_addto_choice(obj,"A szocialistákra");
    fl_addto_choice(obj,"A kapitalistákra");
    fl_addto_choice(obj,"Egyéb");
    fl_addto_choice(obj,"Nem szavaznék");
    fl_set_object_shortcut(obj,"s",1);
    fl_set_object_boxtype(obj,FL_RFLAT_BOX);
    fl_set_object_color(obj,FL_INDIANRED,FL_BLACK);
    fl_set_object_lcol(obj,FL_BLACK);
    fl_set_object_lsize(obj,FL_MEDIUM_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
  gomb[6] = obj = fl_add_slider(FL_HOR_NICE_SLIDER,110,380,110,30,"Milyen okos legyen a gép (ha játszik)?");
    fl_set_object_color(obj,FL_TOMATO,FL_INDIANRED);
    fl_set_object_lcol(obj,FL_BLACK);
    fl_set_object_lsize(obj,FL_MEDIUM_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_slider_value(obj, 0.61);
     fl_set_slider_return(obj, FL_RETURN_CHANGED);
  fl_add_box(FL_NO_BOX,225,380,40,30,"Polgár\nZsuzsa");
    fl_set_object_color(obj,FL_DARKGOLD,FL_DARKGOLD);
  fl_add_box(FL_NO_BOX,40,380,70,30,"Sehallselát\nDömötör");
    fl_set_object_color(obj,FL_DARKGOLD,FL_DARKGOLD);

  gomb[0] = obj = fl_add_button(FL_NORMAL_BUTTON,100,440,130,40,"Start gáme");
    fl_set_button_shortcut(obj,"l",1);
    fl_set_object_color(obj,FL_PALEGREEN,FL_GREEN);
    fl_set_object_lsize(obj,FL_LARGE_SIZE);
    fl_set_object_lstyle(obj,FL_BOLDITALIC_STYLE);
  felirat=fl_add_pixmap(FL_NORMAL_PIXMAP,70,2,200,100,"");


  fl_end_form(); /* lezárjuk az ablak definiálását */

  fl_set_pixmap_data(felirat,opsonsz_xpm); /* a feliratot feltesszük még */

  }

void Opsonsz_aktiv()
{

  int i;
  FL_OBJECT *obj;

  // fl_show_form(opsonsz_menu,FL_PLACE_MOUSE,FL_FULLBORDER,"Opsönsz");
  #include "opsonsz_ablakcim_utf8.c"

  do
  	{
  	 obj=fl_do_forms(); /* ciklus */
	}

  while (obj!=gomb[0]);

  for (i=1;i<6;++i)			/* a g[] tömbbe felvesszük a beállított opciókat */
  	g[i]=fl_get_choice(gomb[i]);
	/* a számozás 1-tõl van, nem 0-tól */

   
  if (g[1]==1) { KETJATEKOS=1; GEP=0; }
  /* a két gép még nem mûködik */

  L=g[2];

  if ((g[3]==1)&&(g[1]==2)) { GEP=1; KETJATEKOS=0; }
  if ((g[3]==2)&&(g[1]==2)) { GEP=2; KETJATEKOS=0; }

  MUZIK=g[4];
  

  /* a nehézségi fok sem mûködik */

  fl_hide_form(opsonsz_menu);

}
