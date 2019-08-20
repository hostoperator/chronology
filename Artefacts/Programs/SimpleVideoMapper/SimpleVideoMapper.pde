/**
 * Loop. 
 * Built-in video library replaced with gsvideo by Andres Colubri
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 *
 * Note: GSVideo uses GStreamer as the underlying multimedia library
 * for reading media files, decoding, encoding, etc.
 * It is based on a set of Java bindings for GStreamer called
 * gstreamer-java originally created by Wayne Meissner and currently
 * mantained by a small team of volunteers. GStreamer-java can be 
 * used from any Java program, and it is available for download at
 * the following website:
 * http://code.google.com/p/gstreamer-java/
 */

import deadpixel.keystone.*;
import codeanticode.gsvideo.*;

GSMovie movie;

PGraphics offscreen;

Keystone ks;
CornerPinSurface surface;

import fullscreen.*; 
GSPlayer sample;
FullScreen fs; 
PImage img; 

void setup() {
  
  size(1280, 720 ,P3D);
  // Create the fullscreen object
  fs = new FullScreen(this); 
  
  // enter fullscreen mode
  fs.enter(); 

  background(0);
  // Load and play the video in a loop
  String[] filenames = listFileNames(sketchPath("") + "Video\\");

  movie = new GSMovie(this, sketchPath("")+"Video\\" + filenames[0]);
    println(sketchPath("")+"Video\\" + filenames[0]);
  movie.loop();
  


  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(1280, 720, 40);
    offscreen = offscreen = createGraphics(1280, 720, P2D);
    ks.load();
}

void movieEvent(GSMovie movie) {
  movie.read();
}

void draw() {
  //tint(255, 20);
   // convert 
  PVector mouse = surface.getTransformedMouse();

  // first draw the sketch offscreen
  offscreen.beginDraw();
  offscreen.background(255);
  offscreen.fill(0, 255, 0);
  offscreen.image(movie, 0, 0);
  offscreen.endDraw();

  

  // then render the sketch using the 
  // keystoned surface
  background(0);
 surface.render(offscreen);
  
}

// Controls for the Keystone object
void keyPressed() {

  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // & moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}

String[] listFileNames(String dir) {

  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
