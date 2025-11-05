/*
    Questo file è dedicato alla gestione del movimento e delle meccaniche del giocatore
 Parlo del movimento generale, del Volo, della gravità sul giocatore e del dash.
 
 */

//gestione input

void updateplayer() {
  fill(255, 0, 0);

  ellipse(playerpos.x, playerpos.y - 15, 30, 30);  //aggiorno la posizione x ed y

  controlloBordo();

  volo();

  dash();

  movimento();

  teletrasporto();

  attaccoMurasama();

  rigenerazione();

  ControlloRageAdrenaline();
}

void controlloBordo() {
  if (playerpos.x >= bordoXdestra) playerpos.x = bordoXdestra-1;
  if (playerpos.x <= bordoXsinistra) playerpos.x = bordoXsinistra+1;
  if (playerpos.y <= limiteY) playerpos.y = limiteY;
}
void keyPressed() {

  switch(keyCode) {
  case 65:          //attivo le booleane di movimento a destra e sinistra
    sinistra=true;
    //dashattivato=false;
    break;
  case 68:
    destra=true;
    //dashattivato=false;
    break;
  case ' ':
    spaziopremuto=true;  //questo serve per la planata
    if (!involo && timervolo <= maxvolotime) {  //se non sei in volo e il tempo non è finito
      involo = true;
      //println("involo=true");
      gravità=1;  //resetto la gravità
      velocitay=potenzavolo;  //do una spinta iniziale poi aumento periodicamente
    } else planando=false;
    break;
  case SHIFT:
    shiftpremuto=true;  //serve per non fari ripetere il dash se continui a camminare (ma lo fa ripetere tenendo premuto shift)
  }
}


//Pulsanti rilasciati


void keyReleased() {
  switch(keyCode) {
  case 65:
    sinistra=false;  //false le booleane se rilascio cosi smette di muoversi
    break;
  case 68:
    destra=false;
    break;
  case ' ':
    involo=false;  //falso involo e anche la booleana dello spazio cosi smette di planare
    spaziopremuto=false;
    break;
  case SHIFT:
    shiftpremuto=false;  //shift non è premuto quindi rimane falso
    break;
  }
}


//Funzione per aggiornare il giocatore (volo e dash)




void movimento() {

  int velMax=17, velMin=-17;

  playerpos.x+=velocitax;

  //println("velocitax: " + velocitax);
  if (sinistra && clock - UltimoAumentoSpeed >= 50 && velocitax >= velMin)
  {
    if (velocitax>=0) velocitax-=3;
    else velocitax--;
    UltimoAumentoSpeed=clock;
  }

  if (destra && clock - UltimoAumentoSpeed >= 50 && velocitax <= velMax)
  {
    if (velocitax<=0) velocitax+=3;
    else velocitax++;
    UltimoAumentoSpeed=clock;
  }

  if (!sinistra && !destra && clock - UltimoAumentoSpeed >= 50 && velocitax!=0)
  {
    if (velocitax <= 0) velocitax++;
    else if (velocitax >= 0) velocitax--;
  }
}

float dashoffset;

void dash() {

  //cooldown del dash maremma maiala, qua succede troppa roba strana

  int dashcooldown=750;
  aumentadashcooldowntimer(dashcooldown);  //lo setto a millis cosi da poter compararalo all'ultimo dash
  //if(keyPressed && keyCode==SHIFT){  //se premo shift
  if (!dashattivato && dashpronto && shiftpremuto) {  //se il dash non è stato attivato ed è passato il cooldown
    if (sinistra) dasha(-1);   //direzione dash -1 cioè sinistra
    if (destra) dasha(1);  //destra
    dashpronto=false;
    ultimodash=clock;
    dashattivato=true;
    dashoffset = (dashspeed + speed) * -direzionedash;
  }  //resetto le variabile per vedere se il dash è pronto, segno il tempo dell'ultimo scatto e segno che il dash è stato attivato

  if (dashpronto && dashattivato)  //se è pronto ma è stato attivato
    dashattivato=false;

  if (dashando) {  //questo serve per il movimento vero a proprio
    playerpos.x += direzionedash * dashspeed;
    dashtimer--;
  }  //ogni frame decremento il timer cosi a un certo punto smette

  if (dashtimer < 0) {  //se è minore di 0 il dash è finito
    dashando=false;
    direzionedash=0;
  }  //resetto la direzione del dash
}
void dasha(int i) {  //prendo la direzione in input
  dashando=true;
  direzionedash=i;
  dashtimer=dashtime;  //il timer viene assegnato alla durata del dash
  velocitax=16*i;  //la velocità viene settata a 15 cosi che quando finisce il dash sembra che tiene momentum e non si ferma di colpo se hai velocità minore di 15
}

int ultimaAccelerazioneVolo=0;

