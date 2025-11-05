//questa funzione serve per creare un menu iniziale invece di buttarti cosi nel gioco che è brutto

void menu() {
  if (stato==0) {  //se lo stato è uguale a 0 disegno il menu
    background(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    fill(0);
    text("Ho bisogno di aiuto psicologico", width/2, height/2);
    textSize(20);
    text("press ENTER to start", width/2, height/1.5);
    if (keyCode==ENTER)
      stato=1;
  }
}
