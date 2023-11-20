float rockChildProbablility=0;

class Rock extends EnemyC implements Enemy{
  private int level;
  private int anz_points;
  private PVector[] points;
  private float st; //strokeWeight

  Rock(int level, float x, float y, float r){
    super(x, y, r, 0); //sets velocity and more

    this.level = level;
    this.anz_points = 12;
    this.st = 8; //sets stoke width

    this.points = new PVector[anz_points];

    for (int i = 0; i < this.anz_points; i++) {
      float radius = r;
      float rand = random(1);
      if(rand < 0.4){
        radius = r/2; //inner circle
      }
      else {
        radius = r; //outer circle
      }

      rand = random(-radius/8,radius/8) + random(-radius/8,radius/8);
      this.points[i] = PVector.fromAngle(((float) i/ (float) this.anz_points) * TWO_PI).normalize().mult(radius+rand).add(this.pos);
    }
  }

  void show(){
    pushStyle();
      //fill(5,5,25);
      strokeWeight(st);
      strokeJoin(BEVEL);

      beginShape();
      for (int i = 0; i < this.anz_points; i++) {
        vertex(this.points[i].x,this.points[i].y);
      }
      endShape(CLOSE);
    popStyle();
  }

  void update(){
    this.pos.add(this.vel);
    for(int i=0; i<this.anz_points; i++){
      this.points[i].add(this.vel);
    }

    //moves to the other side when it touches the border
    if(this.pos.x < -this.r){ //left screen edge
      this.pos.x += width+this.r*2;
      for(int i=0; i<this.anz_points; i++){
        this.points[i].x += width+this.r*2;
      }
    }
    else if (this.pos.x > width+this.r) { //right screen edge
      this.pos.x -= width+this.r*2;
      for(int i=0; i<this.anz_points; i++){
        this.points[i].x -= width+this.r*2;
      }
    }

    if(this.pos.y < -this.r) { //upper screen edge
      this.pos.y += height+this.r*2;
      for(int i=0; i<this.anz_points; i++){
        this.points[i].y += height+this.r*2;
      }
    }
    else if (this.pos.y > height+this.r) { //lower screen edge
      this.pos.y -= height+this.r*2;
      for(int i=0; i<this.anz_points; i++){
        this.points[i].y -= height+this.r*2;
      }
    }
  }

  float[] getData(){
    float[] erg  = new float[4];
    erg[0] = (float) (level);
    erg[1] = this.pos.x;
    erg[2] = this.pos.y;
    erg[3] = this.r;
    return erg;
  }

  boolean isHit(PVector[] shot_points){

    for (int p = 0; p<shot_points.length; p++) {
      int p_next = (p+1) % shot_points.length;

      PVector p1 = shot_points[p];
      PVector p2 = shot_points[p_next];

      for (int i = 0; i < this.anz_points-1; i++) {
        // vv u dont give the vecto itself because a change in the intersect() function could cause the vector itself to change (call by reference)
        PVector p3 = new PVector(this.points[i].x, this.points[i].y);
        PVector p4 = new PVector(this.points[i+1].x, this.points[i+1].y);
        if(intersect(p1,p2,p3,p4)){
          return true;
        }
      }

    }

    PVector p1 = shot_points[0];
    PVector p2 = new PVector(width*2, shot_points[0].y);
    if(p1.x >= this.pos.x-this.r){
      int counter = 0;

      for (int i = 0; i < this.anz_points-1; i++) {
        // vv u dont give the vecto itself because a change in the intersect() function could cause the vector itself to change (call by reference)
        PVector p3 = new PVector(this.points[i].x, this.points[i].y);
        PVector p4 = new PVector(this.points[i+1].x, this.points[i+1].y);
        if(intersect(p1,p2,p3,p4)){
          counter++;
        }
      }
      PVector p3 = new PVector(this.points[this.anz_points-1].x, this.points[this.anz_points-1].y);
      PVector p4 = new PVector(this.points[0].x, this.points[0].y);
      if(intersect(p1,p2,p3,p4)){
        counter++;
      }

      if(counter%2 == 1){
        return true;
      }
    }

    return false;
  }
}
