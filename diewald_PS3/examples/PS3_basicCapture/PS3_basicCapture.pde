//------------------------------------------------------------------------------
//
// author: thomas diewald
// date:   02.11.2011
//
// basic setup for video-capturing, using the PS3-eye camera.
//------------------------------------------------------------------------------


import diewald_PS3.PS3;
import diewald_PS3.constants.*;
import diewald_PS3.logger.PS3Logger;


PS3 ps3;
PImage img;

int size_x = 640;
int size_y = 480;

public void setup() {
  PS3Logger.TYPE.DEBUG  .active(true);
  PS3Logger.TYPE.ERROR  .active(true);
  PS3Logger.TYPE.INFO   .active(true);
  PS3Logger.TYPE.WARNING.active(true);

  size(size_x, size_y);

  println("PS3.getCameraCount() = " + PS3.getCameraCount());

  ps3 = PS3.create( 0 );
  ps3.init(VIDEO_MODE.VGA, COLOR_MODE.COLOR_PROCESSED, 30);
  ps3.start();
  ps3.setLed(true);
  img = createImage(ps3.getWidth(), ps3.getHeight(), ARGB);
}

public void draw() {
  assignPixels(ps3, img);
  image(img, 0, 0);
}

public void assignPixels(PS3 ps3, PImage img) {
  img.loadPixels();
  ps3.getFrame(img.pixels);
  img.updatePixels();
}


public void dispose() {
  PS3.shutDown();
}

