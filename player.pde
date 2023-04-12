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
    float st;
    

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
        this.st = 4;

        shots = new ArrayList<Shot>();
        lives = 100;
    }

    void show(){
        float point_y = h/3;

        pushMatrix();
        strokeWeight(st);
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

    void handleEnemies(ArrayList<Enemy> enemies){
        for (int s = shots.size()-1; s>=0 ; s--) {
            for (int e=enemies.size()-1; e>=0 ;e--) {
                boolean hit = enemies.get(e).isHit(shots.get(s).getReferencePoints());
                if(hit){
                    boolean dies = enemies.get(e).getHit();
                    if(dies){
                        enemies.remove(e);
                    }  
                    shots.remove(s);
                    break;
                }
            }
        }

        for (int e=enemies.size()-1; e>=0 ;e--) {
                boolean hit = enemies.get(e).isHit(this.getReferencePoints());
                if(hit){
                    boolean dies = enemies.get(e).getHit();
                    if(dies){
                        enemies.remove(e);
                    }  
                    this.lives -= 40;
                    break;
                }
        }
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
                shots.remove(i);
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
        PVector pos = new PVector(this.x,this.y+(this.h*2)/3);
        pos.add(PVector.fromAngle(angle - PI*0.5).normalize().mult((this.h*2)/3));
        float shot_speed = max_speed*2;
        color col = color(255);

        shots.add(new Shot(pos.x,pos.y,st*1,st*6,col,PVector.fromAngle(angle - PI*0.5).normalize(),shot_speed));
    }

    PVector[] getReferencePoints(){
        PVector[] erg =  new PVector[6];
        PVector front = PVector.fromAngle(angle - PI*0.5).normalize();
        PVector center = new PVector(x,y+(this.h*2)/3);
        float edge_length;

        for (int i = 0; i < erg.length; i++) {
            if(i%2==0){
                edge_length = (this.h*2)/3;
            }else {
                edge_length = this.h/3;
            }
            erg[i] = PVector.add(center,front.mult(edge_length).rotate(((float) i/(float) erg.length)*TWO_PI));
            front.normalize();
        }
        return erg;
        
    }

    int getLives(){
        return this.lives;
    }
}