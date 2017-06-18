
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import java.awt.Frame;
import java.awt.event.WindowEvent;
import javax.swing.JFrame;
import java.awt.BorderLayout;
import controlP5.*;
import gab.opencv.*;
//import processing.video.*;

ControlP5 cp5;
OpenCV opencv;
ControlWindow fen1;
HistogrammeWindow fen2;

int redVal,blueVal,greenVal;
PImage image,oldImage;
color red;
String file;
String nameSave;
boolean negative,
        erosion,dilatation,ouverture,fermeture;
float zoom = 1,
      theta = 0,
      offx,offy;

void setup(){
  size(800, 690);
  image = new PImage();
  cp5 = new ControlP5(this);
  fen1 = addControlFrame("Control Window", 300,650);
  offx = width/2;
  offy = height/2;
  msgbox("please select an image by clicking the loadimg button","information","info");
}

void draw(){
  background(0);
  translate(offx,offy);
  scale(zoom);
  rotate(theta);
  if(image!=null){
    imageMode(CENTER);
    image(image,0,0,width,height);
  }
  tint(redVal,greenVal,blueVal);
  if(erosion){
    try{
      opencv.gray();
      opencv.invert();
      opencv.erode();
      image = opencv.getSnapshot();
    }
    catch(Exception e){
    }
  }
  else if(dilatation){
    try{
      opencv.gray();
      opencv.invert();
      opencv.dilate();
      image = opencv.getSnapshot();
    }
    catch(Exception e){
    }
  }
  else if(ouverture){
    try{
      opencv.gray();
      opencv.invert();
      opencv.erode();
      image = opencv.getSnapshot();
      opencv.dilate();
      image = opencv.getSnapshot();
    }
    catch(Exception e){
    }
  }
  else if(fermeture){
    try{
      opencv.gray();
      opencv.invert();
      opencv.dilate();
      image = opencv.getSnapshot();
      opencv.erode();
      image = opencv.getSnapshot();
    }
    catch(Exception e){
    }
  }
  else{
    try{
      image.copy(oldImage,0,0,image.width,image.height,0,0,image.width,image.height);
    }
    catch(Exception e){
    }
  }
  if(negative){
    for (int i=0;i<image.pixels.length;i++) {
        color p=image.pixels[i];
        float r = 255-red(p);
        float g = 255-green(p);
        float b = 255-blue(p);
        image.pixels[i] = color(r, g, b);
    }
  }
}


/*void keyPressed(){
  if(key=='h'){
    fen2 = addHistWindow("histogramme",800,400,image);
  }
}*/

/*public void controlEvent(ControlEvent e){
  println(e.getController().getName());
}*/

public void getHistogram(){
  fen2 = addHistWindow("histogramme",800,400,image);
}

public void saveImg(){
  noLoop();
  println("bip");
  nameSave = JOptionPane.showInputDialog("enter a name for the image that you want to save");
  save(nameSave+".jpg");
  loop();
}
   
public void loadImg(){
  String filePath = null;
  
  noLoop();
  JFileChooser chooser = new JFileChooser();
  int retrunChooser = chooser.showOpenDialog(this);
  
  if(retrunChooser == JFileChooser.APPROVE_OPTION){
    System.out.println(chooser.getSelectedFile().getAbsolutePath());
    filePath = chooser.getSelectedFile().getAbsolutePath();
  }
  else{
    msgbox("you must load an image explore this application","information","error");
  }
  loop();
  
  image = loadImage(filePath);
  oldImage = loadImage(filePath);
  try{
    opencv = new OpenCV(this,image);
  }
  catch(Exception e){}
}

ControlWindow addControlFrame(String title, int theWidth, int theHeight) {
  Frame f = new Frame(title);
  ControlWindow p = new ControlWindow(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(title);
  f.setSize(p.w, p.h);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

HistogrammeWindow addHistWindow(String title, int w, int h,PImage img){
  JFrame f = new JFrame(title);
  HistogrammeWindow histowin = new HistogrammeWindow(this,w,h,img);
  f.add(histowin);
  histowin.init();
  f.setTitle(title);
  f.setSize(histowin.w,histowin.h);
  f.setResizable(true);
  f.setVisible(true);
  return histowin;
}

void msgbox(String msg ,String title ,String type){
  if(type.equals("info")){
    JOptionPane.showMessageDialog(null,msg,title,JOptionPane.INFORMATION_MESSAGE);
  }
  else if(type.equals("error")){
    JOptionPane.showMessageDialog(null,msg,title,JOptionPane.ERROR_MESSAGE);
  }
}

void mouseDragged(){
  offx += (mouseX-pmouseX);
  offy += (mouseY-pmouseY);
}
