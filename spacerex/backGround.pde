class BackGround{
  private ArrayList<Rock> rocks;
  private ArrayList<Star> stars;
  private ArrayList<AnimationI> animations;
  private int starCount; //random number how often a star twinkles in the background

  BackGround(){
    this.rocks = new ArrayList<Rock>();
    this.stars = new ArrayList<Star>();
    this.starCount = 40;
    Rock r;
    for(int i=0; i<6; i++) {
      r = new Rock(1,random(0,width),random(0,height),110);
      r.changeSpeed(0.3);
      this.rocks.add(r);
    }
    this.animations = new ArrayList<AnimationI>();
  }

  void draw(){
    background(5,5,25);

    this.drawStars();

    for(Rock r : this.rocks){
      r.update();
      r.show();
    }

    for(int i=this.animations.size()-1; i>=0; i--) {
      AnimationI a = this.animations.get(i);
      a.update();
      a.show();
      if(a.isOver()) {
        this.animations.remove(a);
      }
    }
  }

  public void drawStars(){
    this.starCount--;

    if(this.starCount <= 0){
      this.stars.add(new Star());
      this.starCount = int(random(10, 100));
    }
    
    for(int i=this.stars.size()-1; i>=0; i--){
      Star s = this.stars.get(i);
      s.update();
      s.show();
      if(s.getDie()){
        this.stars.remove(i);
      }
    }
  }

  void touch() {
    PVector[] p = new PVector[1];
    p[0] = new PVector(mouseX, mouseY);
    for(int i=this.rocks.size()-1; i>=0; i--){
      Rock r = this.rocks.get(i);
      if(r.isHit(p)) {
        float[] dataSave = r.getData();
        this.animations.add(new Animation(int(dataSave[3]*2), int(dataSave[3]*2), dataSave[1], dataSave[2], "rockExplosion"));
        this.rocks.remove(r);

        r = new Rock(1,random(-110, width+110), -110, 110);
        r.changeSpeed(0.3);
        this.rocks.add(r);
        return;
      }
    }
    this.stars.add(new Star(mouseX, mouseY));
  }
}
