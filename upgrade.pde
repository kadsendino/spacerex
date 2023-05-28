class Upgrade{
  private int id, level;
  private String name, description;
  private PImage image;
  private float x,y,w,h;
  private boolean selected;

  Upgrade(float x, float y, float w, float h, int id, String name, String image, String description, int level){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = 4;
    this.id = id;
    this.name = name;
    this.image = loadImage(image);
    this.image.resize(int(this.w), int(this.h));
    this.description = description;
    this.level = level;
    this.selected = false;
  }

  public void show(){
    image(this.image, x, y);
  }

  public boolean isMouseOver(float x, float y){
    return((this.x<=x && this.x+this.w>=x) && (this.y<=y && this.y+this.h>=y));
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
