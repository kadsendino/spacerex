class Upgrade{
  
  float x,y,w,h,st;

  Upgrade(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = 4;
  }

  show(){
    pushStyle();
    rectMode(CENTER);
    stroke(255);
    noFill();
    strokeWeight(st);
    rect(x,y,w,h);
    popStyle();
  }
}