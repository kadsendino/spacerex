class Shot{

    float x,y,w,h;
    PVector vel;
    float speed;
    color c;
    
    Shot(float x,float y,float w,float h,color c,PVector vel, float speed){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.c = c;
        this.vel = vel;
        this.speed = speed;
    }   

    void show(){
        pushMatrix();
        rectMode(CENTER);
        noStroke();
        fill(c);
        translate(x,y);
        rotate(vel.heading() - PI*0.5);
        rect(0, 0, w, h);
        popMatrix();
    }

    void update(){
        PVector pos = new PVector(x,y);
        pos.add(vel.mult(speed));
        vel.normalize();
        this.x = pos.x;
        this.y = pos.y;
    }
}