class Star{
  private float x, y, size; //coordinates and size of the satr
  private int brightness, growing; //transparancy value of stroke color, size change per frame
  private boolean die; //true when star got big and small again
  private float [][] vertices; //saves all the points of the star

  Star(){
    this.setup(random(0, width), random(0, height)); //random values, anywhere on the screen
  }
  Star(float x, float y){
    this.setup(x, y);
  }

  private void setup(float x, float y){
    this.x = x;
    this.y = y;
    this.size = int(random(height/35, height/17));
    this.vertices = new float[9][2];
    this.createStarShape();
    this.brightness = 1; //not 0 because then it would die instantly
    this.growing = 15;
    this.die = false;
  }

  void show(){
    pushMatrix();
    pushStyle();
      stroke(this.brightness); //stroke color: gray to white
      strokeWeight(8); //same as rocks


      translate(this.x, this.y); //easier to resize the star
      beginShape(); //collect verticies to built a single shape out of them
      for(int i=0; i<this.vertices.length; i++){
        vertex(this.vertices[i][0]*(1+(float(this.brightness)/255)), this.vertices[i][1]*(1+(float(this.brightness)/255)));
      }
      endShape();
    popMatrix();
    popStyle();
  }

  void update(){
    this.brightness += this.growing; //growing or shrinking the star
    if(this.brightness >= 200){ //maximum brightness -> maximum size
      this.growing *= -1; //inverts direction of growing
      this.brightness = 200; //prevents bugs if brightness >255 (standard expected value)
    }
    else if(this.brightness < 1){ //too dark to be displayed, can't delete itself from the list tho
      this.growing = 0; //prevents growing further
      this.brightness = 0; //prevents bugs asociated with color values below 0
      this.die = true; //tells backGround that it can die now
    }
  }

  private void createStarShape(){ //hardcoded, not beautiful but efficient and simple
    this.vertices[0][0] = this.size/10; //beginns with inner upper right vertex
    this.vertices[1][0] = this.size/2;
    this.vertices[2][0] = this.size/10;
    this.vertices[3][0] = 0;
    this.vertices[4][0] = -this.size/10;
    this.vertices[5][0] = -this.size/2;
    this.vertices[6][0] = -this.size/10;
    this.vertices[7][0] = 0;
    this.vertices[8][0] = this.size/10;

    this.vertices[0][1] = this.size/10;
    this.vertices[1][1] = 0;
    this.vertices[2][1] = -this.size/10;
    this.vertices[3][1] = -this.size/2;
    this.vertices[4][1] = -this.size/10;
    this.vertices[5][1] = 0;
    this.vertices[6][1] = this.size/10;
    this.vertices[7][1] = this.size/2;
    this.vertices[8][1] = this.size/10;
  }

  boolean getDie(){
    return this.die;
  }
}
