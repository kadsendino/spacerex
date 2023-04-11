class Player
{
    float x,y,w,h;
    float speed;
    float max_speed;
    float max_acceleration;
    float acceleration;
    float angle;
    int lives;

    Player(){
        this.x = width/2;
        this.y = height/2;
        this.w = height/32;
        this.h = height/12;
        this.angle = 0;
        
        speed = 0;
        max_speed = 15;
        acceleration = 0;
        max_acceleration = 0.5;
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

    void update(float acc){
        acceleration = max_acceleration * acc;
        if(acceleration > max_acceleration){
            acceleration = max_acceleration;
        }

        speed += acceleration;
        if(speed > max_speed){
            speed = max_speed;
        }

        updatePosition();
    }

    void deaccelarate(){
        if(speed < max_acceleration){
            speed = 0;
        } else {
            speed -= max_acceleration;
        }

        updatePosition();
    }

    void updatePosition(){
        PVector pos = new PVector(x,y);
        PVector change = PVector.fromAngle(angle - PI*0.5).mult(speed);
        pos.add(change);
        this.x = pos.x;
        this.y = pos.y;
    }

    void setAngle(float angle){
        this.angle = angle;
    }
}