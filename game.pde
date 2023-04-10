class Game implements Window
{
  Joystick stick;

  Game(){
    this.setup();
  }

  void setup(){
    stick = new Joystick();
  }

  void draw(){
    fill(255, 0, 0);
    ellipse(width/2, height/2, 400,400);

    stick.show();
  }

  void touchStarted()
  {
    if(touches[touches.length-1].x <= width/2)
    {
      stick.setPositions(touches[touches.length-1].x,touches[touches.length-1].y);
      stick.setActiveTouch(touches[touches.length-1].id);
    }
  };
  
  void touchEnded(){
    stick.setActiveTouch(0);
  };
  
  void touchMoved(){
    
  };
}