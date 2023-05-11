class Animation implements AnimationI{
  PImage[] frames;
  float x, y; //x and y coordinates of the middle of theanimation images
  int frame_delay, current_delay, current_frame; //frame_delay:how many frames pass until the next frame is drawn; current_delay:counts down and gets reset to frame_delay once it's 0
  //current_frame:which frame is currently drawn

  Animation(int w, int h, float x, float y){
    this.x = x;
    this.y = y;
    this.current_frame = 0;
    this.frame_delay = 3;
    this.current_delay = this.frame_delay;

    this.frames = new PImage[1];
    PImage i = loadImage("M1Productions.png");
    i.resize(w, h);
    this.frames[0] = i;
  }
  Animation(int size, float x, float y){
    this.x = x;
    this.y = y;
    this.current_frame = 0;
    this.frame_delay = 3;
    this.current_delay = this.frame_delay;

    this.frames = new PImage[1];
    PImage i = loadImage("M1Productions.png");
    i.resize(size, size);
    this.frames[0] = i;
  }

  void show(){
    imageMode(CENTER);
    image(this.frames[this.current_frame], this.x, this.y);

    this.update();
  }

  void update(){
    this.current_delay--;
    if(this.current_delay<=0 && this.current_frame<this.frames.length-1){
      this.current_frame++;
      this.current_delay = frame_delay;
    }
  }

  boolean isOver(){
    return (this.current_frame >= this.frames.length-1 && this.current_delay <= 0);
  }
}

interface AnimationI{
  void show();
  boolean isOver();
}

class RockExplosion_Animation extends Animation implements AnimationI{
  RockExplosion_Animation(int w, int h, float x, float y){
    super(w, h, x, y);

    this.frames = new PImage[3];
    PImage i = loadImage("rockExplosion1.png");
    i.resize(w, h);
    this.frames[0] = i;
    i = loadImage("rockExplosion2.png");
    i.resize(w, h);
    this.frames[1] = i;
    i = loadImage("rockExplosion3.png");
    i.resize(w, h);
    this.frames[2] = i;
  }
  RockExplosion_Animation(int size, float x, float y){
    super(size, x, y);

    this.frames = new PImage[3];
    PImage i = loadImage("rockExplosion1.png");
    i.resize(size, size);
    this.frames[0] = i;
    i = loadImage("rockExplosion2.png");
    i.resize(size, size);
    this.frames[1] = i;
    i = loadImage("rockExplosion3.png");
    i.resize(size, size);
    this.frames[2] = i;
  }
}
