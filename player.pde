class Player{
  private float x,y,w,h;
  private float speed;
  private float max_speed;
  private float max_acceleration;
  private float acceleration;
  private float angle;
  private int lives, invincible; //lives; cooldown after taking damage
  private int max_lives;
  private ArrayList<Shot> shots;
  private float st;
  private int cooldown;
  private int max_cooldown;
  private float regenerationProbability=0;

  Player(){
    this.x = width/2;
    this.y = height/2;
    this.w = height/32;
    this.h = height/12;
    this.angle = 0;

    speed = 0;
    max_speed = 15;
    acceleration = 0;
    max_acceleration = 0.5;
    this.st = 4;

    shots = new ArrayList<Shot>();
    max_lives = 100;
    lives = max_lives;
    this.invincible = 0;
    this.max_cooldown = 15;
    this.cooldown = 0;
  }
  Player(int lives){
    this();
    this.lives = lives;
  }

  public void show(){
    float point_y = h/3;

    pushMatrix();
    pushStyle();
      strokeWeight(st);
      translate(x,y+(2*h)/3);
      stroke(240);
      noFill();
      if(this.invincible > 0){
        fill(200);
      }
      rotate(angle);
      triangle(0, -(2*h)/3, -w, point_y, w, point_y);
    popMatrix();
    popStyle();

    for (int i = 0; i < shots.size(); ++i) {
      shots.get(i).show();
    }

    if(this.invincible > 0){
      this.invincible--;
    }

    if(this.cooldown > 0){
      cooldown--;
    }

  }

  public void showLives(){
    pushStyle();
      if(this.lives > 0){
        float livesWidth = map(this.lives,0,this.max_lives,0,height/4);
        if(this.invincible > 0){
          fill(255, 200);
        }
        else{
          fill(255,50,128,200);
        }
        rect(height/16,height/16,livesWidth,height/16);

        fill(80,80,80,120);
        rect(height/16, height/16, height/4, height/16);
      popStyle();
    }
  }

  public void update(float acc){
    acceleration = max_acceleration * acc;
    if(acceleration > max_acceleration){
      acceleration = max_acceleration;
    }

    speed += acceleration;
    if(speed > max_speed){
      speed = max_speed;
    }

    this.updatePosition();
  }

  private void deaccelarate(){
    if(speed < max_acceleration){
      speed = 0;
    }
    else {
      speed -= max_acceleration;
    }

    this.updatePosition();
  }

  void handleEnemies(ArrayList<Enemy> enemies, ArrayList<AnimationI> animations){ //if player is hit
    for (int s = shots.size()-1; s>=0; s--) { //checks every shot
      for (int e = enemies.size()-1; e>=0; e--) { //checks every enemy
        Enemy enemy = enemies.get(e);
        if(enemy.isHit(shots.get(s).getReferencePoints())){ //if the enemy is hit by the shot
          if(enemy.getHit()){ //if the enemy dies/ if it has no more lives
            if(enemy.getEnemyID() == 0){ //if enemy is a rock
              float[] saveData = enemy.getData();
              if((int) saveData[0] > 1){ //rock is big enough to spawn smaler rocks
                if(rockChildProbablility <= random(1)){
                  enemies.add(new Rock(((int) saveData[0])-1,saveData[1], saveData[2], saveData[3]/2)); //spawn two smaller rocks
                  setStat("w_rocks", getStat("w_rocks")+1);
                }
                if(rockChildProbablility <= random(1)){
                  enemies.add(new Rock(((int) saveData[0])-1,saveData[1], saveData[2], saveData[3]/2)); //spawn two smaller rocks
                  setStat("w_rocks", getStat("w_rocks")+1);
                }
              }
              animations.add(new Animation(int(saveData[3])*2, int(saveData[3])*2, saveData[1], saveData[2], "rockExplosion")); //rock explosion animation
            }
            if(this.regenerationProbability > random(1)){
              this.lives += this.max_lives/getStat("wave");
              if(lives > max_lives){
                this.lives = max_lives;
              }
              setStat("w_lives", this.lives);
            }
            enemies.remove(e);
            updateStat("killedRocks");
            setStat("w_rocks", getStat("w_rocks")-1);
          }
          shots.remove(s);
          break;
        }
      }
    }

    if(this.invincible > 0){
      return;
    }
    for (int e=enemies.size()-1; e>=0 ;e--) {
      if(enemies.get(e).isHit(this.getReferencePoints())){ //if player is hit by enemy
        if(enemies.get(e).getHit()){ //if the enemy dies/ if it has no more lives
          enemies.remove(e);
          setStat("w_rocks", getStat("w_rocks")-1);
          //no statistic changes here
        }
        this.invincible = 40; //to make it possible to escape the rock
        this.lives -= 40;
        setStat("w_lives", this.lives);
        break;
      }
    }
  }

  private void updatePosition(){
    PVector pos = new PVector(x,y);
    PVector change = PVector.fromAngle(angle - PI*0.5).mult(speed);
    pos.add(change);
    this.x = pos.x;
    this.y = pos.y;

    for (int i = shots.size()-1; i >= 0; i--) {
     shots.get(i).update();

     if(shots.get(i).outside()) {
      shots.remove(i);
     }
    }


    if(this.x < 0) {
      this.x = width + this.x;
    }
    else if (this.x > width) {
      this.x -= width;
    }

    if(this.y +(this.h*2)/3 < 0) {
      this.y = height + this.y;
    }
    else if (this.y +(this.h*2)/3 > height) {
      this.y -= height;
    }
  }

  private void setAngle(float angle){
    this.angle = angle;
  }

  private void shoot(){
    if(cooldown <= 0){
      PVector pos = new PVector(this.x,this.y+(this.h*2)/3);
      pos.add(PVector.fromAngle(angle - PI*0.5).normalize().mult((this.h*2)/3));
      float shot_speed = max_speed*2;
      color col = color(255);

      cooldown = max_cooldown;
      shots.add(new Shot(pos.x,pos.y,st*1,st*6,col,PVector.fromAngle(angle - PI*0.5).normalize(),shot_speed));
      updateStat("shotsFired");
    }
  }

  private PVector[] getReferencePoints(){
    PVector[] erg =  new PVector[3];
    PVector front = PVector.fromAngle(angle - PI*0.5).normalize();
    PVector center = new PVector(x,y+(this.h*2)/3);
    float edge_length;

    for (int i = 0; i < erg.length; i++) {
      center = new PVector(x,y+(this.h*2)/3);
      edge_length = (this.h*2)/3;
      erg[i] = PVector.add(center,front.mult(edge_length).rotate(((float) i/(float) erg.length)*TWO_PI));
      front.normalize();
    }
    return erg;
  }

  public int getLives(){
    return this.lives;
  }

  public void increaseMaxLives(float fraction){
    this.max_lives += this.max_lives * fraction;
    this.lives = max_lives;
  }

  public void reducesCooldown(float fraction){
    this.max_cooldown -= this.max_cooldown * fraction;
  }

  public void increaseMaxSpeed(float fraction){
    this.max_speed += this.max_speed * fraction;
  }

  public void increaseRegenerationProbability(float fraction){
    if (this.regenerationProbability == 0) {
      this.regenerationProbability = fraction;
    } else {
      this.regenerationProbability += this.regenerationProbability * fraction;
    }
  }

  public void reduceSize(float value){
    this.w -= this.w value;
    this.h -= this.h value;
  }
}
