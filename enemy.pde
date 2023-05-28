interface Enemy{
    void show();
    void update();
    boolean isHit(PVector[] shot_points);
    boolean getHit(); //returns true if it dies
    int getEnemyID();
    float[] getData();
}

class EnemyC{
  protected int enemyID; //0=rock
  protected float r; //outer radius
  protected PVector pos, vel; //position; velocity

  EnemyC(float x, float y, float r){
    this.pos = new PVector(x, y); //sets position
    this.vel = PVector.fromAngle(random(0,TWO_PI)).normalize().mult(random(r/40,r/15));
    this.r = r;
    this.enemyID = 0; //rock
  }

  void show(){
    strokeWeight(30);
    pushStyle();
      fill(5,5,25);
    popStyle();
    point(this.pos.x, this.pos.y);
  }

  void update(){
    this.pos.add(this.vel);

    //moves to the other side when it touches the border
    if(this.pos.x < 0-this.r){
        this.pos.x = width+this.r;
    }
    else if (this.pos.x > width+this.r) {
        this.pos.x = -this.r;
    }

    if(this.pos.y < 0-this.r) {
      this.pos.y = height+this.r;
    }
    else if (this.pos.y > height+this.r) {
      this.pos.y = -this.r;
    }
  }

  boolean getHit(){
    return true; //?
  }

  int getEnemyID(){
    return this.enemyID;
  }

  void changeSpeed(float multi){
    this.vel.mult(multi);
  }

  float[] getData(){
    float[] erg  = new float[4];
    erg[0] = this.pos.x;
    erg[1] = this.pos.y;
    erg[2] = this.r;
    return erg;
  }
}
