//questo file serve a disegnare la piattaforma su cui cammini


void mondo() {  //disegno il mondo

  image(piattaformaLegno, 100, 50);
  int x=-12750;
  float colore=1;
  for (int i=0; i<255; i++) {
    fill(colore);
    colore+=1;
    rect(x, 900, 100, 20);
    x+=100;
  }

  x=0;
  int y=900;
  colore=255;
  for (int i=0; i<255; i++) {
    fill(colore);
    rect(x, y, 100, 20);
    y-=20;
    colore--;
  }
}
