
//sta funzione serve per comodità, cosi posso segnare bene i cooldown riferendomi al clock e segno anche quando è stato il frame precedente che serve per il volo
void clock() {
  clock=millis();
  tempoDelta = millis() - tempoUltimoFrame;
  tempoUltimoFrame = millis();
}
