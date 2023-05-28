class Button{
  protected float x, y, w, h, st;
  protected String label;
  protected Boolean selected;
  protected color primCol;
  protected color secCol;
  protected int active_touch;

  Button(float x, float y, float w, String label){ //button is a square
    this.setup(x, y, w, w, label);
  }
  Button(float x, float y, float w, float h, String label){
    this.setup(x, y, w, h, label);
  }

  private void setup(float x, float y, float w, float h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = this.h/20;
    this.label = label;
    this.active_touch = -1;
    this.selected = false;
    this.primCol = color(230, 230, 230);
    this.secCol = color(255,255,255);
  }

  public void show(){
    strokeWeight(this.st);

    pushStyle();
      stroke(secCol);
      fill(primCol,150);
      rect(this.x, this.y, this.w, this.h);

      fill(secCol);
      textSize(this.h/3);
      text(this.label, this.x+this.w/2, this.y+this.h/2);

      if(this.selected){
        noStroke();
        fill(secCol, 100);
        rect(this.x, this.y, this.w, this.h);
      }
    popStyle();
  }

  public boolean mouseOver(float x,float y){
    return((this.x<=x && this.x+this.w>=x) && (this.y<=y && this.y+this.h>=y));
  }

  public void setSelected(boolean selected){
    this.selected = selected;
  }
  public Boolean getSelected() {
    return this.selected;
  }

  public void setActiveTouch(int i){
    this.active_touch = i;
    if(i == -1){ //if there is no active touch
      this.selected = false;
    }
  }

  public int getActiveTouch(){
    return this.active_touch;
  }

  public void setLabel(String newLabel){
    this.label = newLabel;
  }
}
