class Game implements Window{
  private Joystick stick;
  private Player player;
  private Button shotButton;
  private ArrayList<Enemy> enemies;
  private int wave;
  private ArrayList<AnimationI> animations;
  private int temp_size = 100; //radius of newly created rock

  Game(){
    this.setup();
  }

  private void setup(){
    stick = new Joystick();
    shotButton = new Button(width-height/4-height/12,height-height/4-height/12,height/4,height/4,"");
    this.animations = new ArrayList<AnimationI>();
    enemies = new ArrayList<Enemy>();

    this.wave = getStat("wave");
    int rocks = 0;
    if(boolean(getStat("waveUnfinished"))){
      this.player = new Player(getStat("w_lives"));
      rocks = getStat("w_rocks");
    } else{
      this.player = new Player();
      rocks = this.wave;
      setStat("waveUnfinished", 1);
      setStat("w_rocks", rocks);
      setStat("w_lives", this.player.getLives());
    }

    this.disposeUpgrades(); //Activate Upgrades in this Wave

    for (int i = 0; i < rocks; i++) {
      // vv create new rock vv
      int screenSide = int(random(0, 4)); //spawn rocks only on the edge of the screen
      if(screenSide == 0){ //left edge of screen (teleports to right of moving left so both edges are covered)
        enemies.add(new Rock(2, -temp_size, random(-temp_size, height+temp_size), temp_size));
      } else{
        enemies.add(new Rock(2, random(-temp_size, width+temp_size), -temp_size, temp_size));
      }
    }

    
  }

  private void disposeUpgrades(){
    String[] upgrades = getList("equipped_upgrades");
    if(!upgrades[0].equals("")){
      for(int i=0;i<upgrades.length;i++){
        int upgrade_id = int(split(upgrades[i],",")[0]);
        int mult = int(split(upgrades[i],",")[1]);
        for (int m = 1; m <= mult; m++) {     
          switch(upgrade_id) {
            case 0:
              this.player.increaseMaxLives(0.1/m); break;
            case 1:
              this.player.reducesCooldown(0.1/m); break;
            case 2:
              this.player.increaseRegenerationProbability(0.1/m); break;
            case 3:
              if (rockChildProbablility == 0) {
                rockChildProbablility = 0.1/m;
              } else {
                rockChildProbablility += rockChildProbablility * (0.1/m);
              }
              break;
            case 4:
              this.player.increaseMaxSpeed(0.1/m); break;
            case 5:
              this.player.reduceSize(0.9/m); break;
            case 6:
              this.temp_size *= 0.9/m; break;
            default: break;
          }
        }
      }
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

    if(stick.active_touch != -1){ //joystick is updated
      player.update(stick.getDist());
    }
    else {
      player.deaccelarate();
    }
    player.handleEnemies(enemies, animations); //hit or not
    player.show();
    player.showLives();

    if(player.getLives() <= 0){ //player dies
      setWindow(6); //game over screen
      setStat("waveUnfinished", 0);
    } else if(enemies.size() <= 0){
      setWindow(12); //exit to clearedWave Window
      setStat("waveUnfinished", 0);
    }

    stick.show();
    shotButton.show();
  }

  void touchStarted()
  {
    if(stick.active_touch == -1 && touches[touches.length-1].x <= width/2){ //if the stick is not touched yet && the last touch is on the left side of the screen
      if(boolean(getSetting(0))){ //joystick locked setting
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

  void update(){}
}
