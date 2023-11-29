class Game implements Window{
  private Joystick stick;
  private Player player;
  private Button shotButton;
  private ArrayList<Enemy> enemies;
  private int wave, fade;
  private Boolean showIndicator;
  private ArrayList<AnimationI> animations;
  private int temp_size; //radius of newly created rock
  private float rockChildProbablility;
  private float enemySpeedChange;
  private int rocks;
  private int smallRocks;
  private float smallerRockProbability;
  private float piercingProbablility;

  Game(){
    this.rockChildProbablility = 0;
    this.smallerRockProbability = 0;
    this.piercingProbablility = 0;
    this.enemySpeedChange = 1;
    this.temp_size = 100;
    this.stick = new Joystick();
    this.shotButton = new Button(width-height/4-height/12, height-height/4-height/12, height/4, height/4, "");
    this.animations = new ArrayList<AnimationI>();
    this.enemies = new ArrayList<Enemy>();

    this.wave = getStat("wave");
    this.rocks = 0;
    this.smallRocks = 0;
    if(boolean(getStat("waveUnfinished"))){
      this.player = new Player(getStat("w_lives"));
      rocks = getStat("w_rocks");
      smallRocks = getStat("w_rocks_small");
    } else{
      this.player = new Player();
      rocks = this.wave;
      setStat("waveUnfinished", 1);
      setStat("w_rocks", rocks);
      setStat("w_rocks_small", smallRocks);
      setStat("w_lives", this.player.getLives());
    }

    this.disposeUpgrades(); //Activate Upgrades in this Wave

    //this part is for Upgrade smaller Rocks
    int newSmaller = 0;
    for(int i=0;i<rocks;i++){
      if(random(1) < smallerRockProbability){
        newSmaller++;
      }
    }
    this.rocks -= newSmaller;
    this.smallRocks += newSmaller;
    setStat("w_rocks", this.rocks);
    setStat("w_rocks_small", this.smallRocks);
    int screenSide;
    for (int i = 0; i < rocks; i++){ // vv create new rocks vv
      screenSide = int(random(0, 4)); //spawn rocks only on the edge of the screen
      if(screenSide == 0){ //left edge of screen (teleports to right of moving left so both edges are covered)
        enemies.add(new Rock(2, -temp_size, random(-temp_size, height+temp_size), temp_size, enemySpeedChange));
      } else{
        enemies.add(new Rock(2, random(-temp_size, width+temp_size), -temp_size, temp_size, enemySpeedChange));
      }
    }

    this.temp_size /= 2;
    for (int i = 0; i < smallRocks; i++){ // vv create new small rocks vv
      screenSide = int(random(0, 4)); //spawn rocks only on the edge of the screen
      if(screenSide == 0){ //left edge of screen (teleports to right of moving left so both edges are covered)
        enemies.add(new Rock(1, -temp_size, random(-temp_size, height+temp_size), temp_size, enemySpeedChange));
      } else{
        enemies.add(new Rock(1, random(-temp_size, width+temp_size), -temp_size, temp_size, enemySpeedChange));
      }
    }
    this.temp_size *= 2;

    this.fade = 0;
    this.showIndicator = !boolean(getStat("hide_lastIndicator"));
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
              this.player.increaseMaxLives(0.25/m); break;
            case 1:
              this.player.reducesCooldown(0.08/m); break;
            case 2:
              this.player.increaseRegenerationProbability(0.1/m); break;
            case 3:
              this.rockChildProbablility += 0.12/m;
              break;
            case 4:
              this.player.increaseMaxSpeed(0.1/m); break;
            case 5:
              this.player.reduceSize(0.08/m); break;
            case 6:
              this.temp_size -= this.temp_size * (0.08/m); break;
            case 7:
              this.smallerRockProbability += 0.08/m;
              break;
            case 8:
              this.enemySpeedChange *= (1-(0.1/m));
              break;
            case 9:
              this.piercingProbablility += 0.12/m;
              break;
            default: break;
          }
        }
      }
    }
  }

  public void draw(){
    background(5,5,25);

    if(this.showIndicator && enemies.size() <= 3 && enemies.size() >= 1){
      this.showArrow();
    }

    for(int i = 0; i < enemies.size(); i++){
      this.enemies.get(i).update();
      this.enemies.get(i).show();
    }

    for(int i=this.animations.size()-1; i>=0; i--){
      AnimationI a = this.animations.get(i);
      a.show();
      a.update();
      if(a.isOver()){
        this.animations.remove(a);
      }
    }

    if(stick.active_touch != -1){ //joystick is updated
      this.player.update(stick.getDist());
    }else{
      this.player.deaccelarate();
    }
    this.handleEnemies(); //hit or not
    this.player.show();
    this.player.showLives();

    if(this.player.getLives() <= 0){ //player dies
      setStat("waveUnfinished", 0);
      this.rockChildProbablility = 0;
      setWindow(6); //game over screen
    }else if(this.enemies.size() <= 0){
      setWindow(12); //exit to upgradePicker Window
      //declare wave as finished when picking upgrade, not here
    }

    this.stick.show();
    this.shotButton.show();

    this.fade -= this.wave; //gets more intens by time
    if(this.fade < -255){
      this.fade = 255;
    }
  }

  private void showArrow(){
    pushStyle();
    pushMatrix();
      noStroke();
      fill(140, abs(this.fade));
      translate(width/2, height/2);
      rotate(new PVector(width/2, height/2).sub(this.enemies.get(0).getPos()).heading()); //angle  =  (middle - rock.pos).heading()
      float h_temp = height/15;
      float dist_temp = height/15;
      triangle(h_temp-dist_temp, h_temp, h_temp-dist_temp, -h_temp, -h_temp*2-dist_temp, 0);
    popMatrix();
    popStyle();
  }

  private void handleEnemies(){ //if player is hit
    ArrayList<Shot> shots = this.player.getShots();
    for (int s = shots.size()-1; s>=0; s--) { //checks every shot
      for (int e = this.enemies.size()-1; e>=0; e--) { //checks every enemy
        Enemy enemy = this.enemies.get(e);
        if(enemy.isHit(shots.get(s).getReferencePoints())){ //if the enemy is hit by the shot
          if(enemy.getHit()){ //if the enemy dies/ if it has no more lives
            if(enemy.getEnemyID() == 0){ //if enemy is a rock
              float[] saveData = enemy.getData();
              if((int) saveData[0] > 1){ //rock is big enough to spawn smaler rocks
                for(int i=0; i<2; i++){
                  if(this.rockChildProbablility <= random(1)){ //spawn two smaller rocks
                    this.enemies.add(new Rock(((int) saveData[0])-1, saveData[1], saveData[2], saveData[3]/2,enemySpeedChange));
                    setStat("w_rocks_small", getStat("w_rocks_small")+1);
                  }
                }
              }
              this.animations.add(new Animation(int(saveData[3])*2, int(saveData[3])*2, saveData[1], saveData[2], "rockExplosion")); //rock explosion animation
            }
            if(this.player.getRegenerationProbability() > random(1)){
              this.player.addLives(this.player.getMaxLives()/getStat("wave"));
              setStat("w_lives", this.player.getLives());
            }
            float level_temp = enemy.getData()[0];
            if(level_temp == 2){
              setStat("w_rocks", getStat("w_rocks")-1);
            }else if(level_temp == 1){
              setStat("w_rocks_small", getStat("w_rocks_small")-1);
            }
            enemies.remove(e);
            updateStat("killedRocks");
          }
          if (enemy.getData()[0] > 1 || random(1) > this.piercingProbablility) {
            this.player.removeFromShots(s);
          }
          break;
        }
      }
    }

    if(this.player.getInvincible() > 0){
      return;
    }
    for (int e=enemies.size()-1; e>=0 ;e--) {
      Enemy enemy = enemies.get(e);
      if(enemy.isHit(this.player.getReferencePoints())){ //if player is hit by enemy
        int damage = 22 * (int)enemy.getData()[0];
        if(enemies.get(e).getHit()){ //if the enemy dies/ if it has no more lives
          enemies.remove(e);
          setStat("w_rocks", getStat("w_rocks")-1);
        }
        this.player.setInvincible(40); //to make it possible to escape the rock
        this.player.addLives(-damage);
        setStat("w_lives", this.player.getLives());
        break;
      }
    }
  }

  public void touchStarted()
  {
    if(stick.active_touch == -1 && touches[touches.length-1].x <= width/2){ //if the stick is not touched yet && the last touch is on the left side of the screen
      if(boolean(getStat("unlock_joystick"))){ //joystick unlocked setting
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

  public void touchEnded(){
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

    if(ended_touch_stick){
      stick.setActiveTouch(-1);
      stick.setActiveTouchPosition(stick.getX(),stick.getY());
    }
    if(ended_touch_shotButton){
      shotButton.setSelected(false);
      shotButton.setActiveTouch(-1);
    }
  }

  public void touchMoved(){
    for(int i=0;i<touches.length;i++){
      if(stick.active_touch == touches[i].id){
        stick.setActiveTouchPosition(touches[i].x,touches[i].y);
        player.setAngle(stick.getAngle());
      }
    }
  }

  public void goBack(){ //on BackPressed on (hardware) button on phone
    this.rockChildProbablility = 0;
    setWindow(1);
  }

  public void update(){}
}
