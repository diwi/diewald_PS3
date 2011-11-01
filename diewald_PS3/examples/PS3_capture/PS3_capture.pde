import diewald_PS3.constants.*;
import diewald_PS3.logger.*;
import diewald_PS3.*;


PS3 ps3;
PImage img;

int size_x = 640;
int size_y = 480;

public void setup() {
  size(size_x, size_y);

  PS3Logger.TYPE.DEBUG  .active(true);
  PS3Logger.TYPE.ERROR  .active(true);
  PS3Logger.TYPE.INFO   .active(true);
  PS3Logger.TYPE.WARNING.active(true);

  println("PS3.getCameraCount() = " + PS3.getCameraCount());

  ps3 = PS3.create( 0 );
  initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.COLOR_PROCESSED, 400);


  frameRate(200);
}

public void draw() {
  background(255);

  assignPixels(ps3, img);

  if ( img != null)
    image(img, 0, 0);

  if ( ps3 != null)
    ps3.setLed(mousePressed);

  println(frameRate);
}

public void assignPixels(PS3 ps3, PImage img) {
  if ( ps3 == null ) {
    println("no ps3 instance fount");
    return;
  }
  img.loadPixels();
  ps3.getFrame(img.pixels);
  img.updatePixels();
}



public void initPS3(PS3 ps3, VIDEO_MODE mode, COLOR_MODE color_mode, int fps ) {
  if ( ps3 == null ) {
    println("no ps3 instance fount");
    return;
  }
  ps3.init(mode, color_mode, fps);
  img = createImage(ps3.getWidth(), ps3.getHeight(), ARGB);
  ps3.start();
  //  println("ps3 = "+ps3);
  //  println("w/h = "+ps3.getWidth()+", "+ps3.getHeight());
}

public void keyReleased() {
  if (key == '1') initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.COLOR_PROCESSED, 400);
  if (key == '2') initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.MONO_PROCESSED, 400);
  if (key == '3') initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.COLOR_RAW, 400);
  if (key == '4') initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.MONO_RAW, 400);
  if (key == '5') initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.BAYER_RAW, 400);
  if (key == '6') initPS3(ps3, VIDEO_MODE.QVGA, COLOR_MODE.COLOR_PROCESSED, 400);


  if (key == 'x') { 
    ps3.start();
  }
  if (key == 'y') { 
    ps3.stop();
  }
}



public void dispose() {
  PS3.shutDown();
}

