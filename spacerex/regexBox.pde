class RegexBox{
  float x,y,w,h;

  RegexBox(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void show(){
    rect(x,y,w,h);
  }
}
