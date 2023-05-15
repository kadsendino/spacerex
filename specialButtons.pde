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
