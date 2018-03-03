class jambGrid{
  
  // variables needed for the form
  int numRows;
  int numCols;
  int[][] jambResults;
  int deltaX;
  int deltaY;
  int startPointX;              // if you want to move the form a bit, just change startPointX and/or startPointY 
  int startPointY;
  int x;
  int y;
  
  PFont Font1;
  
  int player;
  // 
  
  jambGrid(int _player, int _numRows, int _numCols, int _deltaX, int _deltaY, int _startPointX, int _startPointY){
    player = _player;
    numRows = _numRows;
    numCols = _numCols;
    jambResults = new int[numRows - 1][numCols - 1];
    deltaX = _deltaX;
    deltaY = _deltaY;
    startPointX = _startPointX;
    startPointY = _startPointY;
    x = _startPointX;
    y = _startPointY;
    Font1 = createFont("Arial Bold", 15);
  }
  
  // ---------- drawing the form ----------
  void drawGrid(){
  fill(0, 0, 0);
  //draw columns
  stroke(0);
  for(int i = 0; i <= numCols; ++i){
    if(i == 0 || i == 1 || i == numCols){
      strokeWeight(3);
    }
    else{
      strokeWeight(1);
    }
    line(x, y, x, y + (numRows * deltaY));
    x += deltaX;
  }
  x = startPointX;
  //draw rows
  for(int i = 0; i <= numRows; ++i){
    // for bolded rows
    if(i == 0 || i == 1 || i == 7 || i == 8 || i == 10 || i == 11 || i == numRows - 1 || i == numRows){
      strokeWeight(3);
    }
    else{
      strokeWeight(1);
    }
    line(x, y, x + (numCols * deltaX), y);
    y += deltaY;
  }
  y = startPointY;
  
  // putting text to the first column
  textFont(Font1);
  text("Player " + str(player + 1), x + 7, y + 20);
  for(int i = 1; i <= 6; ++i){
    text(str(i), x + 25, y + (deltaY *i) + 20);
  }
  text("Ukupno", x + 7, y + (deltaY * 7) + 20);
  text("Max", x + 20, y + (deltaY * 8) + 20);
  text("Min", x + 20, y + (deltaY * 9) + 20);
  text("Ukupno", x + 7, y + (deltaY * 10) + 20);
  text("Tris", x + 20, y + (deltaY * 11) + 20);
  text("Skala", x + 20, y + (deltaY *12) + 20);
  text("Full", x + 20, y + (deltaY *13) + 20);
  text("Poker", x + 20, y + (deltaY *14) + 20);
  text("Jamb", x + 20, y + (deltaY *15) + 20);
  text("Ukupno", x + 7, y + (deltaY *16) + 20);
  
  // drawing margin fields for the sums
  drawSumField(x + deltaX * numCols, y + deltaY * 7, false);
  drawSumField(x + deltaX * numCols, y + deltaY * 10, false);
  drawSumField(x + deltaX * numCols, y + deltaY * 16, false);
  
  // drawing total sum field
  drawSumField(x + deltaX * numCols, y + deltaY * numRows, true);
  
  // putting triangles to the first row to show the required direction
  noFill();
  strokeWeight(1);
  triangle(x + deltaX + 35, y + 10, x + deltaX + 30, y + 20, x + deltaX + 40, y + 20);
  triangle(x + deltaX*2 + 30, y + 10, x + deltaX*2 + 40, y + 10, x + deltaX*2 + 35, y + 20);
  triangle(x + deltaX*3 + 20, y + 10, x + deltaX*3 + 15, y + 20, x + deltaX*3 + 25, y + 20);
  triangle(x + deltaX*3 + 30, y + 10, x + deltaX*3 + 40, y + 10, x + deltaX*3 + 35, y + 20);
  
  showPlayers();
  }
  // ---------- end of the form drawing ----------
  
  public void drawSumField(int startX, int startY, boolean total){
    strokeWeight(3);
    line(startX, startY, startX + deltaX, startY);
    line(startX, startY + deltaY, startX + deltaX, startY + deltaY);
    line(startX + deltaX, startY, startX + deltaX, startY + deltaY);
    
    if(total){
      line(startX, startY, startX, startY + deltaY);
    }
  }
  
  public boolean check(){
    if((mouseX > startPointX + deltaX && mouseX < startPointX + deltaX*numCols) && (mouseY > startPointY + deltaY && mouseY < startPointY + deltaY*numRows)){
      println("Writing into form");
      int column = (mouseX - deltaX - startPointX)/deltaX;
      int row = (mouseY - deltaY - startPointY)/deltaY;
      println("field: " + str(row) + " " + str(column));
      return true;
    }
    else{
      println("not in the form");
      return false;
    }
  }
  
  void showPlayers() {
  textAlign(LEFT);
  text("Popis igraca:", 3*width/4,30);
  
  for(int i = 0; i < brIgraca; i++)
  {
    String item = ids.get(i);
    textAlign(LEFT);
    text(item, 3*width/4,30+(i+1)*20);
  }
  
  textAlign(LEFT);
  text("Trenutno na potezu:", 3*width/4,230);
  String currentPlayer = players.get(playerOnTurnIndex);
  textAlign(LEFT);
  text(currentPlayer, 3*width/4,250);
}
  
}