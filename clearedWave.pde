class ClearedWave implements Window{

    int nextWave;
    int coolDown;

    ClearedWave(int nextWave){
        this.nextWave = nextWave;
        this.setup();
    }

  void setup(){
    coolDown = 0
  }

  void draw(){
    background(5,5,25);
    fill(255);
    text("PRESS TO PLAY NEXT WAVE: " + Integer.toString(nextWave),width/2,height/2);

    if(coolDown < 300){
        coolDown++;
    }
    
  }
  
  void touchStarted(){}
  
  void touchEnded(){
    if(coolDown >= 300){
        // Write data to SharedPreferences
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putInt("wave", this.nextWave);
        editor.commit();

        windows[0] = new Game();
        window = 0;
    }

  }
  
  void touchMoved(){}
  void goBack(){}
}