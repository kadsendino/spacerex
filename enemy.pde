interface Enemy{
    void show();
    void update();
    boolean isHit(PVector[] shot_points);
    boolean getHit(); //returns true if it dies
    int getEnemyID(); //0=rock
    PVector getPos();
    float[] getData();
}

class EnemyC{
  protected int enemyID; //0=rock
  protected float r; //outer radius
  protected PVector pos, vel; //position; velocity

  EnemyC(float x, float y, float r, int id){
    this.pos = new PVector(x, y); //sets position
    this.vel = PVector.fromAngle(random(0,TWO_PI)).normalize().mult(random(r/40,r/15));
    this.r = r;
    this.enemyID = id; //0 = rock
  }

  public void show(){}

  public void update(){
    this.pos.add(this.vel);

    //moves to the other side when it touches the border
    if(this.pos.x < -this.r){ //left screen edge
        this.pos.x = width+this.r;
    }
    else if (this.pos.x > width+this.r) { //right screen edge
        this.pos.x = -this.r;
    }

    if(this.pos.y < -this.r) { //upper screen edge
      this.pos.y = height+this.r;
    }
    else if (this.pos.y > height+this.r) { //lower screen edge
      this.pos.y = -this.r;
    }
  }

  public boolean getHit(){
    return true; //?
  }

  public int getEnemyID(){
    return this.enemyID;
  }

  public void changeSpeed(float multi){
    this.vel.mult(multi);
  }

  public PVector getPos(){
    return this.pos;
  }
  public float[] getData(){
    float[] erg  = new float[4];
    erg[0] = this.pos.x;
    erg[1] = this.pos.y;
    erg[2] = this.r;
    return erg;
  }
}
