class Rock implements Enemy{
  float x,y,r;
  int level;
  int anz_points;
  PVector[] points;
  PVector vel;
  float st;
  int enemyID=0;

  Rock(int level, float x, float y, float r){
    this.x = x;
    this.y = y;
    this.r = r;
    this.level = level;
    this.anz_points = 12;
    this.st = 8;
    this.vel = PVector.fromAngle(random(0,TWO_PI)).normalize().mult(random(r/32,r/16));

    this.points = new PVector[anz_points];

    for (int i = 0; i < this.anz_points; i++) {
      PVector pos = new PVector(x,y);
      float radius = r;
      float rand = random(1,100);
      if(rand < 40){
        //inner circle
        radius = r/2;
      }
      else {
        //outer circle
        radius = r;
      }

      rand = random(-radius/8,radius/8) + random(-radius/8,radius/8);
      points[i] = pos.add(PVector.fromAngle(((float) i/ (float) this.anz_points) * TWO_PI).normalize().mult(radius+rand));
    }
  }

  void show(){
    stroke(255);
    strokeWeight(st);
    noFill();
    beginShape();
    for (int i = 0; i < this.anz_points; i++) {
      vertex(this.points[i].x,this.points[i].y);
    }
    endShape(CLOSE);
  }

  void update(){
    //moves all points and centerpoint by velocity Vector
    PVector pos = new PVector(this.x,this.y);
    pos.add(vel);
    this.x = pos.x;
    this.y = pos.y;

    //moves rock to the other side when it touches the border
    if(this.x < 0)
    {
      this.x = width + this.x;
      for (int i = 0; i < this.anz_points ;i++) {
        points[i].x += width;
      }
    }
    else if (this.x > width) {
      this.x -= width;
      for (int i = 0; i < this.anz_points ;i++) {
        points[i].x -= width;
      }
    }

    if(this.y < 0)
    {
      this.y = height + this.y;
      for (int i = 0; i < this.anz_points ;i++) {
        points[i].y += height;
      }
    }
    else if (this.y > height) {
      this.y -= height;
      for (int i = 0; i < this.anz_points ;i++) {
        points[i].y -= height;
      }
    }

    //moves points in direction
    for (int i = 0; i < this.anz_points ;i++) {
      points[i].add(vel);
    }
  }

  void changeSpeed(float multi){
    this.vel.mult(multi);
  }

  boolean getHit(){
    return true;
  }

  int getEnemyID(){
    return this.enemyID;
  }

  float[] getData(){
    float[] erg  = new float[4];
    erg[0] = (float) (level);
    erg[1] = x;
    erg[2] = y;
    erg[3] = r;
    return erg;
  }

  boolean isHit(PVector[] shot_points){
    for (int p = 0;p<shot_points.length;p++) {
      PVector p1 = shot_points[p];
      PVector p2 = new PVector(width*2,shot_points[p].y);
      int counter = 0;

      for (int i = 0; i < this.anz_points-1; i++) {
        PVector p3 = points[i];
        PVector p4 = points[i+1];
        if(intersect(p1,p2,p3,p4)){
          counter++;
        }
      }

      PVector p3 = points[this.anz_points-1];
      PVector p4 = points[0];
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

//chatgpt generated intersection funtion of two lines
boolean intersect(PVector p1, PVector p2, PVector p3, PVector p4) {
  // Calculate slopes of the two lines
  float slope1 = (p2.y - p1.y) / (p2.x - p1.x);
  float slope2 = (p4.y - p3.y) / (p4.x - p3.x);

  // If the slopes are equal, the lines are parallel and do not intersect
  if (slope1 == slope2) {
    return false;
  }

  // Calculate y-intercepts of the two lines
  float yIntercept1 = p1.y - slope1 * p1.x;
  float yIntercept2 = p3.y - slope2 * p3.x;

  // Calculate x-coordinate of the point of intersection
  float xIntersect = (yIntercept2 - yIntercept1) / (slope1 - slope2);

  // Check if the x-coordinate of the point of intersection lies within the range of the x-coordinates of the two line segments
  if ((xIntersect >= min(p1.x, p2.x) && xIntersect <= max(p1.x, p2.x))
    && (xIntersect >= min(p3.x, p4.x) && xIntersect <= max(p3.x, p4.x))) {
    return true;
  }

  return false;
}
