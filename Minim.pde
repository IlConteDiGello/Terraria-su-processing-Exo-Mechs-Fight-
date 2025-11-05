//questo file serve a caricare tutti i file di suono. che siano musica o effetti sonori

import ddf.minim.*;
//import la minim
Minim minim;


//inizializzo tutti gli audioplayer

AudioPlayer CausticTides;
AudioPlayer Summon;

void Minim() {  //funzione che carica tutti i suoni e le musiche
  minim = new Minim(this);

  CausticTides = minim.loadFile("musica/Caustic_Tides.mp3");
  Summon = minim.loadFile("Suoni/DraedonSpawn.mp3");
}
