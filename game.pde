class Game implements Window
{
  Joystick stick;

  Game(){
    this.setup();
  }

  void setup(){
    stick = new Joystick();
  }

  void draw(){
    fill(255, 0, 0);
    ellipse(width/2, height/2, 400,400);

    stick.show();
  }

}