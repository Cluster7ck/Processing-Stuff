ArrayList<PVector> triPos;
ArrayList<PVector> squarePos;

int lineCount = 0;
float progress = 0;
float lineScale = 1.1;
boolean running = false;
boolean decrease = false;

void setup() {
  size(600, 600);
  triPos = calcTrianglePos(new PVector(width/2,height/2), 100,lineScale);
}

void draw() {
  /*
  // baasically just for easier gif making ;)
  if(running){
    background(255);
    
    //lineScale has a meaningful visual representation from 0.91 - 1.1
    float lerpV = map_range(lineScale,0.91,1.1,0,1);
    drawCenterTrig(new PVector(width/2,height/2), 100, lerpColor(color(#ff66a3), color(#b380ff), lerpV));
    triPos = calcTrianglePos(new PVector(width/2,height/2), 100,lineScale);
    for(int i = 0; i < triPos.size()-1; i++){
      line(triPos.get(i).x, triPos.get(i).y, triPos.get(i+1).x, triPos.get(i+1).y);
    }
    if(!decrease){
      lineScale += 0.0005;
    } 
    else{
      lineScale -= 0.0005;
    }
  }*/

  if(running){
    background(255);
    for(int i = 0; i < lineCount; i++){
      line(triPos.get(i).x, triPos.get(i).y, triPos.get(i+1).x, triPos.get(i+1).y);
    }
    //Lerp last line
    PVector lerpedV = PVector.lerp(triPos.get(lineCount),triPos.get(lineCount+1),progress);
    line(triPos.get(lineCount).x, triPos.get(lineCount).y, lerpedV.x, lerpedV.y);
    progress += 0.05;
    if(progress >= 1){
      progress = 0;
      lineCount++;
    }
  }
}

float map_range(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
  return (value-fromLow)/(fromHigh-fromLow) * (toHigh-toLow) + toLow;
}

void drawCenterTrig(PVector center, float baseSize, color col){
  float triSide = baseSize * 1/sin(30*PI/180) * sin(120*PI/180);
  float b = sqrt(sq(baseSize)-sq(triSide/2));

  //Start Triangle
  PVector p0 = new PVector(center.x - triSide/2, center.y + b);
  PVector p1 = new PVector(center.x + triSide/2, center.y + b);
  PVector p2 = new PVector(center.x , center.y - baseSize);

  beginShape(TRIANGLE_STRIP);
  fill(col);
  vertex(p0.x, p0.y);
  vertex(p1.x, p1.y);
  vertex(p2.x, p2.y);
  endShape();
}

// Calculates all Points for the triangle spiral
ArrayList<PVector> calcTrianglePos(PVector center, float baseSize, float sizeInc){
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  float triSide = baseSize * 1/sin(30*PI/180) * sin(120*PI/180);
  float b = sqrt(sq(baseSize)-sq(triSide/2));

  //Start Triangle
  PVector p0 = new PVector(center.x - triSide/2, center.y + b);
  PVector p1 = new PVector(center.x + triSide/2, center.y + b);
  PVector p2 = new PVector(center.x , center.y - baseSize);
  
  positions.add(p0);
  positions.add(p1);
  positions.add(p2);

  int cycles = 150;
  // Next point is always in a line from the last point towards the next edge in sight (which is i-2)
  for(int i = 2; i < cycles; i++){
    PVector nextP;
    PVector dirNextP = PVector.sub(positions.get(i-2),positions.get(i));

    // All points lie past the target point by 1-sizeInc %
    if(i != cycles-1){
      nextP = PVector.add(positions.get(i), dirNextP.mult(sizeInc));
    }
    else{
      nextP = PVector.add(positions.get(i), dirNextP);
    }
    positions.add(nextP);
  }

  return positions;
}

ArrayList<PVector> calcSquareePos(PVector center, float baseSize, float sizeInc){
  ArrayList<PVector> positions = new ArrayList<PVector>();

  //Start Square
  PVector p0 = new PVector(center.x - baseSize, center.y + baseSize);
  PVector p1 = new PVector(center.x + baseSize, center.y + baseSize);
  PVector p2 = new PVector(center.x + baseSize , center.y - baseSize);
  PVector p3 = new PVector(center.x - baseSize , center.y - baseSize);
  
  positions.add(p0);
  positions.add(p1);
  positions.add(p2);
  positions.add(p3);

  for(int i = 3; i < 50; i++){
    PVector nextP;
    PVector dirNextP = PVector.sub(positions.get(i-3),positions.get(i));
    if(i != 49){
      nextP = PVector.add(positions.get(i), dirNextP.mult(sizeInc));
    }
    else{
      nextP = PVector.add(positions.get(i), dirNextP);
    }
    positions.add(nextP);
  }

  return positions;
}


void keyPressed(){
  if(key == 'x'){
    running = !running;
  }
  if(key == 's'){
    decrease = true;
  }
}

void keyReleased() {
  if(key == 's'){
    decrease = false;
  }
}