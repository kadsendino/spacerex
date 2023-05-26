class UpgradeBox{
  float x,y,w,h,st;

  UpgradeBox(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = w/50;
  }

  void show(){
    stroke(255);
    noFill();
    strokeWeight(st);
    rect(x,y,w,h);
  }


}