class Game implements Window
{
  Joystick stick;
  Player player;
  Button shotButton;

  Game(){
    this.setup();
  }

  void setup(){
    stick = new Joystick();
    player = new Player();
    shotButton = new Button(width-height/4-height/12,height-height/4-height/12,height/4,height/4,"");
  }

  void draw(){
    background(20);
    player.show();

    stick.show();
    shotButton.show();

    if(stick.active_touch != -1){
      player.update(stick.getDist());
    } else {
      player.deaccelarate();
    }
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
        player.setAngle(stick.getAngle());
      }
    }
  };
}