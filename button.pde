class Button{
  protected float x, y, w, h, st;
  protected int corner1, corner2, corner3, corner4; //how round the corners are
  protected String label="";
  protected Boolean selected=false;
  protected color primCol = color(230, 230, 230);
  protected color secCol = color(255,255,255);
  protected int active_touch;

  Button(float x, float y, float w, String label){ //button is a square
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = w;
    this.st = this.h/20;
    this.label = label;
    this.active_touch = -1;
  }
  Button(float x, float y, float w, float h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = this.h/20;
    this.label = label;
    this.active_touch = -1;
  }

  void show(){
    stroke(secCol);
    strokeWeight(this.st);
    fill(primCol,150);
    rectMode(CORNER);
    rect(this.x, this.y, this.w, this.h, corner1, corner2, corner3, corner4);

    fill(secCol);
    textAlign(CENTER, CENTER);
    textSize(this.h/3);
    text(this.label, this.x+this.w/2, this.y+this.h/2);

    if(this.selected){
      noStroke();
      fill(secCol, 100);
      rect(this.x, this.y, this.w, this.h, corner1, corner2, corner3, corner4);
    }
  }

  boolean mouseOver(float x,float y)
  { return((this.x<=x && this.x+this.w>=x) && (this.y<=y && this.y+this.h>=y)); }

  void setSelected(boolean selected){
    this.selected = selected;
  }

  Boolean getSelected() {
    return this.selected;
  }

  void setActiveTouch(int i){
    this.active_touch = i;
    if(i == -1){ //if there is no active touch
      this.selected = false;
    }
  }

  int getActiveTouch(){
    return this.active_touch;
  }

  void setLabel(String newLabel){
    this.label = newLabel;
  }
}
