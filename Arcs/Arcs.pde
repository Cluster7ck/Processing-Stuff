ArrayList<Circle> circles;
int n = 4;
boolean isStrokeCapProj = false; 

color[] cols = {#3B8FA7,#E5ACC8,#E6B052,#C85173};

void setup() {
  size(800, 800);
  circles = new ArrayList<Circle>();
  generateNewCircles();
}

void draw() {
  background(#7AB1DD);

  for(int i = circles.size()-1; i >= 0; i--){
    circles.get(i).display();
  }
}

float map_range(float value, float fromLow, float fromHigh, float toLow, float toHigh) {
  return (value-fromLow)/(fromHigh-fromLow) * (toHigh-toLow) + toLow;
}

void generateNewCircles(){
  float radius = random(120,250);
  circles.clear();
  for(int i = 0; i < n; i++){
    circles.add(new Circle(new PVector(width/2,height/2),radius,(int)random(3,5), cols[i],(int)random(20,60),random(0.01,0.06)));
    radius += random(120,210);
  }
}

void keyPressed(){
  if(key == 'x'){
    isStrokeCapProj = !isStrokeCapProj;
  }
  if(key == 'n'){
    generateNewCircles();
  }
}
