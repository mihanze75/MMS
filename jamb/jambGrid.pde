class jambGrid{
  
  // variables needed for the form
  String name;
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
  PFont Font2;
  
  int player;
  
  int sumNumbers;
  int sumMinMax;
  int sumCombinations;
  int sumAllTogether;
  
  // this array keeps track of the columns that have already been added thirty points in updateFieldWithNumbers method
  int[] thirtyPointsAdded;
  // 
  
  jambGrid(String _name, int _player, int _numRows, int _numCols, int _deltaX, int _deltaY, int _startPointX, int _startPointY){
    name = _name;
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
    Font2 = createFont("Arial", 15);
    
    // setting all fields to -1, except the fields that hold some sum
    for(int i = 0; i < numRows - 1; ++i){
      if(i == 6 || i == 9 || i == 15){
        for(int j = 0; j < numCols - 1; ++j){
          jambResults[i][j] = 0;
        }
      }
      else{
        for(int j = 0; j < numCols - 1; ++j){
          jambResults[i][j] = -1;
        }
      }
    }
    
    sumNumbers = 0;
    sumMinMax = 0;
    sumCombinations = 0;
    sumAllTogether = 0;
    
    thirtyPointsAdded = new int[numCols - 1];
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
  //text("Player " + str(player + 1), x + 7, y + 20);
  text(name, x + 7, y + 20);
  for(int i = 1; i <= 6; ++i){
    text(str(i), x + 25, y + (deltaY *i) + 20);
  }
  text("Ukupno", startPointX + 7, y + (deltaY * 7) + 20);
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
  triangle(x + deltaX + 30, y + 10, x + deltaX + 40, y + 10, x + deltaX + 35, y + 20);
  triangle(x + deltaX*2 + 35, y + 10, x + deltaX*2 + 30, y + 20, x + deltaX*2 + 40, y + 20);
  triangle(x + deltaX*3 + 20, y + 10, x + deltaX*3 + 15, y + 20, x + deltaX*3 + 25, y + 20);
  triangle(x + deltaX*3 + 30, y + 10, x + deltaX*3 + 40, y + 10, x + deltaX*3 + 35, y + 20);
  
  // showing player's results
  for(int i = 0; i < numRows - 1; ++i){
    if(i == 6 || i == 9 || i == 15){
      textFont(Font1);
    }
    else{
      textFont(Font2);
    }
    for(int j = 0; j < numCols - 1; ++j){
      if(jambResults[i][j] != -1){
      text(str(jambResults[i][j]), startPointX + deltaX*(j + 1) + 30 , startPointY + deltaY*(i + 1) + 20);
      }
    }
  }
  
  // filling sum fields
  textFont(Font1);
  text(str(sumNumbers), x + deltaX * numCols + 30, y + deltaY * 7 + 20);
  text(str(sumMinMax), x + deltaX * numCols + 30, y + deltaY * 10 + 20);
  text(str(sumCombinations), x + deltaX * numCols + 30, y + deltaY * 16 + 20);
  text(str(sumAllTogether), x + deltaX * numCols + 30, y + deltaY * numRows + 20);
  
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
  
  // the next method returns true if mouseClick was on the form, otherwise false
  public boolean check(int[] diceResults){
    if((mouseX > startPointX + deltaX && mouseX < startPointX + deltaX*numCols) && (mouseY > startPointY + deltaY && mouseY < startPointY + deltaY*numRows)){
      println("Writing into form");
      int column = (mouseX - deltaX - startPointX)/deltaX;
      int row = (mouseY - deltaY - startPointY)/deltaY;
      println("field: " + str(row) + " " + str(column));
      // first check if the clicked field is empty
      if(!checkField(row, column)){
        println("Field not ok");
        return false;
      }
      // for coumn 1 and 2, check if the previous field is filled
      if(column == 0 || column == 1){
        if(!checkColumn(row, column)){
          println("Field not ok");
          return false;
        }
      }
      println("Field ok");
      if(row <= 5){
        updateFieldWithNumbers(row, column, diceResults);
      }
      
      if(row == 7 || row == 8){
        updateMinMax(row, column, diceResults);
      }
      
      if(row == 10){
        updateTris(row, column, diceResults);
      }
      
      if(row == 11){
        updateSkala(row, column, diceResults);
      }
      
      if(row == 12){
        updateFull(row, column, diceResults);
      }
      
      if(row == 13){
        updatePoker(row, column, diceResults);
      }
      
      if(row == 14){
        updateJamb(row, column, diceResults);  
      }
      
      return true;
    }
    else{
      println("not in the form");
      return false;
    }
  }
  
  public boolean checkField(int row, int column){
    if(jambResults[row][column] != -1){
      return false;
    }
    else{
      return true;
    }
  }
  
  public boolean checkColumn(int row, int column){
    // the first column --> the field above the current field must be filled
    if(column == 0){
      if(row == 0){
        return true;
      }
      if(row == 7 || row == 10){
        if(jambResults[row - 2][column] != -1){
          return true;
        }
      }
      else if(jambResults[row - 1][column] != -1){
        return true;
      }
    }
    
    if(column == 1){
      if(row == numRows - 2){
        return true;
      }
      if(row == 8 || row == 5){
        if(jambResults[row + 2][column] != -1){
          return true;
        }
      }
      else if(jambResults[row + 1][column] != -1){
        return true;
      }
    }
    
    return false;
  }
  
  public void updateFieldWithNumbers(int row, int column, int[] diceResults){
    jambResults[row][column] = (row + 1)* diceResults[row];
    // update the sum of the column
    jambResults[6][column] += jambResults[row][column];
    sumNumbers += jambResults[row][column];
    sumAllTogether += jambResults[row][column];
    
    if(jambResults[6][column] >= 60 && thirtyPointsAdded[column] == 0){
      jambResults[6][column] += 30;
      sumNumbers += 30;
      sumAllTogether += 30;
      thirtyPointsAdded[column] = 1;
    }
    
    // checking if fields with ones, Min and Max are filled, and if yes, then update sums
    if(row == 0){
      if(jambResults[7][column] != -1 && jambResults[8][column] != -1){
        multipleMinMax(column);
      }
    }
  }
  
  public void updateMinMax(int row, int column, int[] diceResults){
     int sum = 0;
     for(int i = 0; i < diceResults.length; ++i){
       sum += diceResults[i]*(i + 1);
     }
     
     jambResults[row][column] = sum;
     
     if(jambResults[0][column] != -1 && jambResults[7][column] != -1 && jambResults[8][column] != -1){
       multipleMinMax(column);
     }  
  }
  
  public void multipleMinMax(int column){
    int difference = jambResults[7][column] - jambResults[8][column];
    if(difference > 0){
      jambResults[9][column] = difference * jambResults[0][column];
    }
    
    sumMinMax += jambResults[9][column];
    sumAllTogether += jambResults[9][column];
  }
  
  public void updateTris(int row, int column, int[] diceResults){
    int result = 0;
    for(int i = 0; i < diceResults.length; ++i){
      if(diceResults[i] >= 3){
        result += 3*(i + 1);
        result += 10;
      }
    }
    
    jambResults[row][column] = result;
    
    if(result != 0){
      updateDownSums(row, column);
    }
  }
  
  public void updateSkala(int row, int column, int[] diceResults){
    int result = 0;
    int i;
    // first check for velika skala :)
    for(i = 1; i < diceResults.length; ++i){
      if(diceResults[i] == 0){
        break;
      }
    }
    if(i == diceResults.length){
      result += 40;
    }
    else{
      for(i = 0; i < diceResults.length - 1; ++i){
        if(diceResults[i] == 0){
          break;
        }
      }
      
      if(i == diceResults.length - 1){
        result += 30;
      }
    }
    
    jambResults[row][column] = result;
    if(result > 0){
      updateDownSums(row, column);
    }
  }
  
  public void updateFull(int row, int column, int[] diceResults){
    int result = 0;
    boolean twos = false;
    boolean threes = false;
    
    for(int i = 0; i < diceResults.length; ++i){
      if(diceResults[i] == 2){
        twos = true;
        result += (i + 1) * 2;
      }
      if(diceResults[i] == 3){
        threes = true;
        result += (i + 1) * 3;
      } 
    }
    
    if(twos && threes){
      result += 30;
      jambResults[row][column] = result;
      updateDownSums(row, column);
    }
    
    else{
      jambResults[row][column] = 0;
    }
  }
  
  public void updatePoker(int row, int column, int[] diceResults){
    int result = 0;
    int i;
    for(i = 0; i < diceResults.length; ++i){
      if(diceResults[i] >= 4){
        result += (i + 1) * 4;
        result += 40;
      }
    }
    
    jambResults[row][column] = result;
    if(result > 0){
      updateDownSums(row, column);
    }
  }
  
    public void updateJamb(int row, int column, int[] diceResults){
    int result = 0;
    int i;
    for(i = 0; i < diceResults.length; ++i){
      if(diceResults[i] == 5){
        result += (i + 1) * 5;
        result += 50;
      }
    }
    
    jambResults[row][column] = result;
    if(result > 0){
      updateDownSums(row, column);
    }
  }
  
  // down sums are the sums on the bottom of the form
  public void updateDownSums(int row, int column){
    jambResults[15][column] += jambResults[row][column];
    sumCombinations += jambResults[row][column];
    sumAllTogether += jambResults[row][column];
  }
   
}