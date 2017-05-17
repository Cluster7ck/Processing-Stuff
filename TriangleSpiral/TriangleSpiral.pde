ArrayList<PVector> triPos;
int lc;
float progress = 0;
float sI = 1;
boolean running = false;

void setup() {
  size(600, 600);

}

void draw() {
  if(running){
    background(255);

    triPos = calcTrianglePos(new PVector(width/2,height/2), 20,sI);
    for(int i = 0; i < triPos.size()-1; i++){
      line(triPos.get(i).x, triPos.get(i).y, triPos.get(i+1).x, triPos.get(i+1).y);
    }
    sI += 0.001;
  }
}

float map_range(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
  return (value-fromLow)/(fromHigh-fromLow) * (toHigh-toLow) + toLow;
}

ArrayList<PVector> calcTrianglePos(PVector center, float baseSize, float sizeInc){
  ArrayList<PVector> positions = new ArrayList<PVector>();
  //Start Triangle
  //float triSide = sqrt(cos(2.0944));

  float triSide = baseSize * 1/sin(30*PI/180) * sin(120*PI/180);

  float b = sqrt(sq(baseSize)-sq(triSide/2));
  print("TriSide: "+triSide+" b: "+b+"\n");

  PVector p0 = new PVector(center.x - triSide/2, center.y + b);
  PVector p1 = new PVector(center.x + triSide/2, center.y + b);
  PVector p2 = new PVector(center.x , center.y - baseSize);
  
  positions.add(p0);
  positions.add(p1);
  positions.add(p2);

  for(int i = 2; i < 50; i++){
    PVector dirNextP = PVector.sub(positions.get(i-2),positions.get(i));
    float mag = mag(dirNextP.x,dirNextP.y);
    PVector nextP = PVector.add(positions.get(i), dirNextP.normalize().mult(mag*sizeInc));
    positions.add(nextP);
  }

  return positions;
}
void keyPressed(){
  if(key == 'x'){
    running = !running;
  }
}