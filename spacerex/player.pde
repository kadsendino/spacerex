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

    this.speed = 0;
    this.max_speed = 15;
    this.acceleration = 0;
    this.max_acceleration = 0.5;
    this.st = 4;

    this.shots = new ArrayList<Shot>();
    this.max_lives = 100;
    this.lives = max_lives;
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
      if(this.invincible > 0){
        fill(200);
      }
      rotate(angle);
      triangle(0, -(2*h)/3, -w, point_y, w, point_y);
    popStyle();
    popMatrix();

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
      }
    popStyle();
  }

  public void update(float acc){
    this.acceleration = this.max_acceleration * acc;
    if(this.acceleration > this.max_acceleration){
      this.acceleration = this.max_acceleration;
    }

    this.speed += this.acceleration;
    if(this.speed > this.max_speed){
      this.speed = this.max_speed;
    }

    this.updatePosition();
  }

  private void deaccelarate(){
    if(this.speed < this.max_acceleration){
      this.speed = 0;
    }
    else {
      this.speed -= this.max_acceleration;
    }

    this.updatePosition();
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
    }else if (this.x > width) {
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

    erg[0] = new PVector(0,0);
    erg[1]= new PVector(0-w, 0+h);
    erg[2]= new PVector(0+w, 0+h);

    for(int i=0; i<erg.length; i++){
      erg[i].sub( new PVector(0,(this.h*2)/3));
      erg[i].rotate(angle);
      erg[i].add(new PVector(x,y+(h*2/3)));
    }

    return erg;
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

  public ArrayList<Shot> getShots(){
    return this.shots;
  }

  public float getRegenerationProbability(){
    return this.regenerationProbability;
  }

  public void setLives(int lives){
    this.lives = lives;
  }
  public int getLives(){
    return this.lives;
  }
  public int getMaxLives(){
    return this.max_lives;
  }

  public int getInvincible(){
    return this.invincible;
  }
  public void setInvincible(int set){
    this.invincible = set;
  }

  public void addLives(int add){
    this.lives += add;
    if(this.lives > this.max_lives){
      this.lives = this.max_lives;
    }
  }

  public void removeFromShots(int s){
    this.shots.remove(s);
  }

  public void reduceSize(float value){
    this.w -= this.w * value;
    this.h -= this.h * value;
  }
}
