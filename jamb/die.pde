class Die{
  
  private int dieIndex;
  private float dieX;
  private float dieY;
  private float dieSize;
  private int dieNumber;
  private color fill_color;
  private boolean rollingDie;
  //default constructor
  Die()
  {}
  
  //constructor
  Die(int _dieIndex, float _dieX, float _dieY, float _dieSize)
  {
    dieIndex = _dieIndex;
    dieX = _dieX;
    dieY = _dieY;
    dieSize = _dieSize;
    dieNumber = 1 + int(random(6));;
    fill_color = color(0);
    rollingDie = true;
  }
  
  boolean IsInsideDie(float x_coor, float y_coor)
  {
    if(x_coor>=dieX && x_coor<=(dieX+dieSize)){
      if(y_coor>=dieY && y_coor<=(dieY+dieSize)){
          return true;
      }
    }
    return false;
  }
  boolean DieRolls()
  {
      return rollingDie;
  }
  void ChangeRollingDieProperty()
  {
    if(rollingDie)
    {
      rollingDie = false;
      fill_color = color(255,0,0);
    }
    else
    {
      rollingDie = true;
      fill_color = color(0);
    }
  }
  
  void RollTheDie()
  {
    if(rollingDie)
    {
      dieNumber = 1 + int(random(6));
    }
  }
  
  void DrawDie()
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
    if (dieNumber%2 == 1){
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
        dieY+dieSize/2, PIP_DIAM, PIP_DIAM);
    }
    
    
  }
}