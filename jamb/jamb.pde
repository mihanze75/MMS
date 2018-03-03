import static javax.swing.JOptionPane.*;
/***  Constants  ***/
final int NUM_SIDES = 6;   //Sides on the dice
final int NUM_DICE = 5;    //The number of dice used

/***  Variables  ***/
int[] rolls = new int[NUM_DICE]; //array to store dice roll
int brojac = 0, brIgraca, rezultat[] = {0,0,0,0,0,0}; 
final StringList ids = new StringList( new String[] {} );
StringList players = new StringList();
int playerOnTurnIndex;
Table table;
float DIE_SIZE,lastDieY;
float[] pozicije = new float[NUM_DICE];  // positions of dices on canvas
int[] rollingDice = {1,1,1,1,1}; // 1, if we want to roll the dice, 0 otherwise
int rollingLeft = 3;
String playerOnTurn;

jambGrid[] gameInfo;

void setup() {
  size(700, 700);
  unosBrojaIgraca();
  gameInfo = new jambGrid[brIgraca];
  for(int i = 0; i < brIgraca; i++)
  {
    unosIgraca(i);
  }
     
  // setting player 1 info
  playerOnTurn = players.get(0);
  playerOnTurnIndex = 0;
  println("Na redu je " + playerOnTurn);
  
  //message_draw("Kliknite za bacanje!");
  dice_roll();
  
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
   final String id = showInputDialog("Unesite ime igrača:");
 
  if (id == null)   exit();
 
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
    gameInfo[index] = new jambGrid(index, 17, 4, 70, 30, 150, 10);
   }
}

void draw() {
  background(220, 220, 220);
  for ( int d = 0; d < NUM_DICE; d++) {
    //black color
    if(rollingDice[d] == 1)
      die_draw( d, rolls[d], "black");
    else
      die_draw( d, rolls[d], "red");
  }
  gameInfo[playerOnTurnIndex].drawGrid();
  printUsedDices();
}
 
void mousePressed() {
  //dice_roll();
  println(str(mouseX) + " " + str(mouseY));
  if(provjera()){
    return;
  }
  if(gameInfo[playerOnTurnIndex].check()){
    return;
  }
}

// change of playerOnTurn will be handled in form functions, when the result is entered
void keyPressed(){
    if(key == 'A' || key == 'a'){
      if(rollingLeft > 0){
        dice_roll();
        rollingLeft -= 1;
      }
     else{
       showMessageDialog(null, "Nema više bacanja za tebe!", 
         "Info", INFORMATION_MESSAGE);
       println("Nema više bacanja za tebe!");
       if(playerOnTurnIndex == brIgraca - 1){
         playerOnTurnIndex = 0;
       }
       else{
         playerOnTurnIndex += 1;
       }
       
       //zbroji rezultat
       for(int i = 0; i < NUM_DICE; i++)
       { 
          if(rolls[i] == 1) rezultat[0]++;
          if(rolls[i] == 2) rezultat[1]++;
          if(rolls[i] == 3) rezultat[2]++;
          if(rolls[i] == 4) rezultat[3]++;
          if(rolls[i] == 5) rezultat[4]++;
          if(rolls[i] == 6) rezultat[5]++;
         //rezultat = rezultat + rolls[i];
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
       } 
       //jos sestu kocku
        rezultat[5] = 0;
       //dice_roll();
     }
    }
}

 boolean provjera(){
   if(mouseX >= 20 && mouseX <= (20 + DIE_SIZE))
   {
       println("OK, X-os si pogodio");
       for(int i = 0; i < NUM_DICE; i++)
       {
          if(mouseY >= pozicije[i] && mouseY <= (pozicije[i] + DIE_SIZE))
          {  
             println("Bravo, cak si i Y-os pogodio.");
             // igrac hoce ili nece bacati kocku
             if(rollingDice[i] ==  1 && rollingLeft != 3) 
             {  
                //red color
                //NIJE DOBRO! Samo se na klik ofarba :(
                //fill(255,0,0);
                //rect(20, pozicije[i] ,DIE_SIZE ,DIE_SIZE);
                rollingDice[i] = 0;
             }   
             else 
             {   
                //black color
                //fill(255,0,0);
                //rect(20, pozicije[i] ,DIE_SIZE ,DIE_SIZE);
                rollingDice[i] = 1;
             }   
             return true;
          }
       }
       println("Ali nisi pogodio Y-os -.-");
       return false;
   }  
   println("Fulao si X-os!!!!");
   return false;
 }
 
