ArrayList<PVector> triPos;

boolean running = false;
int count = 20;

int triangleBaseSize = 2;
float[] preSides;
float[] preB;

int step = 1;
float progress = 0;

float theta = 0;

void setup() {
  size(600, 600);
  
  PVector center = new PVector(0,0);//new PVector(width/2,height/2);
  preSides = new float[count];
  preB = new float[count];
  float triSize = triangleBaseSize;
  for(int i = 1; i < count; i++){
    float triSide = triSize* 1/sin(30*PI/180) * sin(120*PI/180);
    float b = sqrt(sq(triSize)-sq(triSide/2));
    preSides[i] = triSide;
    preB[i]     = b;
    triSize = 2*triSize;
  }
  triPos = calcTrianglePos(center,triangleBaseSize, count);
  /*for(int i = triPos.size()-1; i >=0; i -= 3){
    drawTriangle(triPos.get(i-2),triPos.get(i-1),triPos.get(i),color(
        (int)map_range(i/3,0,triPos.size()/3,0,255)
    ));
  }*/
}

void draw() {
  background(255);
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(radians(theta));
  int s = step*3;
  for(int i = 0; i < s; i += 3){
    drawTriangle(triPos.get(i),triPos.get(i+1),triPos.get(i+2),color(
        (int)map_range(i/3,0,triPos.size()/3,0,255)
    ));
  }

  //Draw growing lines from the edges
  if(s <= triPos.size()){
    PVector p1 = triPos.get(s-1);
    PVector p2 = triPos.get(s-2);
    PVector p3 = triPos.get(s-3);
    //r top, g right, b left
    /*fill(255,0,0);
    ellipse(p1.x, p1.y, 10, 10);
    fill(0,255,0);
    ellipse(p2.x, p2.y, 10, 10);
    fill(0,0,255);
    ellipse(p3.x, p3.y, 10, 10);
    //yellow left, cyan right, magenta top
    fill(255,255,0);//yellow
    ellipse(triPos.get(s).x, triPos.get(s).y, 10, 10);
    fill(0,255,255);//cyan
    ellipse(triPos.get(s+1).x, triPos.get(s+1).y, 10, 10);
    fill(255,0,255);//magenta
    ellipse(triPos.get(s+2).x, triPos.get(s+2).y, 10, 10);
    */
    //Horizontal Lines
    PVector lerpedV = PVector.lerp(p1,triPos.get(s),progress);
    line(p1.x, p1.y, lerpedV.x, lerpedV.y);

    lerpedV = PVector.lerp(p1,triPos.get(s+1),progress);
    line(p1.x, p1.y, lerpedV.x, lerpedV.y);

    //right v line
    //up
    lerpedV = PVector.lerp(p2,triPos.get(s+1),progress);
    line(p2.x, p2.y, lerpedV.x, lerpedV.y);
    //down
    lerpedV = PVector.lerp(p2,triPos.get(s+2),progress);
    line(p2.x, p2.y, lerpedV.x, lerpedV.y);

    //left v line
    //up
    lerpedV = PVector.lerp(p3,triPos.get(s),progress);
    line(p3.x, p3.y, lerpedV.x, lerpedV.y);
    //down
    lerpedV = PVector.lerp(p3,triPos.get(s+2),progress);
    line(p3.x, p3.y, lerpedV.x, lerpedV.y);

  }
  popMatrix();
  progress += 0.03;//1-map_range(s,0,triPos.size(),0.92,0.99);
  if(progress > 1){
    progress = 0;
    step++;
  }
  theta++;
}

void drawTriangle(PVector p0, PVector p1, PVector p2, color col){
  beginShape(TRIANGLES);
  noFill();
  stroke(0);
  vertex(p0.x, p0.y);
  vertex(p1.x, p1.y);
  vertex(p2.x, p2.y);
  endShape();
}

ArrayList<PVector> calcTrianglePos(PVector center, float baseSize, int triCount){
  ArrayList<PVector> positions = new ArrayList<PVector>();

  int dir = 1;
  float triSize = baseSize;
  for(int i = 1; i < triCount; i++){
    float triSide = preSides[i];
    float b = preB[i];
    PVector p0 = new PVector(center.x - triSide/2, center.y + b*dir);
    PVector p1 = new PVector(center.x + triSide/2, center.y + b*dir);
    PVector p2 = new PVector(center.x , center.y - triSize*dir);

    positions.add(p0);
    positions.add(p1);
    positions.add(p2);

    dir = dir == 1 ? -1 : 1;
    triSize = 2*triSize;
  }

  return positions;
}

void keyPressed(){
  if(key == 'x'){
    running = !running;
  }
}

float map_range(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
  return (value-fromLow)/(fromHigh-fromLow) * (toHigh-toLow) + toLow;
}