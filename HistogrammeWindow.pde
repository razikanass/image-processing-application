public class HistogrammeWindow extends PApplet {

  int w, h;
  PImage img;
  OpenCV opencv;
  Histogram grayhist,
            redhist,
            greenhist,
            bluehist;
  Object parent;
  
  public HistogrammeWindow(){}
  
  public HistogrammeWindow(Object theParent,int w,int h,PImage img){
    this.parent = theParent;
    this.w = w;
    this.h = h;
    if(img!=null)this.img = img;
  }

  public void setup() {
    size(w,h);
    try{
      opencv = new OpenCV(this,img);
      grayhist = opencv.findHistogram(opencv.getGray(),256);
      redhist = opencv.findHistogram(opencv.getR(),256);
      greenhist = opencv.findHistogram(opencv.getG(),256);
      bluehist = opencv.findHistogram(opencv.getB(),256);
    }
    catch(Exception e){
    }
  }

  public void draw() {
    background(0);
    stroke(150);
    try{
      grayhist.draw(0,0,200,200);
      stroke(255,0,0);
      redhist.draw(200,0,200,200);
      stroke(0,255,0);
      greenhist.draw(400,0,200,200);
      stroke(0,0,255);
      bluehist.draw(600,0,200,200);
    }
    catch(Exception e){
    }
  }
  
  void keyPressed(){
    if(key=='q'){
      noLoop();
      stop();
      dispose();
      destroy();
    }
  }
}

