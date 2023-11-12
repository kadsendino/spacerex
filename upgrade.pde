class Upgrade{
  private int id;
  private String name, description;
  private PImage image;
  private float x,y,w,h;
  private boolean selected;
  private int number;

  Upgrade(float x, float y, float w, float h, int id, String name, String image, String description){ //Uneqipped Upgrades
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.id = id;
    this.name = name;
    this.number=1;
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
    
  Upgrade(float x, float y, float w, float h, int id, String name, String image, String description,int number){ //Eqipped Uprades
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.id = id;
    this.name = name;
    this.number = number;
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
    pushStyle();
      fill(255);
      textSize(height/10);
      strokeWeight(4);
      text(Integer.toString(this.number),this.x,this.y);
    popStyle();
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

  public int getNumber(){
    return this.number;
  }

  public void decreaseNumber(){
    this.number--;
  }

  public void increaseNumber(){
    this.number++;
  }
}
