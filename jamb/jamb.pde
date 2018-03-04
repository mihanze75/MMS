import static javax.swing.JOptionPane.*;
/***  Constants  ***/
final int NUM_SIDES = 6;   //Sides on the dice
final int NUM_DICE = 5;    //The number of dice used

/***  Variables  ***/
//int[] rolls = new int[NUM_DICE]; //array to store dice roll
int brojac = 0, brIgraca, rezultat[] = {0,0,0,0,0,0}; 
final StringList ids = new StringList( new String[] {} );
StringList players = new StringList();
int playerOnTurnIndex;
int playerGridShown;
Table table;
float DIE_SIZE,lastDieY;
float[] pozicije = new float[NUM_DICE];  // positions of dices on canvas
int[] rollingDice = {1,1,1,1,1}; // 1, if we want to roll the dice, 0 otherwise
int rollingLeft = 3;
String playerOnTurn;

Die[] dice = new Die[NUM_DICE];
emptyDie[] emptyDice = new emptyDie[NUM_DICE];

jambGrid[] gameInfo;

boolean nacrtano = false;

void setup() {
  size(850, 700);
  unosBrojaIgraca();
  gameInfo = new jambGrid[brIgraca];
  for(int i = 0; i < brIgraca; i++)
  {
    unosIgraca(i);
  }
     
  // setting player 1 info
  playerOnTurn = players.get(0);
  playerOnTurnIndex = 0;
  playerGridShown= 0;
  println("Na redu je " + playerOnTurn);
  
  //final float X_SPACING = (float)width/NUM_DICE; //X spacing of the dice
  final float X_SPACING = 140;
  DIE_SIZE = X_SPACING*0.5; //width and height of one die
  float dieY = 10;
  //message_draw("Kliknite za bacanje!");
  for(int i=0; i<5; i++)
  {
    dice[i] = new Die(i+1, 20, dieY, DIE_SIZE);
    dieY = dieY+10+DIE_SIZE;
  }
  
  float dieYEmpty = 10;
  for(int i=0; i<5; i++)
  {
    emptyDice[i] = new emptyDie(20, dieYEmpty, DIE_SIZE);
    dieYEmpty = dieYEmpty+10+DIE_SIZE;
  }
  
}
//je li broj unešen u dozvoljenom obliku
int provjeriUnosBroja(String strings){
  
   for (int i=0; i< strings.length();i++)
    {
      if (strings.charAt(i) >=48 && strings.charAt(i) <= 57)
      {
      println ( "Na " + i + ". tom mjestu je broj!");
      } 
      else 
      {
        println ("Na " + i + ". tom mjestu nije broj!");
        return 0;
      }
    }
    return 1;
}

void unosBrojaIgraca(){
  
   String id = showInputDialog("Unesite broj igrača");
   int unosIspravan = provjeriUnosBroja(id);
   
   if (id == null)   exit();
   
   //unos je prazan, ponovi unos
   else if ("".equals(id))
   {
   showMessageDialog(null, "Prazan unos! Molimo unesite neki pozitivan broj.", 
    "Alert", ERROR_MESSAGE);
     unosBrojaIgraca();
   }
    
   if(unosIspravan == 1)
   {
   int broj = parseInt(id);
       // broj igrača mora biti veći od 1
       if(broj < 2) 
       {  
           showMessageDialog(null, "Molimo unesite broj veći od 1.", 
          "Alert", ERROR_MESSAGE);
           unosBrojaIgraca();
       }
       else if(broj > 6)
       {
          showMessageDialog(null, "Molimo unesite broj manji od 7.", 
          "Alert", ERROR_MESSAGE);
           unosBrojaIgraca();
       }
       else 
       {
          showMessageDialog(null, "Broj igrača uspješno dodan!", 
         "Info", INFORMATION_MESSAGE);
          brIgraca = broj;
       }
    }
    // unos nije ispravan , ponovi unos
    else 
    {
      showMessageDialog(null, "Molimo unesite pozitivan cijeli broj.", 
      "Alert", ERROR_MESSAGE);
      unosBrojaIgraca();
    }
 
}
void unosIgraca(int index){
   final String id = showInputDialog("Unesite ime igrača (najviše 8 znakova):");
 
  if (id == null)   exit();
  
  else if(id.length() > 8){
     showMessageDialog(null, "Ime može imati najviše 8 znakova", 
    "Alert", ERROR_MESSAGE);
    unosIgraca(index);
  }
 
  else if ("".equals(id)){
    showMessageDialog(null, "Prazan unos! Molimo unesite ime igrača.", 
    "Alert", ERROR_MESSAGE);
    unosIgraca(index);
    }
    
    else if (ids.hasValue(id)){
    showMessageDialog(null, "Igrač " + id + " već postoji! Molimo unesite neko drugo ime:", 
    "Alert", ERROR_MESSAGE);
    unosIgraca(index);
    }
 
   else {
    showMessageDialog(null, "Igrač " + id + " uspješno dodan!", 
    "Info", INFORMATION_MESSAGE);
    ids.append(id);
    players.append(id);
    gameInfo[index] = new jambGrid(id,index, 17, 4, 80, 30, 130, 10);
   }
}

