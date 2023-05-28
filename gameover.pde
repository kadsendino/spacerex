class Gameover implements Window{
  private int endWave;
  private int coolDown;

  Gameover(){
    this.endWave = getWave()-1;
    setWave(1);
    clearPlayerInventory();
    this.setup();
  }

  void setup(){
    coolDown = 0;
  }

  void draw(){
    background(5,5,25);
    pushStyle();
      fill(255);
      text("YOU SURVIVED: " + Integer.toString(this.endWave),width/2,height/2);
    popStyle();
    if(coolDown < 120){
      coolDown++;
    }
  }

  void touchStarted(){}

  void touchEnded(){
    if(coolDown >= 120){
      setWave(1);
      setWindow(1);
    }
  }

  void touchMoved(){}
  void goBack(){}
}
