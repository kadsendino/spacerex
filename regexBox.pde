class RegexBox{
  float x,y,w,h,st;

  RegexBox(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = width/240;
  }

  void show(){
    stroke(255);
    noFill();
    strokeWeight(st);
    rect(x,y,w,h);
  }


}