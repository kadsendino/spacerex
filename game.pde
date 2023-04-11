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
    background(20);
    fill(255, 0, 0);
    ellipse(width/2, height/2, 400,400);

    stick.show();
  }

  void touchStarted()
  {
    if(stick.active_touch == -1 && touches[touches.length-1].x <= width/2){
      stick.setPositions(touches[touches.length-1].x,touches[touches.length-1].y);
      stick.setActiveTouch(touches[touches.length-1].id);
    }
  };
  
  void touchEnded(){
    for(int i=0;i<touches.length;i++){
      if(stick.active_touch == touches[i].id)
      {
        return;
      }
    }
    stick.setActiveTouch(-1);
    stick.setActiveTouchPosition(stick.getX(),stick.getY());
  };
  
  void touchMoved(){
    for(int i=0;i<touches.length;i++){
      if(stick.active_touch == touches[i].id)
      {
        stick.setActiveTouchPosition(touches[i].x,touches[i].y);
      }
    }
  };
}