class Game
{
  final int numSides = 6;
  final int numDice = 5;
  int numPlayers;
  StringList playersName;
  int playerOnTurnIndex;
  int rollingLeft;
  float dieSize;
  String playerOnTurn;
  int playerOnGridShown;
  Die[] dice;
  jambGrid[] gameInfo;
  int[] currentResult = {0,0,0,0,0,0};
  emptyDie[] emptyDice = new emptyDie[numDice];
  boolean nacrtano;
  boolean gameOver;
  String winner;
  
  int maxMoves;
  int movesPlayed;
  
  //konstruktor, postavlja početno stanje igre
  Game(int _numPlayers, StringList _playersName)
  {
    numPlayers = _numPlayers;
    playersName = _playersName;
    playerOnTurnIndex = 0;
    rollingLeft = 3;
    gameInfo = new jambGrid[numPlayers];
    dice = new Die[numDice];
    dieSize = ((float)width/numDice)*0.5;
    playerOnGridShown = 0;
    gameOver = false;
    
    
    //inicijaliziramo 5 kocaka
    float dieY = 10;
    for(int i=0; i<numDice; i++)
    {
      dice[i] = new Die(i+1, 20, dieY, dieSize);
      dieY = dieY+10+dieSize;
    }
    
    playerOnTurn = playersName.get(0);
    
    float dieYEmpty = 10;
    for(int i=0; i<5; i++)
    {
      emptyDice[i] = new emptyDie(20, dieYEmpty, dieSize);
      dieYEmpty = dieYEmpty+10+dieSize;
    }
    
    for(int i=0;i<numPlayers;i++)
    {
      gameInfo[i] = new jambGrid(playersName.get(i), i, 17, 4, 70, 30, 130, 10);
    }
    
    nacrtano = false;
    // change if a new row or column is added
    maxMoves = 39;
    movesPlayed = 0;
  }
  
  // method to check the result
  void checkCurrentResult(){
    restoreResult();
    for(int i = 0; i < numDice; ++i){
      int dieResult = dice[i].dieNumber;
      currentResult[dieResult - 1] += 1;
    }
  }

  // method to reset the result to zero when changing player on turn
  void restoreResult(){
    for(int i = 0; i < 6; ++i){
      currentResult[i] = 0;
    }
  }

  
  void printNumberOfRollingsLeft()
  {
   text("Imaš još " + rollingLeft + " pokušaja.", 630,350);
  }
  
  void printUsedDices(){
   text("Kockice koje bacaš:", 20, 550);
   int j = 1;
   for(int i = 0; i < 5; i++)
   {
     if(dice[i].DieRolls())
     {
       text(str(i), 20, 550+20*j);
       j++;
     }
       
   }
   
   j = 1;
   fill(255,0,0);
   text("Odvojene kockice:", 200, 550);
   for(int i = 0; i < 5; i++)
   {
    if(!dice[i].DieRolls())
    {
      text(str(i), 200, 550+20*j);
      j++;
    }
   }   
 }
 
   void checkPressedKey(int key) {
     if(key == 'A' || key == 'a'){
        if(rollingLeft > 0){
          for(int i=0;i<5;i++)
          {
            dice[i].RollTheDie();
            println(dice[i].dieNumber);
          }
          rollingLeft -= 1;
          
        }
    }
  }
  
  void checkOnClick()
  {
    
        println(str(mouseX) + " " + str(mouseY));
  
         for(int i = 0; i<5;i++)
         {    
              if(dice[i].IsInsideDie(mouseX,mouseY))
              {  
                 dice[i].ChangeRollingDieProperty();
              }
         }
         // update results before sending it to the form
         checkCurrentResult();
         if(rollingLeft < 3){
           if(gameInfo[playerOnTurnIndex].check(currentResult)){
             movesPlayed += 1;
             println("movesPlayed: " + movesPlayed);
             if(movesPlayed == maxMoves * numPlayers){
               gameOver = true;
               winner = playerOnTurn;
               println("game over");
             }
             if(playerOnTurnIndex == numPlayers - 1){
               playerOnTurnIndex = 0;
             }
             else{
               playerOnTurnIndex += 1;
             }
             
             for(int i = 0; i < 6; i++)
             { println("imamo " + currentResult[i] + " kocaka broj " + (i+1));
             }
             //println("Rez je : " + rezultat);
             // novi igrač, vrati sve na početno 
             rollingLeft = 3;
             
             for(int i = 0; i < numDice; i++)
             { 
               currentResult[i] = 0;
               //rollingDice[i] = 1;
               if(!dice[i].DieRolls())
               {
                 dice[i].ChangeRollingDieProperty();
               }
             }
             currentResult[5] = 0;
           return;
           }
         }
  }
  
  void stopDrawing(int ms){
    noLoop();
    try{
    Thread.sleep(ms);
    playerOnGridShown = playerOnTurnIndex;
    nacrtano = false;
    loop();
    playerOnGridShown = playerOnTurnIndex;
    }
    catch(Exception e){}
  }
  
  void DrawGame()
  {
    if(!gameOver)
    {
    background(51, 153, 255);
    if(playerOnTurnIndex != playerOnGridShown && nacrtano){
      stopDrawing(2000);
    }
    if(playerOnTurnIndex != playerOnGridShown && !nacrtano){
      gameInfo[playerOnGridShown].drawGrid();
      showPlayers();
      nacrtano = true;
    }
    
    if(rollingLeft < 3){
      for ( int d = 0; d < numDice; d++) {
        dice[d].DrawDie();
      }
    }
    else{
      for(int d=0; d < numDice; d++)
      {
        emptyDice[d].DrawEmptyDie();
      }  
    }
    if(playerOnTurnIndex == playerOnGridShown){
      gameInfo[playerOnTurnIndex].drawGrid();
    }
    /*else{
      gameInfo[playerGridShown].drawGrid();
      playerGridShown = playerOnTurnIndex;
    }
    printUsedDices();*/
    printNumberOfRollingsLeft();
    }
    else
    {
      background(51, 153, 255);
      Drawer dr = new Drawer();
      dr.makeText("Igra je završena!",  40, 255, width/2, height/3);
      dr.makeText("Rezultat:",30,255,width/2,height/3+50);
      int y = 50+10+30;
      for(int i=0;i<numPlayers;i++)
      {
        dr.makeText(playersName.get(i),25,255,width/2-60,height/3+y);
        dr.makeText(str(gameInfo[i].sumAllTogether),25,255,width/2+90,height/3+y);
        y=y+20+10;
        
      }
    }
  
}
    void showPlayers() {
      
    int deltaX = 80;
    int startPointX = 130 ;  
    int numCols = 4; 
    
    
    textAlign(LEFT);
    text("Popis igraca:", startPointX + deltaX * numCols + 100,30);
    text("Broj bodova:", startPointX + deltaX * numCols + 250, 30);
    
    for(int i = 0; i < numPlayers; i++)
    {
      String item = playersName.get(i);
      textAlign(LEFT);
      text(item, startPointX + deltaX * numCols + 100,30+(i+1)*20);
      text(str(gameInfo[i].sumAllTogether), startPointX + deltaX * numCols + 250, 30 + (i + 1) * 20);
    }
    
    textAlign(LEFT);
    text("Trenutno na potezu:", startPointX + deltaX * numCols + 100,230);
    String currentPlayer = playersName.get(playerOnTurnIndex);
    textAlign(LEFT);
    text(currentPlayer, startPointX + deltaX * numCols + 100,250);
  }

}