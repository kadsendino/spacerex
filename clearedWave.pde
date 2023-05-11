class ClearedWave implements Window{

    int nextWave;
    int coolDown;

    ClearedWave(){
        this.nextWave = getWave()+1;
        this.setup();
    }

  void setup(){
    coolDown = 0;
  }

  void draw(){
    background(5,5,25);
    fill(255);
    text("PRESS TO PLAY NEXT WAVE: " + Integer.toString(nextWave),width/2,height/2);

    if(coolDown < 120){
        coolDown++;
    }
    
  }
  
  void touchStarted(){}
  
  void touchEnded(){
    if(coolDown >= 120){
        setWave(nextWave);

        setWindow(0);
    }

  }
  
  void touchMoved(){}
  void goBack(){}
}