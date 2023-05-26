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
      if(this.selected){
        fill(secCol, 200);
      }
      else{
        fill(primCol, 150);
      }
      stroke(secCol);
      strokeWeight(this.st);
      triangle(this.x, this.y, this.x1, this.y1, this.x1, this.y2);
    }

    boolean mouseOver(float x,float y){
      return((this.x1<=x && this.x>=x) && (this.y1<=y && this.y2>=y));
    }
  }