void printUsedDices(){
   text("Kockice koje bacaš:", 20, 550);
   int j = 1;
   for(int i = 0; i < 5; i++)
   {
     if(rollingDice[i] == 1)
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
    if(rollingDice[i] == 0)
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
 
void dice_roll() {
  for (int i=0; i < NUM_DICE; i++) {
    if(rollingDice[i] == 1)
    {  
       // println("evo " + i + "-ta kocka je zarolana");
       rolls[i]=1 + int(random(NUM_SIDES));
    }   
  }
}
 
void die_draw(int position, int value, String colour) {
  /* Draw one die in the canvas.
   *   position - must be 0..NUM_DICE-1, indicating which die is being drawn
   *   value - must be 1..6, the amount showing on that die
   */
  final float X_SPACING = (float)width/NUM_DICE; //X spacing of the dice
  DIE_SIZE = X_SPACING*0.5; //width and height of one die
  final float X_LEFT_DIE = X_SPACING*0.1; //left side of the leftmost die
  final float Y_OFFSET = X_SPACING*0.15; //slight Y offset of the odd-numbered ones
  final float Y_POSITION = height-DIE_SIZE-Y_OFFSET; //Y coordinate of most dice
  final float PIP_OFFSET = DIE_SIZE/3.5; //Distance from centre to pips, and between pips
  final float PIP_DIAM = DIE_SIZE/5; //Diameter of the pips (dots)
 
  //From the constants above, and which die it is, find its top left corner
  //float dieX = X_LEFT_DIE+position*X_SPACING;
  float dieX = 20;
  //float dieY = Y_POSITION-Y_OFFSET*(position%2);
  float dieY;
  if(position == 0){
    dieY = DIE_SIZE*position + 10;
  }
  else{
    dieY = lastDieY + DIE_SIZE + 10;
  }
 lastDieY = dieY;
 // pamti Y poziciju, X pozicija je uvijek ista : 20, kao i velicina kocke : DIE_SIZE
  pozicije[position] = dieY;
 
  //1.Draw a square
  stroke(0); //Black outline
  // determine if dice is clicked or not
  if(colour == "black")
  fill(0, 0, 0); //Black fill
  if(colour == "red")
  fill(255, 0, 0); //Red fill
  rect(dieX, dieY, DIE_SIZE, DIE_SIZE);
 
  //2.Draw the pips (dots)
  fill(255); //White dots
  stroke(255); //White outline
 
  //The centre dot (if the value is odd)
  if (value%2 == 1){
    ellipse(dieX+DIE_SIZE/2, dieY+DIE_SIZE/2, PIP_DIAM, PIP_DIAM);
  }
 
  //The top-right and bottom-left dots (if the value is more than 1)
  if (value>1) {
    ellipse(dieX+DIE_SIZE/2-PIP_OFFSET, 
      dieY+DIE_SIZE/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2+PIP_OFFSET, 
      dieY+DIE_SIZE/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
  }
 
  //The bottom-right and top-left dots (if the value is more than 3)
  if (value>3) {
    ellipse(dieX+DIE_SIZE/2+PIP_OFFSET, 
      dieY+DIE_SIZE/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2-PIP_OFFSET, 
      dieY+DIE_SIZE/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
  }
 
  //The left and right dots (only if the value is 6)
  if (value==6) {
    ellipse(dieX+DIE_SIZE/2-PIP_OFFSET, 
      dieY+DIE_SIZE/2, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2+PIP_OFFSET, 
      dieY+DIE_SIZE/2, PIP_DIAM, PIP_DIAM);
  }
}