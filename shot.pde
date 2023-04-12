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

    boolean outside(){
        return ((this.x - this.w < 0) || (this.x + this.w > width)) && ((this.y - this.h < 0) || (this.y + this.h > height));
    }

    PVector[] getReferencePoints(){
        Pvector[] erg = new PVector[4];
        erg[0] = new PVector(x,y);
        erg[0] = new PVector(x+w,y);
        erg[0] = new PVector(x,y+h);
        erg[0] = new PVector(x+w,y+h);
        return erg
    }
}