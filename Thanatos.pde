void Thanatos() {
  int ultimoMovimento=0;
  int delay=250;
  int ThanSpeed=5;


  float dx = playerpos.x - ThanPos.x;
  float dy = playerpos.y - ThanPos.y;
  float dist = dist(playerpos.x, playerpos.y, ThanPos.x, ThanPos.y);

  if (clock - ultimoMovimento >= delay) {
    ThanPos.x += (dx/dist) * ThanSpeed;
    ThanPos.y += (dy/dist) * ThanSpeed;
    ultimoMovimento=clock;
  }
  rect(ThanPos.x, ThanPos.y, 100, 100);
}
