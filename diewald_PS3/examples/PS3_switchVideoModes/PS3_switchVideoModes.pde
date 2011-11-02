//------------------------------------------------------------------------------
//
// author: thomas diewald
// date:   02.11.2011
//
// switching between the different video/color-modes.
//
// keys: '1' to '5' .... choose colormode
// keys: ' ' ........... toggle VGA/QVGA - (640x480)/(320/240)
// key:  'x' ........... start camera 
// key:  'y' ........... stop camera
//------------------------------------------------------------------------------

import diewald_PS3.PS3;
import diewald_PS3.constants.COLOR_MODE;
import diewald_PS3.constants.VIDEO_MODE;
import diewald_PS3.logger.PS3Logger;



PS3 ps3;
VIDEO_MODE video_mode = VIDEO_MODE.VGA;
COLOR_MODE color_mode = COLOR_MODE.COLOR_PROCESSED;

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
  initPS3(ps3, VIDEO_MODE.VGA, COLOR_MODE.COLOR_PROCESSED, 30);
}

public void draw() {
  background(255);
  assignPixels(ps3, img);
  image(img, 0, 0);

  ps3.setLed(mousePressed);
}

public void assignPixels(PS3 ps3, PImage img) {
  img.loadPixels();
  ps3.getFrame(img.pixels);
  img.updatePixels();
}

public void initPS3(PS3 ps3, VIDEO_MODE mode, COLOR_MODE color_mode, int fps ) {
  ps3.init(mode, color_mode, fps);
  img = createImage(ps3.getWidth(), ps3.getHeight(), ARGB);
  ps3.start();
}

public void keyReleased() {
  if ( key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == ' ') {
    if (key == '1') color_mode = COLOR_MODE.COLOR_PROCESSED;
    if (key == '2') color_mode = COLOR_MODE.MONO_PROCESSED;
    if (key == '3') color_mode = COLOR_MODE.COLOR_RAW;
    if (key == '4') color_mode = COLOR_MODE.MONO_RAW;
    if (key == '5') color_mode = COLOR_MODE.BAYER_RAW;

    if ( key == ' ') video_mode = (video_mode == VIDEO_MODE.VGA) ? VIDEO_MODE.QVGA : VIDEO_MODE.VGA; // toggle videomode

    initPS3(ps3, video_mode, color_mode, 60);
  }

  if (key == 'x') ps3.start();
  if (key == 'y') ps3.stop();
}

public void dispose() {
  PS3.shutDown();
}

