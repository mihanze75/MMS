import static javax.swing.JOptionPane.*;
/***  Constants  ***/
final int NUM_SIDES = 6;   //Sides on the dice
final int NUM_DICE = 5;    //The number of dice used

/***  Variables  ***/
int[] rolls = new int[NUM_DICE]; //array to store dice roll
int brojac = 0, brIgraca;
final StringList ids = new StringList( new String[] {} );
Table table;
float lastDieY;

void setup() {
  size(500, 500);
  unosBrojaIgraca();
  for(int i = 0; i < brIgraca; i++)
  {
    table = new Table();
  
    table.addColumn("id");
    table.addColumn("species");
    table.addColumn("name");
  
    TableRow newRow = table.addRow();
    newRow.setInt("id", table.lastRowIndex());
    newRow.setString("species", "Panthera leo");
    newRow.setString("name", "Lion");
    unosIgraca();
  }
    
  message_draw("Kliknite za bacanje!");
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
void unosIgraca(){
   final String id = showInputDialog("Unesite ime igrača:");
 
  if (id == null)   exit();
 
  else if ("".equals(id)){
    showMessageDialog(null, "Prazan unos! Molimo unesite ime igrača.", 
    "Alert", ERROR_MESSAGE);
    unosIgraca();
    }
    
    else if (ids.hasValue(id)){
    showMessageDialog(null, "Igrač " + id + "\" već postoji! Molimo unesite neko drugo ime:", 
    "Alert", ERROR_MESSAGE);
    unosIgraca();
    }
 
   else {
    showMessageDialog(null, "Igrač " + id + "\" uspješno dodan!", 
    "Info", INFORMATION_MESSAGE);
    ids.append(id);
   }
}
void draw() {
  for ( int d = 0; d < NUM_DICE; d++) {
    die_draw( d, rolls[d] );
  }
}
 
void mousePressed() {
  dice_roll();
}
 
void message_draw(String message) {
  //Display the given message in the centre of the window.
  textSize(24);
  fill(0);
  text(message, (width-textWidth(message))/2, height/2);
}
 
void dice_roll() {
  for (int i=0; i < NUM_DICE; i++) {
    rolls[i]=1 + int(random(NUM_SIDES));
  }
}
 
void die_draw(int position, int value) {
  /* Draw one die in the canvas.
   *   position - must be 0..NUM_DICE-1, indicating which die is being drawn
   *   value - must be 1..6, the amount showing on that die
   */
  final float X_SPACING = (float)width/NUM_DICE; //X spacing of the dice
  final float DIE_SIZE = X_SPACING*0.5; //width and height of one die
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
  //1.Draw a red square with a black outline
  stroke(0); //Black outline
  fill(0, 0, 0); //Black fill
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