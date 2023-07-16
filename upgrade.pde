class Upgrade{
  private int id;
  private String name, description;
  private PImage image;
  private float x,y,w,h;
  private boolean selected;

  Upgrade(float x, float y, float w, float h, int id, String name, String image, String description){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.id = id;
    this.name = name;
    try{
      this.image = loadImage("upgrades/"+image);
    }
    catch(IllegalArgumentException e){
      this.image = loadImage("error.png");
    }
    this.image.resize(int(this.w), int(this.h));
    this.description = description;
    this.selected = false;
  }

  public void show(){
    image(this.image, x, y);

    if(this.selected){
      pushStyle();
        noStroke();
        fill(255, 90);
        rectMode(CENTER);
        rect(this.x, this.y, this.w, this.h);
      popStyle();
    }
  }

  public boolean isMouseOver(float x, float y){
    return((this.x-this.w/2<=x && this.x+this.w/2>=x) && (this.y-this.h/2<=y && this.y+this.h/2>=y));
  }

  public void setSelected(boolean state){
    this.selected = state;
  }
  public boolean getSelected(){
    return this.selected;
  }

  public int getId(){
    return this.id;
  }
}
