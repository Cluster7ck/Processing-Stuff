float ang = 0;
float r = 100;

color[] cols = {#3B8FA7,#E5ACC8,#E6B052,#C85173,#72C5DD,#CA5387,#E1935D};
//color[] cols = {#1D262D,#4F67C0,#63B795,#C06154};
//color[] cols = {#1B1C2E,#712A47,#C4724A,#6E59B2,#C06154};

void setup() {
    size(600, 600);
    colorMode(HSB, 360, 100, 100);


    stroke(color(180,100,100));
}

void draw() {
    background(#7AB1DD);
    float x = r * cos(ang);
    float y = r * sin(ang);

    for(int i = 0; i < 14; i++){
        line(0,0,x,y);
    }
}