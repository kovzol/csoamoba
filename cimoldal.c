/* cimoldal.c */


#include "CsAIkon.xpm"



void Cimoldal()
{
   FL_FORM *form;
   FL_OBJECT *gomb, *obj;
   int kozep;
   char killcommand[30],pids[30];
   FILE *psinfo;
  
  form = fl_bgn_form(FL_UP_BOX,400,150);
    kozep=103;
    obj=fl_add_box(FL_NO_BOX,kozep,20,280,12,"Csõamõba v4.1");
    fl_set_object_lsize(obj,FL_HUGE_SIZE);
    fl_set_object_lstyle(obj,FL_TIMESBOLDITALIC_STYLE);
    obj = fl_add_box(FL_NO_BOX,kozep,32,280,12,"Linux/XForms verzió");
    obj = fl_add_box(FL_NO_BOX,kozep,55,280,12,"Írták: Kovács Zoltán és Bíró Csaba");
    obj = fl_add_box(FL_NO_BOX,kozep,67,280,12,"Kovács Zsigmond alkotásainak illetve");
    obj = fl_add_box(FL_NO_BOX,kozep,79,280,12,"a T. C. Zhao és Mark Overmars-féle");
    obj = fl_add_box(FL_NO_BOX,kozep,91,280,12,"Forms Library felhasználásával.");
    gomb=fl_add_button(FL_NORMAL_BUTTON,kozep,108,280,25,"Hm, mit csinál ez a gomb?");
  
    obj=fl_add_pixmap(FL_NORMAL_PIXMAP,19,19,78,112,"");

  fl_end_form();

    fl_set_pixmap_data(obj,CsAIkon);

  // fl_show_form(form,FL_PLACE_MOUSE,FL_FULLBORDER,"Cs?am?ba");
  #include "cimoldal_ablakcim_utf8.c"
  system("s3mod zene.mod >/dev/null &");
  system("ps | grep s3mod >/tmp/psinfo &");
  fl_do_forms();
  
  psinfo=fopen("/tmp/psinfo","r");
  fscanf(psinfo,"%s",&pids);
  strcpy(killcommand,"kill ");
  strcat(killcommand,pids);
  system(killcommand);
  
  fl_hide_form(form); 
}

