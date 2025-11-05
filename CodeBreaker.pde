//questo file disegna il CodebReaker che è l'oggetto su cui clicchi per summorare il boss ipergalattico

int ultimoClickCB = 0;  //ultimoclick del codebreaker
int clickCooldown = 100;  // millisecondi di cooldown (0.2 secondi)



void CodeBreaker() {



  int x = -1000;  //cordinata x (locale)
  altezzaCodeBreaker = CodeBreaker.height;
  int y = int(ypiattaforma) - altezzaCodeBreaker;

  pushMatrix();  //pusho la matrice
  translate(x, y);  //traslo
  image(CodeBreaker, 0, 0);
  popMatrix();  //poppo la matrice
  if (cliccatoCB && !DraedonSpawnato) mostraGuiCB();
  if (DraedonSpawnato) interazioneContatto();
}



void controllaclickCB() {
  int x = -1000;
  int y = int(ypiattaforma) - altezzaCodeBreaker;
  if (mouseButton == RIGHT && clock - ultimoClickCB > clickCooldown) {
    if (isMouseOverCodeBreaker(x, y)) {  //se il destro è premuto e il mouse è sul codebreaker
      cliccatoCB = !cliccatoCB;  //inverto la booleana cosi l'immagine non sfarfalla ogni frame
      ultimoClickCB=clock;
    }  //ultimo click viene segnato
  }
}



void mostraGuiCB() {  //disegno l'icona del contatto
  float x = playerpos.x - 30, y = playerpos.y - 100;
  image(Icona_Contatto, x, y);
  if (isMouseOverIconaContatto(x, y) && mousePressed && mouseButton == RIGHT) {
    DraedonSpawnato = true;
    cliccatoCB = false;
    stato=2;
  }
}

void interazioneContatto() {
  fill(0);
  rect(-1000, ypiattaforma - 300, 50, 50);

  disegnaIcone();
}

boolean isMouseOverCodeBreaker(int x, int y) {
  float mouseMondoX = mouseX + camerapos.x;  //posizione del mouse, calcolata sottraendo la poizione della telecamera
  float mouseMondoY = mouseY + camerapos.y;  //stessa cosa con la y
  float altezzaCodeBreaker = CodeBreaker.height;
  float larghezzaCodeBreaker = CodeBreaker.width;  //altezza e larghezza della sprite del codebreaker

  return mouseMondoX >= x &&  //controlo se le coordinate del mouse si overlappano con l'altezza e larghezza del codebreaker
    mouseMondoX <= x + larghezzaCodeBreaker &&
    mouseMondoY >= y &&
    mouseMondoY <= y + altezzaCodeBreaker;
}


boolean isMouseOverIconaContatto(float x, float y) {
  float mouseMondoX = mouseX + camerapos.x;  //posizione del mouse, calcolata sottraendo la poizione della telecamera
  float mouseMondoY = mouseY + camerapos.y;  //stessa cosa con la y
  float altezza = Icona_Contatto.height;
  float larghezza = Icona_Contatto.width;  //altezza e larghezza della sprite del codebreaker

  return mouseMondoX >= x &&  //controlo se le coordinate del mouse si overlappano con l'altezza e larghezza del codebreaker
    mouseMondoX <= x + larghezza &&
    mouseMondoY >= y &&
    mouseMondoY <= y + altezza;
}

void disegnaIcone() {
  fill(152, 252, 3);
  pushMatrix();
  rect(playerpos.x + 25, playerpos.y - 90, 20, 20);
  
  fill(252, 28, 3);
  rect(playerpos.x - 15, playerpos.y - 120, 20, 20);
  
  fill(3, 161, 252);
  rect(playerpos.x - 55, playerpos.y - 90, 20, 20);
  popMatrix();

}
