class A extends Menu implements Window{
  Button a_button; //add a custom button

  A(){ //constructor: when menu is created
    super(); //creating back button
    this.back_window = 0; //returns to main menu when back button is clicked
    this.a_button = new Button(width/2-width/10, height/4, width/5, height/5, "a"); //set the position and size variables for custom button and the title to "a"
  }

  void draw(){ //draw loop, gets cyceled through once every frame
    super.draw(); //draw background and back button
    //^ has to be first ^

    this.a_button.show(); //draw the custom button on the sreen
  }

  void touchStarted(){ //every time you put a finger onto the screen, this function gets called
    if(this.a_button.mouseOver(mouseX, mouseY)){ //if the finger is over the custom button
      this.a_button.setSelected(true); //change button's color and prepare for touchEnded
    }
    
    //v has to be last v
    else{
      super.touchStarted(); //tests the back button
    }
  }

  void touchEnded(){ //gets called when any finger is lifted from the screen
    if(this.a_button.mouseOver(mouseX, mouseY) && this.a_button.getSelected()){
      window = 0; //main menu
    }

    //v has to be last v
    else {
      super.touchEnded(); //tets for back button click
    }
    this.a_button.setSelected(false); //unselect the custom
  }

  //vv not used but they have to be here because the interface needs them vv
  void setup(){} //renew certain variables or values set e.g. if the menu gets used in different cases
  void touchMoved(){} //when you move the finger
}
