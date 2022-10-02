/* uzenet.c 

A Cs�am�ba egy darabja. A jatek.c f�jlhoz kapcsol�dik, a magyar nyelv�
feliratokat az �ttekinthet�s�g miatt k�l�n tartjuk. El�g k�nnyen �s
rugalmasan b�v�thet�. */

char szoveg[40];		// statikus �tmeneti sz�vegt�r

char *
M_JatekosKezd (char *t)		/* bemenet: j�t�kos neve, kimenet: teljes �zenet */
{
  char s[20];
  int szam = random () % 4;
  strcpy (szoveg, t);
  switch (szam)
    {
    case (0):
      strcpy (s, " kezd.");
      break;
    case (1):
      strcpy (s, " l�p el�sz�r.");
      break;
    case (2):
      strcpy (s, ", te kezdesz!");
      break;
    case (3):
      strcpy (s, ", te l�psz el�sz�r.");
      break;
    }
  strcat (szoveg, s);
  return szoveg;
}

char *
M_GepKezd ()			/* kimenet: a g�p kezd�s�nek egy lehets�ges �zenete */
{
  int szam = random () % 3;
  switch (szam)
    {
    case (0):
      strcpy (szoveg, "No, �n kezdek.");
      break;
    case (1):
      strcpy (szoveg, "�n l�pek el�sz�r.");
      break;
    case (2):
      strcpy (szoveg, "�n kezdek.");
      break;
    }
  return szoveg;
}

char *
M_GepLep (signed int szam)
/* bemenet: -10-t�l 10-ig az �ll�s j�s�ga a g�p szemsz�g�b�l,
   kimenet: ehhez kapcsol�d� �zenet */
{
  szam += (random () % 5 - 2);
  if (szam > 10)
    szam = 10;
  if (szam < -10)
    szam = -10;
  switch (szam)
    {
    case (0):
      strcpy (szoveg, "V�rj, gondolkozom.");
      break;
    case (1):
      strcpy (szoveg, "Egy pillanat.");
      break;
    case (2):
      strcpy (szoveg, "Azonnal l�pek, pillanat!");
      break;
    case (3):
      strcpy (szoveg, "V�rj csak, mindj�rt l�pek!");
      break;
    case (4):
      strcpy (szoveg, "Kicsit gondolkozom, azt�n te vagy.");
      break;
    case (5):
      strcpy (szoveg, "M�sodperc fejt�r�s, azt�n te vagy.");
      break;
    case (6):
      strcpy (szoveg, "L�pek a l�val, azt�n te j�ssz.");
      break;
    case (7):
      strcpy (szoveg, "N�' m�n, mingy�r matt!");
      break;
    case (8):
      strcpy (szoveg, "Sakk, �csi!");
      break;
    case (9):
      strcpy (szoveg, "Nincs es�lyed, haver!");
      break;
    case (10):
      strcpy (szoveg, "V�ged van, bar�tom!");
      break;

    case (-1):
      strcpy (szoveg, "V�rj, gondolkozom egy kicsit.");
      break;
    case (-2):
      strcpy (szoveg, "Hm. Egy pillanat, gondolkozom.");
      break;
    case (-3):
      strcpy (szoveg, "Hm, hm. Egy pillanat.");
      break;
    case (-4):
      strcpy (szoveg, "Hm...");
      break;
    case (-5):
      strcpy (szoveg, "El�g j�l �llsz. No v�rj csak!");
      break;
    case (-6):
      strcpy (szoveg, "�csi, bar�tom, nem err�l volt sz�!");
      break;
    case (-7):
      strcpy (szoveg, "Ne h�zd ki a gyuf�t, bar�tom!");
      break;
    case (-8):
      strcpy (szoveg, "Ne csalj�l, haver!");
      break;
    case (-9):
      strcpy (szoveg, "Form�zzam a vincsit?");
      break;
    case (-10):
      strcpy (szoveg, "Feladom. Na j�, nem...");
      break;

    }
  return szoveg;
}

char *
M_JatekosLep (char *t)		/* Info: l�sd fent! */
{
  char s[20];
  int szam = random () % 6;
  strcpy (szoveg, t);
  switch (szam)
    {
    case (0):
      strcpy (s, " l�p.");
      break;
    case (1):
      strcpy (s, " k�vetkezik.");
      break;
    case (2):
      strcpy (s, " j�n.");
      break;
    case (3):
      strcpy (s, ", te l�psz!");
      break;
    case (4):
      strcpy (s, ", te k�vetkezel.");
      break;
    case (5):
      strcpy (s, ", te j�ssz!");
      break;
    }
  strcat (szoveg, s);
  return szoveg;
}
