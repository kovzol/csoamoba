/* uzenet.c 

A Csõamõba egy darabja. A jatek.c fájlhoz kapcsolódik, a magyar nyelvû
feliratokat az áttekinthetõség miatt külön tartjuk. Elég könnyen és
rugalmasan bõvíthetõ. */

char szoveg[40];		// statikus átmeneti szövegtár

char *
M_JatekosKezd (char *t)		/* bemenet: játékos neve, kimenet: teljes üzenet */
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
      strcpy (s, " lép elõször.");
      break;
    case (2):
      strcpy (s, ", te kezdesz!");
      break;
    case (3):
      strcpy (s, ", te lépsz elõször.");
      break;
    }
  strcat (szoveg, s);
  return szoveg;
}

char *
M_GepKezd ()			/* kimenet: a gép kezdésének egy lehetséges üzenete */
{
  int szam = random () % 3;
  switch (szam)
    {
    case (0):
      strcpy (szoveg, "No, én kezdek.");
      break;
    case (1):
      strcpy (szoveg, "Én lépek elõször.");
      break;
    case (2):
      strcpy (szoveg, "Én kezdek.");
      break;
    }
  return szoveg;
}

char *
M_GepLep (signed int szam)
/* bemenet: -10-tõl 10-ig az állás jósága a gép szemszögébõl,
   kimenet: ehhez kapcsolódó üzenet */
{
  szam += (random () % 5 - 2);
  if (szam > 10)
    szam = 10;
  if (szam < -10)
    szam = -10;
  switch (szam)
    {
    case (0):
      strcpy (szoveg, "Várj, gondolkozom.");
      break;
    case (1):
      strcpy (szoveg, "Egy pillanat.");
      break;
    case (2):
      strcpy (szoveg, "Azonnal lépek, pillanat!");
      break;
    case (3):
      strcpy (szoveg, "Várj csak, mindjárt lépek!");
      break;
    case (4):
      strcpy (szoveg, "Kicsit gondolkozom, aztán te vagy.");
      break;
    case (5):
      strcpy (szoveg, "Másodperc fejtörés, aztán te vagy.");
      break;
    case (6):
      strcpy (szoveg, "Lépek a lóval, aztán te jössz.");
      break;
    case (7):
      strcpy (szoveg, "Né' mán, mingyár matt!");
      break;
    case (8):
      strcpy (szoveg, "Sakk, öcsi!");
      break;
    case (9):
      strcpy (szoveg, "Nincs esélyed, haver!");
      break;
    case (10):
      strcpy (szoveg, "Véged van, barátom!");
      break;

    case (-1):
      strcpy (szoveg, "Várj, gondolkozom egy kicsit.");
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
      strcpy (szoveg, "Elég jól állsz. No várj csak!");
      break;
    case (-6):
      strcpy (szoveg, "Ácsi, barátom, nem errõl volt szó!");
      break;
    case (-7):
      strcpy (szoveg, "Ne húzd ki a gyufát, barátom!");
      break;
    case (-8):
      strcpy (szoveg, "Ne csaljál, haver!");
      break;
    case (-9):
      strcpy (szoveg, "Formázzam a vincsit?");
      break;
    case (-10):
      strcpy (szoveg, "Feladom. Na jó, nem...");
      break;

    }
  return szoveg;
}

char *
M_JatekosLep (char *t)		/* Info: lásd fent! */
{
  char s[20];
  int szam = random () % 6;
  strcpy (szoveg, t);
  switch (szam)
    {
    case (0):
      strcpy (s, " lép.");
      break;
    case (1):
      strcpy (s, " következik.");
      break;
    case (2):
      strcpy (s, " jön.");
      break;
    case (3):
      strcpy (s, ", te lépsz!");
      break;
    case (4):
      strcpy (s, ", te következel.");
      break;
    case (5):
      strcpy (s, ", te jössz!");
      break;
    }
  strcat (szoveg, s);
  return szoveg;
}
