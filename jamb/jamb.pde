import static javax.swing.JOptionPane.*;
import controlP5.*;


//final StringList ids = new StringList( new String[] {} );

ControlP5 controlP5;
Window window;


void setup() {
  size(850, 700);
  
  controlP5 = new ControlP5(this);
  window = new Window(controlP5);
  
}

void draw() {
  background(51,153,255);
  window.drawCurrentStage();
  
}

void mousePressed() {
  window.checkMousePressed();  
}

void keyPressed(){
  window.checkPressedKey(key);
}

void controlEvent(ControlEvent theEvent){
  println("cotrolevet");
  window.controlEvent(theEvent);
}