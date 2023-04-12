class Rock implements Enemy{
    float x,y,r;
    int level;
    int anz_points;
    PVector[] points;
    PVector vel;
    float st;

    Rock(int level, float x, float y, float r){
        this.x = x;
        this.y = y;
        this.r = r;
        this.level = level;
        this.anz_points = 12;
        this.st = 8;
        this.vel = PVector.fromAngle(random(0,TWO_PI)).normalize().mult(random(r/32,r/16));

        this.points = new PVector[anz_points];
        
        for (int i = 0; i < this.anz_points; i++) {
            PVector pos = new PVector(x,y);
            float radius = r;
            float rand = random(1,100);
            if(rand < 40){
                //inner circle
                radius = r/2;
            }else {
                //outer circle
                radius = r;
            }

            rand = random(-radius/8,radius/8) + random(-radius/8,radius/8);
            points[i] = pos.add(PVector.fromAngle(((float) i/ (float) this.anz_points) * TWO_PI).normalize().mult(radius+rand));
        } 

    }

    void show(){
        stroke(255);
        strokeWeight(st);
        noFill();
        beginShape();
        for (int i = 0; i < this.anz_points; i++) {
            vertex(this.points[i].x,this.points[i].y);
        }   
        endShape(CLOSE);
    }

    void update(){
        //moves all points and centerpoint by velocity Vector
        PVector pos = new PVector(this.x,this.y);
        pos.add(vel);
        this.x = pos.x;
        this.y = pos.y;

        if(this.x < 0)
        {
            this.x = width + this.x;
            for (int i = 0; i < this.anz_points ;i++) {
                points[i].x += width;
            }
        }else if (this.x > width) {
            this.x -= width;
            for (int i = 0; i < this.anz_points ;i++) {
                points[i].x -= width;
            }
        }

        if(this.y < 0)
        {
            this.y = height + this.y;
            for (int i = 0; i < this.anz_points ;i++) {
                points[i].y += height;
            }
        }else if (this.y > height) {
            this.y -= height;
            for (int i = 0; i < this.anz_points ;i++) {
                points[i].y -= height;
            }
        }


        for (int i = 0; i < this.anz_points ;i++) {
            points[i].add(vel);
        }
    }

    boolean isHit(PVector[] shot_points){
        return false;
    }

}