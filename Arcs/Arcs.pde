ArrayList<Circle> circles;
int n = 8;
boolean isStrokeCapProj = false; 

color[] cols = {#3B8FA7,#E5ACC8,#E6B052,#C85173,#3B8FA7,#E5ACC8,#E6B052,#C85173};

void setup() {
  size(1200, 1200);
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
  float radius = random(120/2,250/2);
  float speed = 0.06;
  circles.clear();
  for(int i = 0; i < n; i++){
    //speed = random(0.01,0.05)
    int strokeWeight = (int)random(20,60)/2;
    circles.add(new Circle(new PVector(width/2,height/2),radius,(int)random(3,5), cols[i], strokeWeight,speed));
    radius += random(120/2,210/2);
    speed -= 0.06/n;
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
