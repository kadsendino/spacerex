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
    }

    void show(){
        float pointLeft_x = x - w;
        float pointRight_x = x + w;
        float point_y = h/3;

        pushMatrix();
        strokeWeight(4);
        translate(x,y+(2*h)/3);
        stroke(240);
        fill(255, 0 , 255);
        rotate(angle);
        triangle(x, -(2*h)/3, pointLeft_x, point_y, pointRight_x, point_y);
        popMatrix();
    }

    void update(float angle){
        this.angle = angle;
    }
}