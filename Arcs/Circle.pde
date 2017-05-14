class Circle{
    PVector center;
    float radius;
    ArrayList<Arc> arcs;
    float rotationSpeed;
    float rotationAngle;
    color col;
    int strokeWeight;

    Circle(PVector center, float radius, int numArcs, color col, int strokeWeight, float rotationSpeed){
        this.center = center;
        this.radius = radius;
        this.rotationSpeed = rotationSpeed;
        this.col = col;
        this.strokeWeight = strokeWeight;
        rotationAngle = random(0, TWO_PI);

        arcs = new ArrayList<Arc>();
        float[] slices = new float[numArcs];
        float arcSize = TWO_PI/numArcs;

        float startSize = random(arcSize/2,arcSize);
        float rest = arcSize - startSize;
        slices[0] = startSize;
        float sizeSum = startSize;

        for(int i = 1; i < numArcs; i++){
            float size = arcSize+rest;
            startSize = random(size/2, size);
            sizeSum += startSize;
            rest = arcSize*(i+1) - sizeSum;
            slices[i] = startSize;
        }

        float curPoint = 0;
        for(int i = 0; i < numArcs; i++){
            float p = random(0.1,0.5);
            float m = random(0.1,0.5);
            Arc a = new Arc(curPoint+p,curPoint+slices[i]-m);
            curPoint += slices[i];
            arcs.add(a);
        }
        
    }

    void display(){

        pushMatrix();
        translate(center.x, center.y);
        rotate(rotationAngle);
        noStroke();
        //map_range(radius,0,width,0,255)
        fill(col);
        ellipse(0, 0, radius+strokeWeight, radius+strokeWeight);
        
        stroke(51);
        strokeWeight(strokeWeight);
        
        strokeCap(SQUARE);

        noFill();
        for(Arc a : arcs){
            arc(0,0, radius, radius, a.startRad, a.endRad);
        }
        popMatrix();
        rotationAngle += rotationSpeed;
        if(rotationAngle > TWO_PI){
            rotationAngle = 0;
        }
    }
}

class Arc{
    float startRad;
    float endRad;

    Arc(float startRad, float endRad){
        this.startRad = startRad;
        this.endRad = endRad;
    }
}