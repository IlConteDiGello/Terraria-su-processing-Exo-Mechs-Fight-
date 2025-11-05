//questo file lo uso per il setup e il draw

void setup() {
  //size(1500, 1000);
  fullScreen();
  frameRate(60);
  Carica_Immagini();
  Minim();
  //CausticTides.loop();
}

// DRAW
void draw() {
  clock();
  if (atterra)
    timervolo=0;
  switch(stato) {
  case 0:
    menu();
    break;
  case 1:
    {
      background (89, 215, 235);
      camerapos = new PVector(playerpos.x - width/2, playerpos.y - 750);

      pushMatrix();

      translate(-camerapos.x, -camerapos.y);

      mondo();

      CodeBreaker();

      updateplayer();

      popMatrix();

      break;
    }
  case 2:
    {
      background (89, 215, 235);
      camerapos = new PVector(playerpos.x - width/2, playerpos.y - 750);

      pushMatrix();

      translate(-camerapos.x, -camerapos.y);

      mondo();

      CodeBreaker();

      updateplayer();
      
      Thanatos();

      popMatrix();

      break;
    }
  }
}
