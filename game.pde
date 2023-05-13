class Game implements Window{
  private Joystick stick;
  private Player player;
  private Button shotButton;
  private ArrayList<Enemy> enemies;
  private int spawnCount;
  private int wave;
  private ArrayList<AnimationI> animations;

  Game(){
    this.wave = getWave();
    this.setup();
  }

  void setup(){
    stick = new Joystick();
    player = new Player();
    shotButton = new Button(width-height/4-height/12,height-height/4-height/12,height/4,height/4,"");

    this.animations = new ArrayList<AnimationI>();
    enemies = new ArrayList<Enemy>();
    spawnCount = 0;

    for (int i = 0; i < this.wave; i++) {
      PVector rand_pos = new PVector(width/2,height/2);
      rand_pos.add(PVector.fromAngle(random(0,TWO_PI)).mult(random(200,height)));
      enemies.add(new Rock(2,rand_pos.x,rand_pos.y,100));
    }
  }

  void draw(){
    background(5,5,25);

    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).update();
      enemies.get(i).show();
    }

    for(int i=this.animations.size()-1; i>=0; i--) {
      AnimationI a = this.animations.get(i);
      a.show();
      a.update();
      if(a.isOver()) {
        this.animations.remove(a);
      }
    }

    if(stick.active_touch != -1){
      player.update(stick.getDist());
    }
    else {
      player.deaccelarate();
    }
    player.handleEnemies(enemies, animations);
    player.show();

    if(spawnCount >= 120){
      spawnCount = 0;
    }

    if(player.getLives() <= 0){
      setWindow(6);
    }
    else if(enemies.size() <= 0){
      setWindow(5); //exit to clearedWave Window
    }

    spawnCount++;

    stick.show();
    shotButton.show();
  }

  void touchStarted()
  {
    if(stick.active_touch == -1 && touches[touches.length-1].x <= width/2){ //if the stick is not touched yet && the last touch is on the left side of the screen
      if(boolean(getSetting(0))){
        stick.setPositions(touches[touches.length-1].x,touches[touches.length-1].y); //moves the joystick to the position of the last touch
      }
      stick.setActiveTouch(touches[touches.length-1].id);
    }
    if(shotButton.mouseOver(touches[touches.length-1].x,touches[touches.length-1].y)){
      shotButton.setSelected(true);
      shotButton.setActiveTouch(touches[touches.length-1].id);
      player.shoot();
    }
  }

  void touchEnded(){
    boolean ended_touch_stick = true;
    boolean ended_touch_shotButton = true;

    for(int i=0; i<touches.length; i++){
      if(stick.getActiveTouch() == touches[i].id){
        ended_touch_stick = false;
      }
      if(shotButton.getActiveTouch() == touches[i].id){
        ended_touch_shotButton = false;
      }
    }

    if(ended_touch_stick) {
      stick.setActiveTouch(-1);
      stick.setActiveTouchPosition(stick.getX(),stick.getY());
    }
    if(ended_touch_shotButton) {
      shotButton.setSelected(false);
      shotButton.setActiveTouch(-1);
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

  void goBack() { //on BackPressed on (hardware) button on phone
    setWindow(1);
  }
}
