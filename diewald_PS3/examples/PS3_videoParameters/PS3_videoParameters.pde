//------------------------------------------------------------------------------
//
// author: thomas diewald
// date:   02.11.2011
//
// demonstration of how to use "PS3_PARAM".
// sometimes, the behaviour is not as expected at the first run... just restart the sketch then.
// if you set/change parameters on each frame, it will slow down the framerate!
//------------------------------------------------------------------------------

import diewald_PS3.PS3;
import diewald_PS3.constants.COLOR_MODE;
import diewald_PS3.constants.PS3_PARAM;
import diewald_PS3.constants.VIDEO_MODE;
import diewald_PS3.logger.PS3Logger;


PS3 ps3;
PImage img;

int size_x = 640;
int size_y = 480;

public void setup() {
  PS3Logger.TYPE.DEBUG  .active(!true);
  PS3Logger.TYPE.ERROR  .active(!true);
  PS3Logger.TYPE.INFO   .active(!true);
  PS3Logger.TYPE.WARNING.active(!true);

  size(size_x, size_y);

  println("PS3.getCameraCount() = " + PS3.getCameraCount());

  ps3 = PS3.create( 0 );
  ps3.init(VIDEO_MODE.VGA, COLOR_MODE.COLOR_PROCESSED, 60);
  ps3.start();

  img = createImage(ps3.getWidth(), ps3.getHeight(), ARGB);


  // get the min/max values the parameter can have.
  println("WHITEBALANCE_BLUE:" + PS3_PARAM.WHITEBALANCE_BLUE.getMinVal() +", "+PS3_PARAM.WHITEBALANCE_BLUE.getMaxVal());
  println("EXPOSURE:         " + PS3_PARAM.EXPOSURE.getMinVal()          +", "+PS3_PARAM.EXPOSURE.getMaxVal());
  println("LENSCORRECTION1:  " + PS3_PARAM.LENSCORRECTION1.getMinVal()   +", "+PS3_PARAM.LENSCORRECTION1.getMaxVal());
}

public void draw() {

  // map mouse values
  int mx = (int) map(mouseX, 0, width, 0, 511);
  int my = (int) map(mouseY, 0, height, PS3_PARAM.LENSCORRECTION1.getMinVal(), PS3_PARAM.LENSCORRECTION1.getMaxVal());

  // set parameters
  ps3.setParameter(PS3_PARAM.AUTO_EXPOSURE, 0);
  ps3.setParameter(PS3_PARAM.LENSCORRECTION1, my);
  ps3.setParameter(PS3_PARAM.EXPOSURE, mx);

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

