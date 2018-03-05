// class keeps informations about screen stages and settings
class Window{
  boolean wellcome, play, end;
  Drawer drawer;
  ControlP5 controlP5;
  RadioButton playerNumRB;
  Button nextBtn, playBtn, newGameBtn;
  String errorMessage;
  Textfield names[];
  int brIgraca;
  Game game;
  StringList playersName;
  
  //first we show wellcome screen and get info about game
  Window(ControlP5 _controlP5) {
    wellcome = true;
    play = false;
    
    controlP5 = _controlP5;
    drawer = new Drawer();
    playersName = new StringList();
    makeControls();
  }
  
  // use radio button to get number of players
  // add controls to UI
  void makeControls() {    
    controlP5.setFont(drawer.getControlFont(20));
    drawer.setFont(50, 255);
    playerNumRB = controlP5.addRadioButton("playerNum", width/2 - 20, height/4 + 80)
      .setSize(20, 20);
    playerNumRB.addItem("2", 2);
    playerNumRB.addItem("3", 3);
    playerNumRB.addItem("4", 4);
    playerNumRB.addItem("5", 5);
    playerNumRB.addItem("6", 6);
    
    nextBtn = controlP5.addButton("Next")
      .setValue(0)
      .setPosition(width/2 - 50, height/4+200)  
      .setSize(100, 50);
    playBtn = controlP5.addButton("Play")
      .setValue(0)
      .setSize(100, 50);
    playBtn.setVisible(false);
    brIgraca = 0;
    errorMessage = "";
    newGameBtn = controlP5.addButton("NewGame")
                .setValue(0)
                .setPosition(width/2 - 70, height/4+100)
                .setSize(150, 60);
    newGameBtn.setVisible(false);       
  }
  
  // use text boxes to get player names 
   void drawTextFields(){
    for (int i = 0; i < brIgraca; ++i) {
      names[i] = controlP5.addTextfield("Player"+i)
        .setPosition(width/2, height/4+80+i*50)
        .setSize(150, 30)
        .setFont(drawer.getControlFont(20));
      names[i].getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
        .getStyle().setPaddingLeft(-10);
    }
  }
  
  // draw current stage
  void drawCurrentStage() {
    if (wellcome) {
      drawer.makeText("Jamb", 40, 255, width/2, height/4);
      drawer.makeText("Unesite broj igrača i njihova imena", 20, 255, width/2, height/4 + 40);
      drawer.makeText(errorMessage, 20, 0, width/2, height/4 + 400);
    } 
    else if (play) {
      game.DrawGame();
      
    }
    else if(end){
      newGameBtn.setVisible(true);
    }
  }
  
  // klik na button Next
  void nextButtonClick(){
    for (int i = 0; i < playerNumRB.getArrayValue().length; ++i)
      if (playerNumRB.getArrayValue()[i] == 1)
        brIgraca = i + 2;
          
    if (brIgraca == 0) {
      errorMessage = "Molimo unesite broj igrača!";
      return;
    }
    else {
      errorMessage = "";
      names = new Textfield[brIgraca];
      drawTextFields();
      removeWellcomeScreen();
      playBtn.setVisible(true);
      playBtn.setPosition(width/2 - 50, height/4+80+ brIgraca*60);
    }
  }
  
  // makni pocetni zaslon
  void removeWellcomeScreen(){
    nextBtn.remove();
    playerNumRB.remove();
  }
  
  // klik na playButton
  void playButtonClick(){
    for( int i = 0; i < brIgraca; i++ ){
      String s = names[i].getText();
      playersName.append(s);
      println(s);
      names[i].remove();
    }
    
    game = new Game(brIgraca, playersName);
    play=true;
    wellcome=false;
    playBtn.remove();
    
  }
  
  // klik na newGame
  void newGameButtonClick(){
    wellcome = true;
    end = false;
    play = false;
    brIgraca = 0;
    newGameBtn.remove();
    makeControls();
  }
  
  // control event
  void controlEvent(ControlEvent theEvent) {
    if (!theEvent.isGroup()) {
      if (theEvent.getController().getName().equals("Next")) 
        nextButtonClick();
      else if (theEvent.getController().getName() == "Play")
        playButtonClick(); 
        
      else if(theEvent.getController().getName() == "NewGame")
        newGameButtonClick();
      
    }
  }
  
  // ovo mi treba za pritisak tipke, tj za bacanje kockica
  void checkPressedKey(int key) {
    if (play) {
      game.checkPressedKey(key);
    }
  }
  
  // klik misa mi je za vise toga
  void checkMousePressed(){
    
    if(play){
      game.checkOnClick();
  }
  }
}