void volo() {
  //println("TimerVolo: " + timervolo);
  if (involo) {  //se stai volando (premuto e tenuto premuto spazio)
    if (timervolo == 0) {
      // Se il volo appena inizia, imposta la velocità iniziale
      velocitay = potenzavolo;
    } else {
      // Durante il volo, aumenta gradualmente la velocità (più negativa) fino al limite
      if (velocitay >= maxflightspeed && clock - ultimaAccelerazioneVolo >= 100) {
        velocitay += accelerazionevolo;
        ultimaAccelerazioneVolo=clock;
      }
    }

    timervolo+=tempoDelta;
    if (timervolo >= maxvolotime)
      involo=false;
  } else {
    // Quando non si vola, applica la gravità per far accelerare la caduta
    if (velocitay < 10 || gravità < maxgravità) {
      velocitay += gravità;
    }
  }
  //println("gravità: " + gravità);
  println("Vy " + velocitay);
  if (gravità<=maxgravità && !involo)
    gravità+=aumentogravità;  //aumento gradualmente la gravità cosi sembra che raggiunga velocità terminale
  playerpos.y += velocitay;



  if (playerpos.y >= ypiattaforma && !involo) {  //se sono sulla piattaforma
    playerpos.y = ypiattaforma;
    velocitay = 0;  //resetto la velocità asse y
    atterra = true;  //segno che è a terra
    timervolo=0;  //resetto il timer del volo cosi si può volare di nuovo
    gravità=1;
  }  //resetto la gravità
  else {
    atterra = false; //altrimenti non sei a terra
  }

  if (!involo && timervolo > maxvolotime && !atterra && spaziopremuto && !planando)  //se ste condizioni son vere
    planando=true;  //plana
  else planando=false;  //altrimenti no

  if (planando)
    velocitay=1;  //semplicemente setto la velocità a 1 cosi scende più lentamente
}

void aumentadashcooldowntimer(int dashcooldown) {  //questo serve a segnare se il dash è pronto per essere avviato e quindi se è passato il cooldown
  if (clock - ultimodash >= dashcooldown)  //se è passato il cooldown
    dashpronto=true;  //il dash è pronto
  //println(dashcooldowntimer);
}



void attaccoMurasama() {
  if (mousePressed && mouseButton == LEFT) {
    attaccando = true;

    if (attaccando) {
      // Punto di partenza: il giocatore
      float offsetY = -15; // negativo = più in alto, positivo = più in basso
      float offsetX=0;
      if (!dashando) offsetX += -velocitax;
      /*if (dashando){
       offsetX = dashspeed; if(sinistra) offsetX += speed; if(destra) offsetX = -dashspeed - speed;}*/
      if (dashando) offsetX = dashoffset;
      if (involo) offsetY -= potenzavolo;
      //if (!atterra && planando) offsetY -= 5;  // valore fisso stabile
      //else if (!involo && !atterra) offsetY -= velocitay;
      else if (!atterra && !involo) offsetY -=velocitay;
      if (planando) offsetY -= 1;
      PVector playerCenter = new PVector(playerpos.x + offsetX, playerpos.y + offsetY);


      // Direzione: dal giocatore al mouse
      PVector mouse = new PVector(mouseX + camerapos.x, mouseY + camerapos.y); // se usi camera
      PVector dir = PVector.sub(mouse, playerCenter);

      dir.normalize();      // rende il vettore di lunghezza 1
      dir.mult(60);         // allunga il vettore (lunghezza del colpo)

      PVector attaccoFine = PVector.add(playerCenter, dir); // punto di arrivo

      pushStyle();
      stroke(255, 0, 0);     // colore rosso
      strokeWeight(4);       // spessore 4
      line(playerCenter.x, playerCenter.y, attaccoFine.x, attaccoFine.y);
      popStyle();
    }
  }
}

void ControlloRageAdrenaline() {
  if (DraedonSpawnato) {
    AumentaRabbia();
    AumentaAdrenaline();
  }
}

void AumentaRabbia() {
  int CooldownTickRage=250;
  if (clock - ultimoAumentoRage >= CooldownTickRage) {
    valoreRage+=1;
    ultimoAumentoRage=clock;
    //println("rabbia: " + valoreRage);
  }
}

void AumentaAdrenaline() {
  int CooldownTickAdrenaline=150;
  if (clock - ultimoAumentoAdrenaline >= CooldownTickAdrenaline) {
    adrenaline+=1;
    ultimoAumentoAdrenaline=clock;
    //println("adrenaline: "+adrenaline);
  }
}

void teletrasporto() {
  int cooldownTeletrasporto=3000;
  if (mousePressed && mouseButton == CENTER) {
    if (clock - ultimoTeletrasporto >= cooldownTeletrasporto) {
      playerpos.x=mouseX + camerapos.x;
      playerpos.y=mouseY + camerapos.y;
      ultimoTeletrasporto=clock;
    }
  }
}

void rigenerazione() {
  if (HP<700 && (clock - ultimaRigenerazione) >= 200) {
    HP++;
    ultimaRigenerazione=clock;
  }
  //println("HP: "+HP);
}
