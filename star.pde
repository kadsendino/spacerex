class Star{
  float x, y, size;
  int brightness, growing;
  char type;
  boolean die;
  char[] types = {'+','x','*'};

  Star(){
    this.x = random(0, width);
    this.y = random(0, height);
    this.brightness = 1;
    this.size = int(random(height/25, height/15));
    this.type = types[int(random(0, 2))];
    this.growing = 8;
    this.die = false;
  }

  void show(){
    fill(this.brightness);
    textAlign(CENTER);
    textSize(this.size+(this.brightness/2));
    text(this.type, this.x, this.y);

    this.brightness += this.growing;
    if(this.brightness >= 200){
      this.growing *= -1;
      this.brightness = 200;
    }
    else if(this.brightness < 1){
      this.growing = 0;
      this.brightness = 0;
      this.die = true;
    }
  }

  boolean getDie(){
    return this.die;
  }
}
