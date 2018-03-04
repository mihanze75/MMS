class emptyDie{

  private float dieX;
  private float dieY;
  private float dieSize;
  private color fill_color;
  private boolean rollingDie;
  //default constructor
  emptyDie()
  {}
  
  //constructor
  emptyDie(float _dieX, float _dieY, float _dieSize)
  {
    dieX = _dieX;
    dieY = _dieY;
    dieSize = _dieSize;
    fill_color = color(0);
    rollingDie = true;
  }
  
  void DrawEmptyDie()
  {
    
    final float PIP_OFFSET = dieSize/3.5; //Distance from centre to pips, and between pips
    final float PIP_DIAM = dieSize/5; //Diameter of the pips (dots)
    
    //draw a square
    stroke(0); //Black outline
    fill(fill_color); //Red fill
    rect(dieX, dieY, dieSize, dieSize);
 
    //2.Draw the pips (dots)
    fill(255); //White dots
    stroke(255); //White outline
 
    //The centre dot (if the value is odd)
    /*if (dieNumber%2 == 1){
      ellipse(dieX+dieSize/2, dieY+dieSize/2, PIP_DIAM, PIP_DIAM);
    }
 
  //The top-right and bottom-left dots (if the value is more than 1)
    if (dieNumber>1) {
      ellipse(dieX+dieSize/2-PIP_OFFSET, 
        dieY+dieSize/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
      ellipse(dieX+dieSize/2+PIP_OFFSET, 
        dieY+dieSize/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    }
 
    //The bottom-right and top-left dots (if the value is more than 3)
    if (dieNumber>3) {
      ellipse(dieX+dieSize/2+PIP_OFFSET, 
        dieY+dieSize/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
      ellipse(dieX+dieSize/2-PIP_OFFSET, 
        dieY+dieSize/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    }
 
    //The left and right dots (only if the value is 6)
    if (dieNumber==6) {
      ellipse(dieX+dieSize/2-PIP_OFFSET, 
        dieY+dieSize/2, PIP_DIAM, PIP_DIAM);
      ellipse(dieX+dieSize/2+PIP_OFFSET, 
        dieY+dieSize/2, PIP_DIAM, PIP_DIAM);*/
    }
}