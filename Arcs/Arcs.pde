ArrayList<Circle> circles;

float scale = 0.2;
int n = 10;
boolean isStrokeCapProj = false; 

color[] cols = {#3B8FA7,#E5ACC8,#E6B052,#C85173,#72C5DD,#CA5387,#E1935D};
//#C94A54,#72C5DD

void setup() {
  size(600, 600);
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
  float radius = random(120*scale,250*scale);
  float speed = 0.06;
  float radIncrease = 0;
  int colorOffset = (int)random(cols.length+1);
  circles.clear();
  for(int i = 0; i < n; i++){
    //speed = random(0.01,0.05)
    radIncrease = random(90*scale,400*scale);
    int strokeWeight = (int)(random(20,radIncrease-10)*scale);
    color col = cols[(i+colorOffset)%cols.length];
    circles.add(new Circle(new PVector(width/2,height/2),radius,(int)random(3,5), col, strokeWeight,speed));
    radius += radIncrease;
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
