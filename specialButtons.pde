class ToggleButton extends Button{
  private Boolean toggle;
  private String secLabel;

  ToggleButton(float x, float y, float w, float h, String label, String secLabel){
    super(x, y, w, h, label);
    this.secLabel = secLabel; // label of the button changes when toggled
    this.toggle = false;
  }
  ToggleButton(float x, float y, float w, float h, String label){
    super(x, y, w, h, label);
    this.secLabel = label; //no change in label when toggled
    this.toggle = false;
  }

  void show(){
    if(!this.active){
      return;
    }
    super.show();

    if(this.toggle){
      pushStyle();
        noStroke();
        fill(secCol, 150);
        rect(this.x, this.y, this.w, this.h);
      popStyle();
    }
  }

  void toggle(){
    this.toggle = !this.toggle;

    String labelSave = this.label;
    this.label = this.secLabel;
    this.secLabel = labelSave;
  }

  boolean getToggle(){
    return this.toggle;
  }
}


class ImageButton extends Button{
  PImage image;
  ImageButton(float x, float y, float w, float h, PImage image){
    super(x, y, w, h, "");
    this.image = image;
    int resize = int(min(this.w, this.h)*9/10);
    this.image.resize(resize, resize); //image is allways square
  }

  public void show(){
    if(!this.active){
      return;
    }

    if(this.selected){
      pushStyle();
        noStroke();
        fill(secCol, 100);
        rect(this.x, this.y, this.w, this.h);
      popStyle();
    }

    imageMode(CENTER);
    image(this.image, this.x+this.w/2, this.y+this.h/2);
  }
}


class AnimationButton extends Button{
  PImage[] frames;
  int current_image, cooldown, framerate, counter; //current image in this.frames; time before animation restarts; time before next frame of animation; variable that gets filled up with the values of framerate and cooldown
  AnimationButton(float x, float y, float w, float h, String dir){
    super(x, y, w, h, "");
    this.cooldown = 160;
    this.framerate = 5;
    this.loadAnimation(dir);
    this.resizeImages(int(min(this.w, this.h)*9/10));
    this.current_image = 0;
    this.counter = this.cooldown/3;
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
      this.cooldown -= this.framerate;
    }
    if(this.cooldown <= 100){
      this.cooldown = 100;
    }
  }

  private void resizeImages(int size){
    for(int i=0; i<this.frames.length; i++){
      this.frames[i].resize(size, size);
    }
  }

  public void show(){
    if(!this.active){
      return;
    }

    if(this.selected){
      pushStyle();
          noStroke();
          fill(secCol, 100);
          rect(this.x, this.y, this.w, this.h);
      popStyle();
    }

    imageMode(CENTER);
    image(this.frames[this.current_image], this.x+this.w/2, this.y+this.h/2);
  }

  public void update(){
    this.counter--;
    if(this.counter <= 0){
      this.current_image++;
      if(this.current_image >= this.frames.length){
        this.current_image = 0;
        this.counter = this.cooldown;
        return;
      }
      this.counter = this.framerate;
    }
  }
}


private class PlayButton extends Button{
  float x1, y1, y2; //x1 = x2 -> redundat

  PlayButton(float x, float y, float size){
    super(x-size,y-size,size*2,"");

    this.x  = x+size;
    this.x1 = x-size;
    this.y  = y;
    this.y1 = y-size;
    this.y2 = y+size;
    this.st = size/30; //stroke
  }

  void show(){
    pushStyle();
      if(this.selected){
        fill(secCol, 200);
      }
      else{
        fill(primCol, 150);
      }
      stroke(secCol);
      strokeWeight(this.st);
      triangle(this.x, this.y, this.x1, this.y1, this.x1, this.y2);
    popStyle();
  }

  boolean mouseOver(float x,float y){
    return((this.x1<=x && this.x>=x) && (this.y1<=y && this.y2>=y));
  }
}
