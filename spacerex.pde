
int window;

int[] windows = int[1]
/*
0 = Game 

*/

void setup (){
  windows[0] = new Game();


  window = 0;
  fullscreen();
  background(100);

}

void draw () {
  windows[window].draw();
}
