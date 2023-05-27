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

  Animation(int w, int h, float x, float y, String dir){
    this.x = x;
    this.y = y;
    this.current_frame = 0;
    this.frame_delay = 3;
    this.current_delay = this.frame_delay;

    this.loadAnimation(dir);

    this.resizeImages(w, h);
  }

  private void resizeImages(int w, int h){
    for(int i=0; i<this.frames.length; i++){
      this.frames[i].resize(w, h);
    }
  }

  private void loadAnimation(String dir){
    ArrayList<PImage> frames_temp = new ArrayList<PImage>();
    for(int i=1; i>0; i++){ //effectively a while(true) but with i to be used in path
      try{
        frames_temp.add(loadImage(dir+"/"+dir+i+".png"));
      }
      catch(Exception e){
        if(frames_temp.size() == 0){
          frames_temp.add(loadImage("error.png")); //to have at least one frame
        }
        break;
      }
    }

    this.frames = new PImage[frames_temp.size()];
    for(int i=0; i<frames_temp.size(); i++){
      this.frames[i] = frames_temp.get(i);
    }
  }

  void show(){
    imageMode(CENTER);
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
