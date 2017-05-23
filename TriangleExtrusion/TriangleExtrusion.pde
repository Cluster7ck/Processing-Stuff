ArrayList<PVector> triPos;

boolean running = false;
int triCount = 0;
int triangleBaseSize = 10;
float sizeIncrease = 1;
PVector center = new PVector(width/2,height/2);
PVector lastMousePos = new PVector(0,0);
PVector displacement = new PVector(0,0);

int lastFrame = 0;
int accTime = 0;
float[] preSides;
float[] preB;
int count = 200;
int curFrameTime = 0;
float theta = 0;

void setup() {
  size(800, 800);
  lastFrame = millis();  
  //Precalculate the triangle base values so we don't have to calc them every frame
  preSides = new float[count];
  preB = new float[count];
  for(int i = 1; i < count; i += 2){
    float triSide = (triangleBaseSize*i*sizeIncrease) * 1/sin(30*PI/180) * sin(120*PI/180);
    float b = sqrt(sq(triangleBaseSize*i*sizeIncrease)-sq(triSide/2));
    preSides[i] = triSide;
    preB[i]     = b;
  }
}

void draw() {
  int deltaTime = millis() - lastFrame;

  accTime += deltaTime;
  if(accTime >= 100){
    accTime = 0;
    if(triCount < count){
      triCount += 1;
    }
  }
  background(255);
  //PVector mousePos = new PVector(mouseX,mouseY);
  float x = 1*cos(theta)+width/2;
  float y = 1*sin(theta)+height/2;
  PVector mousePos = new PVector(x,y);
  theta += 0.1;
  displacement = PVector.sub(mousePos,new PVector(width/2,height/2));
  displacement.normalize();
  triPos = calcTrianglePos(new PVector(width/2,height/2), displacement, triangleBaseSize, sizeIncrease, triCount);

  for(int i = triPos.size()-1; i >=0; i -= 3){
    drawTriangle(triPos.get(i-2),triPos.get(i-1),triPos.get(i),color(
      (int)map_range(i/3,0,triPos.size()/3,0,255)
    ));
  }

  triPos.clear();
  lastMousePos = new PVector(mouseX,mouseY);
  
  lastFrame = millis();
  print("Framerate: "+frameRate+" accTime: "+accTime+" triCount: "+triCount+"\n");
}

float map_range(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
  return (value-fromLow)/(fromHigh-fromLow) * (toHigh-toLow) + toLow;
}

void drawTriangle(PVector p0, PVector p1, PVector p2, color col){
  beginShape(TRIANGLES);
  fill(col);
  noStroke();
  vertex(p0.x, p0.y);
  vertex(p1.x, p1.y);
  vertex(p2.x, p2.y);
  endShape();
}

// Calculates all Points for the triangle spiral
ArrayList<PVector> calcTrianglePos(PVector center, PVector centerDisplacement, float baseSize, float sizeInc, int triCount){
  ArrayList<PVector> positions = new ArrayList<PVector>();

  for(int i = 1; i < triCount; i++){
    float triSide = preSides[i];
    float b = preB[i];
    PVector p0 = new PVector(center.x - triSide/2, center.y + b);
    PVector p1 = new PVector(center.x + triSide/2, center.y + b);
    PVector p2 = new PVector(center.x , center.y - baseSize*i*sizeInc);

    positions.add(p0);
    positions.add(p1);
    positions.add(p2);

    center.x += centerDisplacement.x;
    center.y += centerDisplacement.y;
  }

  return positions;
}