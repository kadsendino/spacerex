class ClearedWave implements Window{
  private int nextWave;
  private int coolDown;

  ClearedWave(){
    this.nextWave = getWave()+1;
    setWave(nextWave); //save and set next wave
    this.setup();
  }

  void setup(){
    coolDown = 0;
  }

  void draw(){
    background(5,5,25);
    bg.drawStars();
    fill(255);
    textSize(height/13);
    text("PRESS TO PLAY NEXT WAVE: " + Integer.toString(nextWave),width/2,height/2);

    if(coolDown < 120){
        coolDown++;
    }
  }

  void touchStarted(){}

  void touchEnded(){
    if(coolDown >= 120){
      setWindow(0); //return to game
    }
  }

  void goBack(){
  setWindow(1);
  }

  void touchMoved(){}
}
