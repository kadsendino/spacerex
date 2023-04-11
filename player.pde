class Player
{
    float x,y,w,h;
    float speed;
    float max_speed;
    float max_acceleration;
    float acceleration;
    float angle;
    int lives;
    ArrayList<Shot> shots;

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

        shots = new ArrayList<Shot>();
    }

    void show(){
        float point_y = h/3;

        pushMatrix();
        strokeWeight(4);
        translate(x,y+(2*h)/3);
        stroke(240);
        noFill();
        rotate(angle);
        triangle(0, -(2*h)/3, -w, point_y, w, point_y);
        popMatrix();

        for (int i = 0; i < shots.size(); ++i) {
            shots.get(i).show();
        }


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

        for (int i = shots.size()-1; i >= 0; i--) {
           shots.get(i).update();

           if(shots.get(i).outside()){
                shots.pop(i);
           }
        }

        
        if(this.x < 0)
        {
            this.x = width + this.x;
        }else if (this.x > width) {
            this.x -= width;
        }

        if(this.y +(this.h*2)/3 < 0)
        {
            this.y = height + this.y;
        }else if (this.y +(this.h*2)/3 > height) {
            this.y -= height;
        }
    }

    void setAngle(float angle){
        this.angle = angle;
    }

    void shoot(){
        shots.add(new Shot(this.x,this.y+(this.h*2)/3,10,50,color(255,0,0),PVector.fromAngle(angle - PI*0.5).normalize(),max_speed*2));
    }
}