// method to check the result
void checkCurrentResult(){
  restoreResult();
  for(int i = 0; i < NUM_DICE; ++i){
    int dieResult = dice[i].dieNumber;
    rezultat[dieResult - 1] += 1;
  }
}

// method to reset the result to zero when changing player on turn
void restoreResult(){
  for(int i = 0; i < 6; ++i){
    rezultat[i] = 0;
  }
}

void stopDrawing(int ms){
     noLoop();
    try{
    Thread.sleep(ms);
    playerGridShown = playerOnTurnIndex;
    nacrtano = false;
    loop();
    playerGridShown = playerOnTurnIndex;
    }
    catch(Exception e){}
}

void draw() {
  background(220, 220, 220);
  if(playerOnTurnIndex != playerGridShown && nacrtano){
    stopDrawing(2000);
  }
  if(playerOnTurnIndex != playerGridShown && !nacrtano){
    gameInfo[playerGridShown].drawGrid();
    nacrtano = true;
  }
  
  if(rollingLeft < 3){
    for ( int d = 0; d < NUM_DICE; d++) {
      dice[d].DrawDie();
    }
  }
  else{
    for(int d=0; d < NUM_DICE; d++)
    {
      emptyDice[d].DrawEmptyDie();
    }  
  }
  if(playerOnTurnIndex == playerGridShown){
    gameInfo[playerOnTurnIndex].drawGrid();
  }
  /*else{
    gameInfo[playerGridShown].drawGrid();
    playerGridShown = playerOnTurnIndex;
  }
  printUsedDices();*/
  printNumberOfRollingsLeft();
}
 
void mousePressed() {
  //dice_roll();
  println(str(mouseX) + " " + str(mouseY));
  
   // ako je ostalo 3 bacanja, onda na početku mora baciti kocku, ne smije uzeti kocke koje je igrac prije njega dobio
    /*if(rollingLeft == 3){
      
          showMessageDialog(null, "Molimo zavrtite kockicu!", 
         "Info", INFORMATION_MESSAGE);
    }*/
    //else{
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
           if(gameInfo[playerOnTurnIndex].check(rezultat)){
             if(playerOnTurnIndex == brIgraca - 1){
               playerOnTurnIndex = 0;
             }
             else{
               playerOnTurnIndex += 1;
             }
             
             for(int i = 0; i < 6; i++)
             { println("imamo " + rezultat[i] + " kocaka broj " + (i+1));
             }
             //println("Rez je : " + rezultat);
             // novi igrač, vrati sve na početno 
             rollingLeft = 3;
             
             for(int i = 0; i < NUM_DICE; i++)
             { 
               rezultat[i] = 0;
               rollingDice[i] = 1;
               if(!dice[i].DieRolls())
               {
                 dice[i].ChangeRollingDieProperty();
               }
             }
             rezultat[5] = 0;
           return;
           }
         }
}

// change of playerOnTurn will be handled in form functions, when the result is entered
void keyPressed(){
  
    if(key == 'A' || key == 'a'){
      if(rollingLeft > 0){
        for(int i=0;i<5;i++)
        {
          dice[i].RollTheDie();
          println(dice[i].dieNumber);
        }
        rollingLeft -= 1;
        
      }
     else{

    }
}
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
 
void message_draw(String message) {
  //Display the given message in the centre of the window.
  textSize(24);
  fill(0);
  text(message, (width-textWidth(message))/2, height/2);
}

void printNumberOfRollingsLeft(){
  
   text("Imaš još " + rollingLeft + " pokušaja.", 630,350);
}