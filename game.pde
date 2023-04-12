class Game implements Window
{
  Joystick stick;
  Player player;
  Button shotButton;
  ArrayList<Enemy> enemies;


  Game(){
    this.setup();
  }

  void setup(){
    stick = new Joystick();
    player = new Player();
    shotButton = new Button(width-height/4-height/12,height-height/4-height/12,height/4,height/4,"");

    enemies = new ArrayList<Enemy>();
  }

  void draw(){
    background(5,5,25);
    player.show();

    stick.show();
    shotButton.show();
    
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).update();
      enemies.get(i).show();
    }

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
    if(shotButton.mouseOver(touches[touches.length-1].x,touches[touches.length-1].y)){
      shotButton.setSelected(true);
      shotButton.setActiveTouch(touches[touches.length-1].id);
      player.shoot();
    }

    enemies.add(new Rock(1,touches[touches.length-1].x,touches[touches.length-1].y,100));
  }
  
  void touchEnded(){
    boolean active_touch_stick = true; 
    boolean active_touch_shotButton = true;

    for(int i=0;i<touches.length;i++){
      if(stick.getActiveTouch() == touches[i].id){
        active_touch_stick = false;
      }
      if(shotButton.getActiveTouch() == touches[i].id){
        active_touch_shotButton = false;
      }
    }

    if (active_touch_stick) {
      stick.setActiveTouch(-1);
      stick.setActiveTouchPosition(stick.getX(),stick.getY());
    }
    if (active_touch_shotButton) {
      shotButton.setSelected(false);
      shotButton.setActiveTouch(-1);
      //shoot
    }
  }
  
  void touchMoved(){
    for(int i=0;i<touches.length;i++){
      if(stick.active_touch == touches[i].id)
      {
        stick.setActiveTouchPosition(touches[i].x,touches[i].y);
        player.setAngle(stick.getAngle());
      }
    }
  }
}