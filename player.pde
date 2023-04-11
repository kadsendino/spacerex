class Player
{
    float x,y,w,h;
    float speed;
    float acceleration;
    float angle;
    int lives;

    Player(){
        this.x = width/2;
        this.y = height/2;
        this.w = height/32;
        this.h = height/12;
        this.angle = 0;
        speed = 10
    }

    void show(){
        float point_y = h/3;

        pushMatrix();
        strokeWeight(4);
        translate(x,y+(2*h)/3);
        stroke(240);
        fill(255, 0 , 255);
        rotate(angle);
        triangle(0, -(2*h)/3, -w, point_y, w, point_y);
        popMatrix();


    }

    void update(){
        PVector pos = new PVector(x,y);
        PVector change = PVector.fromAngle(angle - PI*0.5).mult(10);
        pos.add(change);
        this.x = pos.x;
        this.y = pos.y;
    }

    void setAngle(float angle){
        this.angle = angle;
    }
}