class BackGround{
  ArrayList<Rock> rocks;
  ArrayList<Star> stars;
  //int breakCount;
  int starCount; //random number how often a star twinkles in the background

  BackGround(){
    this.rocks = new ArrayList<Rock>();
    this.stars = new ArrayList<Star>();
    //this.breakCount = 0;
    this.starCount = 40;
    Rock r;
    for(int i=0; i<4; i++) {
      r = new Rock(1,random(0,width),random(0,height),110);
      r.changeSpeed(0.3);
      this.rocks.add(r);
    }
  }

  void draw(){
    background(5,5,25);

    if(this.starCount <= 0){
      this.stars.add(new Star());
      this.starCount = int(random(10, 200));
    }
    this.starCount--;

    for(int i=this.stars.size()-1; i>=0; i--){
      Star s = this.stars.get(i);
      s.show();
      if(s.getDie()){
        this.stars.remove(i);
      }
    }

    for(Rock r : this.rocks){
      r.show();
      r.update();
    }

    /*if(this.breakCount >= 60) {
      this.rocks[int(random(0,this.rocks.lenght()))].
    }*/
  }
}
