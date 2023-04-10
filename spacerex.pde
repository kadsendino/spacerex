
int window;

Window[] windows = new Window[1];
/*
0 = Game 

*/

void setup (){
  windows[0] = new Game();


  window = 0;
  fullScreen();
  background(100);

}

void draw () {
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