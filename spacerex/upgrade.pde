class Upgrade{
  private int id;
  private String name, description;
  private PImage image;
  private float x, y, size;
  private boolean selected;
  private int number;

  Upgrade(float x, float y, float size, int id, String name, String image, String description){ //Uneqipped Upgrades
    this.x = x;
    this.y = y;
    this.size = size;
    this.id = id;
    this.name = name;
    this.number = 1;
    try{
      this.image = loadImage("upgrades/"+image);
    }
    catch(IllegalArgumentException e){
      this.image = loadImage("error.png");
    }
    this.image.resize(int(this.size), int(this.size));
    this.description = description;
    this.selected = false;
  }

  Upgrade(float x, float y, float size, int id, String name, String image, String description, int number){ //Eqipped Uprades
    this.x = x;
    this.y = y;
    this.size = size;
    this.id = id;
    this.name = name;
    this.number = number;
    try{
      this.image = loadImage("upgrades/"+image);
    }catch(IllegalArgumentException e){
      this.image = loadImage("error.png");
    }
    this.image.resize(int(this.size), int(this.size));
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
        rect(this.x, this.y, this.size, this.size);
      popStyle();
    }

    if(this.number > 1){
      pushStyle();
        fill(255,255,0);
        textAlign(RIGHT);
        textSize(height/30);
        text(Integer.toString(this.number), this.x+this.size/2, this.y+this.size/2);
      popStyle();
    }
  }

  public boolean isMouseOver(float x, float y){
    return((this.x-this.size/2<=x && this.x+this.size/2>=x) && (this.y-this.size/2<=y && this.y+this.size/2>=y));
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
  public String getFullId(){
    return Integer.toString(this.id)+","+Integer.toString(this.number);
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

  public String getName(){
    return this.name;
  }
  public String getDescription(){
    return this.description;
  }

  public void setImage(PImage img){
    this.image = img;
  }
  public PImage getImage(){
    return this.image; //this is a rezised version of the image so potentially it is a little compressed
  }
}
