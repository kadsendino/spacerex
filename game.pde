class Game implements Window
{
  Joystick stick;
  Player player;

  Game(){
    this.setup();
  }

  void setup(){
    stick = new Joystick();
    player = new Player();
  }

  void draw(){
    background(20);
    player.show();

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
        player.update(stick.getAngle());
      }
    }
  };
}