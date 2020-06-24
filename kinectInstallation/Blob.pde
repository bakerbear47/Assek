class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;

  int id = 0;

  int lifespan = maxLife;

  boolean taken = false;

  ArrayList<PVector> points;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
    points = new ArrayList<PVector>();
    points.add(new PVector(x, y));
  }

  boolean checkLife() {
    lifespan--; 
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }

  void show() {
    stroke(10);
    fill(255, lifespan);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx, miny, maxx, maxy);

    textAlign(CENTER);
    textSize(64);
    fill(140);
    text(id+"id", minx + (maxx-minx)*0.5, maxy-10);
    textSize(32);
    text(lifespan+"life", minx + (maxx-minx)*0.5, miny-10);

    for (PVector v : points) {
      //stroke(255, 0, 150);
      //point(v.x, v.y);
    }
  }

  void add(float x, float y) {
    points.add(new PVector(x, y));
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }

  void become(Blob other) {
    minx = other.minx;
    maxx = other.maxx;
    miny = other.miny;
    maxy = other.maxy;
  }

  float size() {
    return (maxx-minx) * (maxy - miny);
  }

  PVector getCenter() {
    float x = (maxx - minx)* 0.5 + minx;
    float y = (maxy - miny)* 0.5 + miny;
    return new PVector(x, y);
  }

  boolean isNear(float x, float y) {

    //float cx = max(min(x, maxx), minx);
    //float cy = max(min(y, maxy), miny);
    //float d = distSq(cx, cy, x, y);

    float cx = max(min(x, maxx), minx);
    float cy = max(min(y, maxy), miny);
    float d = distSq(cx, cy, x, y);

    if (d<distThreshold * distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
