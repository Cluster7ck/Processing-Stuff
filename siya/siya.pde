import java.util.Collections;

ArrayList<PVector> top = new ArrayList<PVector>();
ArrayList<PVector> bot = new ArrayList<PVector>();
int lastFrame = 0;
color[][] coools =  
{
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

void setup()
{
    size(800, 800);
    float e = exp(1.0);
    for(int i = 0; i < width; i++)
    {
        if( i % 2 == 0)
        {
            float y = exp(-1 * (((i - width/2)*(i - width/2)) / (2*pow(width/6,2)) ));// Math.exp(-i*i / 2) / Math.sqrt(2 * Math.PI);//
            top.add(new PVector(i, (float)y*-300));
            bot.add(new PVector(i,0));
        }
    }
    print("size: "+top.size());
    background(#FFFFFF);
}

void draw()
{
    int deltaTime = millis() - lastFrame;
    //background(color((millis()*0.1)%360,100,100));

    lastFrame = millis();
    //background(#FFFFFF);
    Collections.shuffle(top);
    Collections.shuffle(bot);

    //translate(0, height/2);
    float step = 360.0/top.size();

    if(frameCount  % 12 == 0){
        stroke(#FFFFFF);
    }
    else{
        stroke(#000000);
    }
    
    colorMode(HSB, 360, 100, 100);
    /*
    for(int i = 0; i < top.size(); i++)
    {
        PVector f = bot.get(i);
        PVector t = top.get(i);
        if(frameCount % 4 == 0){
            stroke(color(i%360,100,100));
        }
        strokeWeight(1);
        line(f.x, f.y, t.x, t.y);
        line(f.x, f.y, t.x, -t.y);
    }

    for(int i = 0; i < top.size(); i++){
        
        float off = 1;//+(((randomGaussian()+1)/2)*0.02);
        PVector t = new PVector(top.get(i).x*off, top.get(i).y*off);
        stroke(#FFFFFF);
        strokeWeight(15);
        line(t.x, t.y,t.x,-width/2);
        line(t.x, -t.y,t.x,width/2);
    }
    */
    //float step = (2*PI)/360;

    pushMatrix();
    translate(width/2, height/2);
    for(int i = 0; i < 360; i++)
    {        
        if(frameCount % 4 == 0){
            stroke(color(i%360,100,100));
        }
        float a = random(0, 2*PI);
        float lr = 200;
        PVector f = new PVector(lr * cos(a) , lr * sin(a));
        //a = random(1);
        a = random(0, 2*PI);
        PVector t = new PVector(lr * cos(a) , lr * sin(a));
        line(f.x, f.y, t.x, t.y);
    }
    popMatrix();

    pushMatrix();
    translate(width/4, height/4);
    for(int i = 0; i < 360; i++)
    {        
        if(frameCount % 4 == 0){
            stroke(color(i%360,100,100));
        }
        float a = random(0, 2*PI);
        float lr = 150;
        PVector f = new PVector(lr * cos(a) , lr * sin(a));
        //a = random(1);
        a = random(0, 2*PI);
        PVector t = new PVector(lr * cos(a) , lr * sin(a));
        line(f.x, f.y, t.x, t.y);
    }
    popMatrix();

    pushMatrix();
    translate(width/4*3, height/4);
    for(int i = 0; i < 360; i++)
    {        
        if(frameCount % 4 == 0){
            stroke(color(i%360,100,100));
        }
        float a = random(0, 2*PI);
        float lr = 150;
        PVector f = new PVector(lr * cos(a) , lr * sin(a));
        //a = random(1);
        a = random(0, 2*PI);
        PVector t = new PVector(lr * cos(a) , lr * sin(a));
        line(f.x, f.y, t.x, t.y);
    }
    popMatrix();
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