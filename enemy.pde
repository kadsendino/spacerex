interface Enemy{
    void show();
    void update();
    boolean isHit(PVector[] shot_points);
    boolean getHit(Enemy[] enemies); //returns true if it dies
}