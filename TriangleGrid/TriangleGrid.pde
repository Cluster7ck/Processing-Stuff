public enum State {
    INVALID,
    EVEN_BLACK_GROWING,
    EVEN_WHITE_GROWING,
    ODD_WHITE_SHRINKING,
    ODD_BLACK_SHRINKING,
}

ArrayList<PVector> trianglePositions;
ArrayList<Triangle> triangleLayer1;
ArrayList<Triangle> triangleLayer2;
ArrayList<State> states;
int maxTriangleSize = 200;
int n = 6;
State state = State.EVEN_BLACK_GROWING;
boolean running = false;

void setup() {
  size(400, 400);
  states = new ArrayList<State>();
  for(int i = 0; i < n; i++){
    states.add(State.EVEN_BLACK_GROWING);
  }
  triangleLayer1 = new ArrayList<Triangle>();
  triangleLayer2 = new ArrayList<Triangle>();
  trianglePositions = new ArrayList<PVector>();
  
  trianglePositions = calcTrianglePos(n);
  int dir = -1;
  color b = color(0);
  color w = color(255);
  float baseGrwoth = 0.7;
  float startSize = 1;

  for(int i = 0; i < trianglePositions.size();i++){
    PVector v = trianglePositions.get(i);
    
    if(i% (n*2+1) == 0 ){
      //baseGrwoth += 0.1;
      startSize -= 0.1;
    }

    float growth = baseGrwoth;
    dir = dir * -1;
    color onC = dir == -1 ? b : w;
    color offC = dir == -1 ? w : b;
    Triangle tri = new Triangle(v, growth,(width/n)/2, ((width/n)/2)*startSize,dir,onC);
    Triangle tri2 = new Triangle(v, growth,(width/n)/2,(width/n)/2,dir,offC);
    if( dir == 1){
      tri2.size = 0;
    }
    triangleLayer1.add(tri);
    triangleLayer2.add(tri2);
  }
}

void draw() {
  background(51);
  
  if(running){
    background(255);
    for(int j = 0; j < n; j++){
      State changeState = State.INVALID;
      //each row has a separate state
      for (int i = j*(n*2+1); i < (j+1)*(n*2+1);i++){
        Triangle tri1 = triangleLayer1.get(i);
        Triangle tri2 = triangleLayer2.get(i);
        switch(states.get(j)){
          case EVEN_BLACK_GROWING:
            if(i%2 == 0){
              tri1.drawTriangle(tri1.size);
              if(tri2.grow() == -1){
                tri1.size = 0;
                changeState = State.ODD_BLACK_SHRINKING;
              }
              tri2.drawTriangle(tri2.size);
            }
            else{
              tri2.drawTriangle(tri2.size);
              tri1.drawTriangle(tri1.size);
            }
            break;
          case EVEN_WHITE_GROWING:
            if(i%2 == 0){
              tri2.drawTriangle(tri2.size);
              if(tri1.grow() == -1){
                tri2.size = 0;
                changeState = State.ODD_WHITE_SHRINKING;
              }
              tri1.drawTriangle(tri1.size);
            }
            else{
              tri1.drawTriangle(tri1.size);
              tri2.drawTriangle(tri2.size);
            }
            break;
          case ODD_BLACK_SHRINKING:
            if(i%2 != 0){
              tri2.drawTriangle(tri2.size);
              int shrinkStaus = tri1.shrink();
              tri1.drawTriangle(tri1.size);
              if(shrinkStaus == -1){
                changeState = State.EVEN_WHITE_GROWING;
                tri1.size = tri1.maxSize;
              }
            }
            else{
              tri2.drawTriangle(tri2.size);
              tri1.drawTriangle(tri1.size);
            }
            break;
          case ODD_WHITE_SHRINKING:
            if(i%2 != 0){
              tri1.drawTriangle(tri1.size);
              int shrinkStaus = tri2.shrink();
              tri2.drawTriangle(tri2.size);
              if(shrinkStaus == -1){
                changeState = State.EVEN_BLACK_GROWING;
                tri2.size = tri2.maxSize;
              }
            }
            else{
              tri2.drawTriangle(tri2.size);
              tri1.drawTriangle(tri1.size);
            }
            break;
          default:
            break;
        }
      }
      if(changeState != State.INVALID){
        states.set(j, changeState);
      }
    }
  }
}

float map_range(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
  return (value-fromLow)/(fromHigh-fromLow) * (toHigh-toLow) + toLow;
}

PVector rotateAroundPoint(PVector point, PVector rotationCenter, float angle){
  float x1 = point.x - rotationCenter.x;
  float y1 = point.y - rotationCenter.y;
  
  float x2 = x1 * (float)Math.cos(angle) - y1 * (float)Math.sin(angle);
  float y2 = x1 * (float)Math.sin(angle) + y1 * (float)Math.cos(angle);
  
  return new PVector(x2 + rotationCenter.x,y2 + rotationCenter.y);
}

ArrayList<PVector> calcTrianglePos(int n){
  ArrayList<PVector> positions = new ArrayList<PVector>();

  if(width != height)
    return null;

  int triSide = width/n;
  int size = triSide/2;
  int points = n*2+1;

  for(int y = 0; y < n; y++){
    for(int x = 0; x < points; x++){
      positions.add(new PVector(x*size,y*triSide+size));
    }
  }
  

  return positions;
}

void keyPressed(){
  if(key == 'x'){
    running = !running;
  }
}