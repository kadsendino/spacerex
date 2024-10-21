class Joystick{
  private float x,y,r;
  private float stick_r;
  private int active_touch;
  private float active_touch_x, active_touch_y;

  Joystick(){
    this.r = width/3.5 - width/10;
    this.x = r/2 + width/21;
    this.y = height - this.x;
    this.stick_r = r/3;
    this.active_touch = -1;
    this.active_touch_x = x;
    this.active_touch_y = y;
  }

  public void show(){
    float x_temp = this.active_touch_x;
    float y_temp = this.active_touch_y;
    pushStyle();
      ellipseMode(CENTER);

      fill(230,230,230,150);
      ellipse(x,y,r,r);

      fill(80,80,80,150);
      ellipse(x_temp, y_temp, stick_r, stick_r);
    popStyle();
  }

  public void setPositions(float x,float y){
    this.x = x;
    this.y = y;
    this.active_touch_x = x;
    this.active_touch_y = y;
  }

  public void setActiveTouch(int i){
    this.active_touch = i;
  }

  public void setActiveTouchPosition(float x,float y){
    this.active_touch_x = x;
    this.active_touch_y = y;

    PVector v1 = new PVector(this.x,this.y);
    PVector v2 = new PVector(active_touch_x,active_touch_y);
    float distance = v1.dist(v2);
    if(distance > r*0.5){
      PVector v = v1.sub(v2).normalize().mult(this.r*(-0.5));
      active_touch_x = this.x + v.x;
      active_touch_y = this.y + v.y;
    }
  }

  public int getActiveTouch(){
    return this.active_touch;
  }

  public float getX(){
    return this.x;
  }

  public float getY(){
    return this.y;
  }

  public float getAngle(){
    PVector v1 = new PVector(this.x,this.y);
    PVector v2 = new PVector(this.active_touch_x, this.active_touch_y);
    PVector v = v1.sub(v2).normalize().mult(-1);
    return PI*0.5 + v.heading();
  }

  public float getDist(){
    PVector v1 = new PVector(this.x,this.y);
    PVector v2 = new PVector(this.active_touch_x, this.active_touch_y);
    float distance = v1.dist(v2);
    if(distance > r*0.5){
      return 1;
    }
    return distance/(r*0.5);
  }
}
