interface AnimationI{
  void show();
  void update();
  boolean isOver();
}

class Animation implements AnimationI{
  private PImage[] frames;
  private float x, y; //x and y coordinates of the middle of theanimation images
  private int frame_delay, current_delay, current_frame; //frame_delay:how many frames pass until the next frame is drawn; current_delay:counts down and gets reset to frame_delay once it's 0
  //current_frame:which frame is currently drawn

  Animation(int w, int h, float x, float y, int type){
    this.x = x;
    this.y = y;
    this.current_frame = 0;
    this.frame_delay = 3;
    this.current_delay = this.frame_delay;

    // vv load individual images for different animations
    if(type == 0){ //rock explosion
      this.load_rockExplosion();
    }
    else{ //standart animation
      this.load_standart();
    }

    this.resizeImages(w, h);
  }

  private void resizeImages(int w, int h){
    for(int i=0; i<this.frames.length; i++){
      this.frames[i].resize(w, h);
    }
  }

  private void load_rockExplosion(){
    this.frames = new PImage[4];
    this.frames[0] = loadImage("rockExplosion1.png");
    this.frames[1] = loadImage("rockExplosion2.png");
    this.frames[2] = loadImage("rockExplosion3.png");
    this.frames[3] = loadImage("rockExplosion4.png");
  }
  private void load_standart(){
    this.frames = new PImage[1];
    this.frames[0] = loadImage("M1Productions.png");
  }

  void show(){
    image(this.frames[this.current_frame], this.x, this.y);
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
