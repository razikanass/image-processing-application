public class ControlWindow extends PApplet {

  int w, h;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addSlider("red channel").plugTo(parent,"redVal").setRange(0, 255).setValue(255).setPosition(10,30);
    cp5.addSlider("green channel").plugTo(parent,"greenVal").setRange(0, 255).setValue(255).setPosition(10,50);
    cp5.addSlider("blue channel").plugTo(parent,"blueVal").setRange(0, 255).setValue(255).setPosition(10,70);
    cp5.addButton("loadImg").plugTo(parent).setPosition(10,90).setSize(50,20);
    cp5.addToggle("negative").plugTo(parent,"negative").setSize(20,20).setPosition(10,120);
    cp5.addToggle("erosion").plugTo(parent,"erosion").setSize(20,20).setPosition(10,160);
    cp5.addToggle("dilatation").plugTo(parent,"dilatation").setSize(20,20).setPosition(50,160);
    cp5.addToggle("ouverture").plugTo(parent,"ouverture").setSize(20,20).setPosition(100,160);
    cp5.addToggle("fermeture").plugTo(parent,"fermeture").setSize(20,20).setPosition(150,160);
    cp5.addSlider("rotation").plugTo(parent,"theta").setRange(-PI,PI).setPosition(10,200);
    cp5.addSlider("zoom").plugTo(parent,"zoom").setRange(0.1,5).setValue(1).setPosition(10,220).setSliderMode(Slider.FLEXIBLE);
    cp5.addButton("getHistogram").plugTo(parent).setPosition(10,240).setSize(70,20);
    cp5.addButton("saveImg").plugTo(parent).setPosition(10,270).setSize(60,20);
  }

  public void draw() {
      background(0);
  }
  
  private ControlWindow() {
  }

  public ControlWindow(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  ControlP5 cp5;

  Object parent;

  
}

