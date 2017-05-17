class Triangle{
  State state;
  float size;
  float maxSize;
  float growthRate;
  PVector center;
  boolean growing;
  color onColor;
  int dir;

  Triangle(PVector center, float growthRate, float maxSize, float startSize, int dir,color onColor){
    state = State.EVEN_BLACK_GROWING;
    this.center = center;
    this.growthRate = growthRate;
    this.maxSize =  maxSize;
    this.dir = dir;
    this.onColor = onColor;

    this.growing = false;
    size = startSize;
  }
  
  int display(){
    int pulseStatus = pulse();
    drawTriangle(this.size);
    return pulseStatus;
  }
  
  void drawTriangle(float s) {
    pushMatrix();
    translate(center.x,center.y);
    //print("x,y: ("+center.x+","+center.y+") Size: "+s+" Growing: "+growing+"\n");
    noStroke();
    fill(onColor);  
    beginShape(TRIANGLE_STRIP);
    vertex(-s, s * dir);
    vertex(0, -s * dir);
    vertex(s, s * dir);
    endShape();
    popMatrix();
  }
/*
  void stationaryTriangle(color col){
    fill(col);
    beginShape(TRIANGLE_STRIP);
    vertex(-maxSize, maxSize * dir);
    vertex(0, -maxSize * dir);
    vertex(maxSize, maxSize * dir);
    endShape();
  }*/

  int pulse(){
    if (growing) {
      size += growthRate;
      if (size >= maxSize) {
          growing = false;
          return 1;
      }
    } 
    else {
      size -= growthRate;
      if (size <= 0) {
        growing = true;
        return -1;
      }
    }
    return 0;
  }

  int grow(){
    size += growthRate;
    if (size >= maxSize) {
      growing = false;
      return -1;
    }
    return 0;
  }

  int shrink(){
    size -= growthRate;
    if (size <= 0) {
        growing = true;
        return -1;
    }
    return 0;
  }

  void randomizeTriangleProperties(){
    //this.triColor = color(random(0,255),random(0,255),random(0,255),random(50,255));
    this.dir= random(1) > 0.5 ? -1 : 1;
    this.maxSize = random(10,75);
  }
}