class Achievement{
  private String name, testVariable;
  private int value; //value of testVariable to beat too comlete achievement
  private int progress;
  private float size, y;

  Achievement(String name, int value, String testVariable){
    this.name = name;
    this.value = value;
    this.testVariable = testVariable;
    this.progress = this.getTest();
    this.size = width/7;
    this.y = height/2;
  }

  public void show(float pos){
    pushStyle();
      rectMode(CENTER);
      rect(pos, this.y, this.size, this.size);
      rectMode(CORNER);
      fill(255);
      textSize(this.size/15);
      if(this.progress >= 100){
        text(this.name, pos, this.y);
      } else{
        text(this.progress+"%", pos, this.y);
      }
    popStyle();
  }

  private int getTest(){ //to test with other operators (> or ==) descend this class
    float ret = float(getStat(this.testVariable))/float(this.value)*100;
    if(ret > 100){
      ret = 100;
    }
    return int(ret);
  }
  public void test(){
    this.progress = this.getTest();
  }

  public int getProgress(){
    return this.progress;
  }
}
