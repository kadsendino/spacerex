interface Enemy{
    void show();
    void update();
    boolean isHit(PVector[] shot_points);
    boolean getHit(); //returns true if it dies
    int getEnemyID();
    float[] getData();
}