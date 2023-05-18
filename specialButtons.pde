class ToggleButton extends Button{
  private Boolean toggle = false;
  private String secLabel="";

  ToggleButton(float x, float y, float w, float h, String label, String secLabel){
    super(x, y, w, h, label);
    this.secLabel = secLabel; // label of the button changes when toggled
  }
  ToggleButton(float x, float y, float w, float h, String label){
    super(x, y, w, h, label);
    this.secLabel = label; //no change in label when toggled
  }

  void show(){
    super.show();

    if(this.toggle){
      noStroke();
      fill(secCol, 150);
      rect(this.x, this.y, this.w, this.h);
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
    super.show();
    imageMode(CENTER);
    image(this.image, this.x+this.w/2, this.y+this.h/2);
  }
}

class AnimationButton extends Button{
  PImage[] frames;
  int current_image, cooldown, framerate, counter; //current image in this.frames; time before animation restarts; time before next frame of animation; variable that gets filled up with the values of framerate and cooldown
  AnimationButton(float x, float y, float w, float h, PImage[] frames){
    super(x, y, w, h, "");
    this.frames = frames;
    this.resizeImages(int(min(this.w, this.h)*9/10));
    this.current_image = 0;
    this.cooldown = 120;
    this.framerate = 5;
    this.counter = this.cooldown;
  }

  private void resizeImages(int size){
    for(int i=0; i<this.frames.length-1; i++){
      this.frames[i].resize(size, size);
    }
  }

  public void show(){
    super.show();
    imageMode(CENTER);
    image(this.frames[this.current_image], this.x+this.w/2, this.y+this.h/2);
  }

  public void update(){
    this.counter--;
    if(this.counter <= 0){
      this.current_image++;
      if(this.current_image >= this.frames.length-1){
        this.current_image = 0;
        this.counter = this.cooldown;
        return;
      }
      this.counter = this.framerate;
    }
  }
}
