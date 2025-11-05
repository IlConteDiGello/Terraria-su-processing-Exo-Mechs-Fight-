
//questo file lo uso solo per dichiarare tutte le variabili globali

int stato=0;  //questa variabile viene dichiarato qui, ma serve per ogni file, per ora ne ho 2 di stati, lo stato 0 sarebbe il menu, e lo stato 1 avvia il gioco vero e proprio

int bordoXdestra=15000;
int bordoXsinistra=-15000;
int limiteY=-10000;

//variabili che gestiscono il giocatore

PVector playerpos = new PVector(width/2, 900);  //posizione del giocatore
PVector camerapos;  //posizione della telecamera
int HP=700;
float velocitay=0;  //questa è la velocità y, cioè la valocità verticale del giocatore
float velocitax=0;
int UltimoAumentoSpeed=0;
//questa variabile viene cambiata quando si vola, quando si salta e quando si cade per gravità
float gravità=1;  //valore della gravità, aumenta se si sta cadendo per troppo tempo
float aumentogravità=0.1;  //di quanto aumento la gravità ogni frame
float maxgravità=2;  //massimo valore della gravutà cosi non cade troppo veloce
boolean sinistra=false;  //movimento a sinistra
boolean destra=false;  //movimento a destra
boolean atterra=false;  //controlla se stai toccando la piattaforma sottostante

//variabili di dash

float dashspeed=20;  //questa è la velocità settata dal dash quando si avvia
int speed=10;    //la velocità normale del giocatore quando si muove e basta
int speedtimer=0;
//float dashcooldown=750;  //cooldown del dash cosi non si spamma
boolean dashando=false;  //controlla se sta dashando
int direzionedash=0;  //la direzione del dash, -1 sinistra 1 destra
int dashtime=15;  //quanto dura il dash
int dashtimer=0;  //contatore dei frame cosi il dash si ferma
boolean dashpronto=true;  //momento in cui inizia il dash che viene comparato al tempo corrente
int ultimodash=0;
boolean dashattivato=false;
boolean shiftpremuto=false;

//variabili gestioni volo

boolean involo=false;  //controlla se stai volando
int timervolo=0;  //questa viene usata per limitare il volo
int maxvolotime=5000;
float potenzavolo=-5;  //quanto viene settata la velocità y inizialmente
float accelerazionevolo=-0.5;  //quanto accellera ogni frame
float maxflightspeed=-15;  //massima velocità di volo
float iniziovolo=0;
boolean planando=false;
boolean spaziopremuto=false;

int ultimoTeletrasporto;


//variabili per l'attacco della spada

boolean attaccando=false;

float ypiattaforma=900;

int clock=0;
float tempoDelta=0;
float tempoUltimoFrame=0;



int altezzaCodeBreaker, larghezzaCodeBreaker;
boolean cliccatoCB=false;

boolean DraedonSpawnato=false;


int ultimoAumentoRage=0;
int valoreRage=0;

int adrenaline=0;
int CooldownTickAdrenaline=150;
int ultimoAumentoAdrenaline=0;

int ultimaRigenerazione=0;

//i 3 big boss

PVector ThanPos = new PVector (300, 300);
