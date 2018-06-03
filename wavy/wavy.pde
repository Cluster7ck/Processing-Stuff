class cwave
{
    public int petals;
    public PVector centerPos;
    public int radius;
    public int radiusOffset;
    public int offset;
    public color[] colors;

    public cwave(int petals, PVector centerPos, int radius, int radiusOffset, int offset){
        this.petals = petals;
        this.centerPos = centerPos;
        this.radius = radius;
        this.radiusOffset = radiusOffset;
        this.offset = offset;
    }

    void update(){
        offset++;
    }

    void drawIt(){
        for(int i = 0; i < 360; i++){

        }
    }
}

int lastFrame = 0;
int accTime = 0;
float r = 200;
int offset = 0;
float pulse = 0;
//              0        1        2        3        4        5        6
color[] cols = {#3B8FA7, #E5ACC8 ,#E6B052, #C85173, #72C5DD, #CA5387, #F8F250};

color[][] coools =  {
                        {#263c54, #59a59c, #e0ba60, #ef7934, #d5402b},
                        {#afe3a7, #dff3b9, #ebe85a, #b8df31, #d04330},
                        {#b8df31, #525174, #348aa7, #f4ac52, #b62c38},
                        {#666a86, #788aa3, #92b6b1, #b2c9ab, #e8ddb5},
                        {#34ef17, #b7fdfe, #5ef38c, #2b9720, #efb917},
                        {#8d3b72, #8a7090, #89a7a7, #72e1d1, #b5d8cc},
                        {#6cd4ff, #8b80f9, #cfbff7, #cfb1b7, #83858c},
                        {#f9fbb2, #ff8cc6, #efd6d2, #de369d, #6f5e76},
                        {#bce784, #5dd39e, #513b56, #348aa7, #525174}
                    };


cwave[] waves;

void setup() {
    size(1000, 1000);
    colorMode(HSB, 360, 100, 100);
    int xx = 5;
    int yy = 5;
    waves = new cwave[xx*yy];
    int quart = width/(xx+1);
    int lol = 0;    
    int offsetStep = 360/(xx*yy);
    for(int y = 1; y <= xx; y++){
        for(int x = 1; x <= yy; x++){
            waves[lol] = new cwave((lol+3), new PVector(x * quart, y * quart), 80, 25, offsetStep*lol);
            waves[lol].colors = coools[lol%coools.length];
            lol++;
        }
    }
    stroke(color(0,100,100));
}

void draw() {
    int deltaTime = millis() - lastFrame;
    lastFrame = millis();
    background(color(#383838));
    //background(color(#FFFFFF));

    float step = (2*PI)/360;
    int sub = 6;
    for(int w = 0; w < waves.length; w++){
        pushMatrix();
        translate(waves[w].centerPos.x, waves[w].centerPos.y);
        for(int i = 0; i < 360; i++){
            if(i % sub == 0){
                //color col = color((i+waves[w].offset)%360,100,100);
                color col = ColorGrad(waves[w].colors,map(i,0,359,0,1));
                stroke(col);
                fill(col);

                float sinValue = map((i+offset)%360,0,360,0,waves[w].petals*PI);

                float lr = waves[w].radius + sin(pulse)*waves[w].radiusOffset * sin(sinValue);
                float a = step * i;
                float asd = 1+(0.01 * sin(millis()*0.02));
                PVector e = new PVector(lr * cos(a) , lr * sin(a));

                float fromMult = map(sin(pulse),-1,1,0.1,0.3);
                PVector s = new PVector(e.x * fromMult, e.y * fromMult);
                e = new PVector(e.x * asd, e.y * asd);
                line(s.x,s.y,e.x,e.y);

                /* Before */
                
                if( i >= 4){
                    float sinValue2 = map(((i-sub)+offset)%360,0,360,0,waves[w].petals*PI);

                    float lr2 = waves[w].radius + sin(pulse)*waves[w].radiusOffset * sin(sinValue2);
                    float a2 = step * (i-sub);
                    PVector b = new PVector(lr2 * cos(a2), lr2 * sin(a2));
                    line(b.x,b.y,e.x,e.y);
                }
                if(i == 360-sub){
                    float sinValue2 = map((offset)%360,0,360,0,waves[w].petals*PI);

                    float lr2 = waves[w].radius + sin(pulse)*waves[w].radiusOffset * sin(sinValue2);
                    PVector b = new PVector(lr2 * cos(0), lr2 * sin(0));
                    line(b.x,b.y,e.x,e.y);
                }

                if(i % 12 == 0){
                    ellipse(e.x, e.y, 5, 5);
                }
            }
        }
        popMatrix();
        waves[w].update();
    }

    offset++;
    pulse += 0.0256;
}

color ColorGrad(color[] colors, float val)
{
    float step = 1.0/colors.length;
    int colV = floor(val/step);

    color col = color(#000000);
    if(colV < colors.length-1){
        return lerpColor(colors[colV],colors[colV+1],map(val,colV*step,(colV+1)*step,0,1));
    }
    else{
        return lerpColor(colors[colors.length-1],colors[0],map(val,(colors.length-1)*step,1,0,1));
    }
}