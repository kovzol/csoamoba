/* cimoldal.c */


#include "CsAIkon.xpm"



void Cimoldal()
{
   FL_FORM *form;
   FL_OBJECT *gomb, *obj;
   int kozep;
   char killcommand[30],pids[30];
   FILE *psinfo;
  
  form = fl_bgn_form(FL_UP_BOX,320,150);
/*    fl_set_object_color(form,FL_YELLOW,FL_BLUE); */
    kozep=(320-116)/2+103;
    obj=fl_add_box(FL_NO_BOX,kozep,27,0,0,"Cs�am�ba v4.1");
    fl_set_object_lsize(obj,FL_HUGE_SIZE);
    fl_set_object_lstyle(obj,FL_TIMESBOLDITALIC_STYLE);
    obj = fl_add_box(FL_NO_BOX,kozep,42,0,0,"Linux/XForms verzi�");
    obj = fl_add_box(FL_NO_BOX,kozep,60,0,0,"�rt�k: Kov�cs Zolt�n �s B�r� Csaba");
    obj = fl_add_box(FL_NO_BOX,kozep,71,0,0,"Kov�cs Zsigmond alkot�sainak illetve");
    obj = fl_add_box(FL_NO_BOX,kozep,82,0,0,"a T. C. Zhao �s Mark Overmars-f�le");
    obj = fl_add_box(FL_NO_BOX,kozep,93,0,0,"Forms Library felhaszn�l�s�val.");
    gomb=fl_add_button(FL_NORMAL_BUTTON,kozep-75,108,150,25,"Hm, mit csin�l ez a gomb?");
  
    obj=fl_add_pixmap(FL_NORMAL_PIXMAP,19,19,78,112,"");

  fl_end_form();

    fl_set_pixmap_data(obj,CsAIkon);

  fl_show_form(form,FL_PLACE_MOUSE,FL_FULLBORDER,"Cs�am�ba");
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

