
int window;
int touchLength;

Window[] windows = new Window[1];
/*
0 = Game 

*/

void setup (){
  windows[0] = new Game();
  touchLength = 0;

  window = 0;
  fullScreen();
  background(100);

}

void draw () {
  if(touches.length < touchLength){
    for (int i = 0; i < touchLength-touchLength; i++) {
      touchEnded();
    }
  }
  touchLength = touches.length;

  windows[window].draw();
}

void touchStarted(){
  windows[window].touchStarted();
}

void touchEnded(){
  windows[window].touchEnded();
}

void touchMoved(){
  windows[window].touchMoved();
}