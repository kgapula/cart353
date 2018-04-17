// ----------------------------------------------------------------------
// USER CLASSES: lightningBolt (present randomly throughout the sketch but 
// triggered with a more dramatic effect when there is a large value of Eletromagnetic activity)
// ----------------------------------------------------------------------

class lightningBolt{
  float lineWidth0,theta,x0,y0,x1,y1,x2,y2,straightJump,straightJumpMax,straightJumpMin,lineWidth;
  color myColor;
  lightningBolt(float x0I, float y0I, float width0, float theta0, float jumpMin, float jumpMax, color inputColor){

    lineWidth0 = width0;
    lineWidth = width0;
    theta = theta0;
    x0 = x0I;
    y0 = y0I;
    x1 = x0I;
    y1 = y0I;
    x2 = x0I;
    y2 = y0I;
    straightJumpMin = jumpMin;
    straightJumpMax = jumpMax;
    myColor = inputColor;
    //it's a wandering line that goes straight for a while,
    //then does a jagged jump (large dTheta), repeats.
    //it does not aim higher than thetaMax
    //(theta is down at 0)
    straightJump = random(straightJumpMin,straightJumpMax);
  }

  //determines when the thunderbolts should display
  float getThunderTime(){
    return (millis()+meanDistance*(1+random(-.1,.1)));
  }

  void display()
  {
    while(y2<height && (x2>0 && x2<width))
    {
      pushStyle();
      strokeWeight(1);
      
      theta += randomSign()*random(minDTheta, maxDTheta);
      if(theta>maxTheta)
        theta = maxTheta;
      if(theta<-maxTheta)
        theta = -maxTheta;
        
      straightJump = random(straightJumpMin,straightJumpMax);
      x2 = x1-straightJump*cos(theta-HALF_PI);
      y2 = y1-straightJump*sin(theta-HALF_PI);
      
      if(randomColors)
        myColor = slightlyRandomColor(myColor,straightJump);
      
      lineWidth = map(y2, height,y0, 1,lineWidth0);
      if(lineWidth<0)
        lineWidth = 0;
      stroke(myColor);
      strokeWeight(lineWidth);
      line(x1,y1,x2,y2);
      x1=x2;
      y1=y2;
      
      //think about making a fork
      if(random(0,1)<childGenOdds){//if yes, have a baby!
        float newTheta = theta;
        newTheta += randomSign()*random(minDTheta, maxDTheta);
        if(theta>maxTheta)
          //limit the values of theta
          theta = maxTheta;
        if(theta<-maxTheta)
          theta = -maxTheta;
        (new lightningBolt(x2, y2, lineWidth, newTheta, straightJumpMin, straightJumpMax,boltColor)).display();
        //it draws the whole limb before continuing.
        popStyle(); // push and pop styles to limit the changes only to this section of code
      }
    }
  }
}

// Credit for the original sketch: https://www.openprocessing.org/sketch/2924