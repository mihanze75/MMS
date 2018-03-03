public void drawSumField(int startX, int startY, boolean total){
  strokeWeight(3);
  line(startX, startY, startX + deltaX, startY);
  line(startX, startY + deltaY, startX + deltaX, startY + deltaY);
  line(startX + deltaX, startY, startX + deltaX, startY + deltaY);
  
  if(total){
    line(startX, startY, startX, startY + deltaY);
  }
}