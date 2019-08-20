
import ddf.minim.*;

PImage overlayimage;  
PImage Coreoverlayimage; 
PImage extrude;
int[][] values;
float Movieangle = 0;
import codeanticode.gsvideo.*;
int numPixels;
int blockSize = 10;
color myMovieColors[];


GSMovie movie;

Minim minim;
AudioInput in;

PGraphics buffer;
PGraphics pickbuffer;
float a = 0;
float counter=0;
float offset=0;
int box_size =150; 
float angle;

int current_shape=0;
int glowbright=0;
int glowdirection=0;

int last_audioinput_l=0;
int last_audioinput_r=0;
int audio_shift=0;

int[] wave_form_buffer = new int[640];

void addWaveBuffer(int what) {
  arraycopy(wave_form_buffer, 0, wave_form_buffer, 1, wave_form_buffer.length-1);
  wave_form_buffer[0] = int((what+wave_form_buffer[1]+wave_form_buffer[2])/3);
  
} 


PImage img;       // The source image
int cellsize = 2; // Dimensions of each cell in the grid
int columns, rows;   // Number of columns and rows in our system

float[][] kernel = { { 0.3, -0.2, 0.45 },
                     { 0.2, 0.2, -0.15 },
                     { -0.2, 0.3,0.1} };


void setup() {
  
  
  
  size(640, 360,P3D);
  overlayimage = loadImage("overlay.png");
  Coreoverlayimage = loadImage("CoreOverlay.png");
  
    movie = new GSMovie(this, "cube-.3gp");
  movie.loop();
  numPixels = width / blockSize;
  myMovieColors = new color[numPixels * numPixels];
  
img = loadImage("slg.png");
 columns = img.width / cellsize;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
  
  buffer = createGraphics(width, height, P3D);
  buffer.hint(ENABLE_OPENGL_4X_SMOOTH);
   minim = new Minim(this);
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
 
}
void movieEvent(GSMovie movie) {
  movie.read();

}
void draw() {
   //tint(255,150); 
   
    counter++;
    
    
    
     if (current_shape==0) draw_logo_cube();
     if (current_shape==1) draw_pulse_cube();
     if (current_shape==2) draw_inverse_cube();
     if (current_shape==3) logo_burst();
    
     if (current_shape==9){
       draw_inverse_cube();
       draw_logo_cube();
       //draw_pulse_cube();
     }
//fill(255);
//text("HOST/OPERATOR: CG/001-1",10,20);
//text("HOST/OPERATOR: RT/001-2",630,20);
//fill(255,50);
//rect(0,60,abs(int(in.left.get(0)*70))*2,20);
//stroke(255);
//fill(255,50);
//rect(640-abs(int(in.right.get(0)*70))*2,50,640,55);
//rect(640,60,-(abs(int(in.left.get(0)*70))*2),20);
//overlay stuff here
  




  



if (glowdirection==0){
glowbright++;
glowbright++;
glowbright++;
glowbright++;
glowbright++;
glowbright++;
if (glowbright>=254){
 glowdirection=1;  
}
}
if (glowdirection==1){
glowbright--;
glowbright--;
glowbright--;
glowbright--;
glowbright--;
glowbright--;
if (glowbright<=50){
 glowdirection=50;  
}
}

}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  
  super.stop();
}

void draw_logo_cube(){
  box_size=150;
  angle = angle + 0.055;
  //angle = angle + in.left.get(40)+0.015;
    buffer.beginDraw();
    buffer.strokeWeight(40);
    buffer.stroke(glowbright+int(in.left.get(40)*100),30);
    buffer.lights();
    buffer.background(0);
    buffer.pushMatrix();
    buffer.translate( width/2, height/2, 0);
   
    for (int i = 0; i < 5; i++) {
    buffer.rotateY(sin(angle/2));
    buffer.rotateX(cos(angle/2));
    buffer.fill(200,10);
    buffer.box(box_size);
    buffer.rotateY(sin(angle/2));
    buffer.rotateX(-cos(offset+angle/2));
    buffer.fill(200,20);
    buffer.box(box_size+10);
    buffer.image(img, 0, -60, img.width/2, img.height/2);

    
    }
    buffer.popMatrix();
    

    
     
    
buffer.endDraw();
image(buffer, 0, 0); 
  addWaveBuffer(abs(int(in.left.get(0)*50))+abs(int(in.right.get(0)*50)));

  
  
  //waveform_offset
  int wfo_x=0;
  int wfo_y=288;
  for(int i = 0; i < 639 - 1; i++)
  {
    strokeWeight(2);
    stroke((wave_form_buffer[i]+30));

    //if (wave_form_buffer[i]>0)line(i+wfo_x, wfo_y + wave_form_buffer[i], wfo_x + i+1, wfo_y + wave_form_buffer[i+1]);
    line(i+wfo_x, wfo_y + wave_form_buffer[i], wfo_x + i+1, wfo_y);  
  }
image(overlayimage, 0, 0); 
  stroke(255);
  
  
  
}

void draw_pulse_cube(){
  
   //angle = angle + 0.0115;
   angle = angle + wave_form_buffer[0]/50+0.015;
    buffer.beginDraw();
    buffer.strokeWeight(40);
    buffer.stroke(glowbright+random(counter),glowbright-random(counter),glowbright+random(counter),glowbright);
    //buffer.lights();
    buffer.background(0);
    buffer.pushMatrix();
    
    buffer.translate( width/2, height/2, 0);
   
    for (int i = 0; i < 5; i++) {
    
    buffer.rotateY(sin(angle/2));
    buffer.rotateX(cos(angle/2));
    buffer.fill(random(255),random(255),random(255),10);
    buffer.box((int(glowbright)*counter/2)/50);
    if (glowbright>random(300,400))counter=random(50,150);

    
    }
    buffer.popMatrix();
    

    
     
    
buffer.endDraw();
image(buffer, 0, 0);
  addWaveBuffer(abs(int(in.left.get(0)*50))+abs(int(in.right.get(0)*50)));

  
  
  //waveform_offset
  int wfo_x=0;
  int wfo_y=288;
  for(int i = 0; i < 639 - 1; i++)
  {
    strokeWeight(2);
    stroke((wave_form_buffer[i]+30));

    //if (wave_form_buffer[i]>0)line(i+wfo_x, wfo_y + wave_form_buffer[i], wfo_x + i+1, wfo_y + wave_form_buffer[i+1]);
    line(i+wfo_x, wfo_y + wave_form_buffer[i], wfo_x + i+1, wfo_y);  
  }
image(overlayimage, 0, 0); 
}

void draw_inverse_cube(){
  
  angle = angle + 0.1;
  //angle = angle + in.left.get(40);
   buffer.beginDraw();
    buffer.lights();
    buffer.background(0);
  buffer.noStroke();
  box_size=-150;

buffer.pushMatrix();
buffer.translate( width/2, height/2, 0);
buffer.rotateY(sin(angle/2));
buffer.rotateX(cos(angle/2));
buffer.fill(in.left.get(40)*counter,in.right.get(40)*counter,in.left.get(40)*counter);
//box(100);
buffer.box(box_size);
buffer.rotateY(sin(angle/2));
buffer.rotateX(-cos(angle/2));
//box(100);
buffer.box(box_size);
buffer.rotateY(-sin(angle/2));
buffer.rotateX(cos(angle/2));
//box(100);
buffer.box(box_size);
buffer.fill(250);
buffer.rotateY(-sin(angle/2));
buffer.rotateX(-cos(angle/2));
//box(100);
buffer.box(box_size);
buffer.rotateY(sin(angle/2));
buffer.rotateX(cos(angle/2));
//box(100);
buffer.box(box_size);

buffer.rotateY(sin(angle/2));
buffer.rotateX(-cos(angle/2));
buffer.box(box_size);
//box_size=abs(int(400*sin(angle/2)))-(2*(abs(int(400*sin(angle/2)))));

buffer.popMatrix();
buffer.endDraw();
image(buffer, 0, 0);
  addWaveBuffer(abs(int(in.left.get(0)*50))+abs(int(in.right.get(0)*50)));

  
  
  //waveform_offset
  int wfo_x=0;
  int wfo_y=288;
  for(int i = 0; i < 639 - 1; i++)
  {
    strokeWeight(2);
    stroke((wave_form_buffer[i]+30));

    //if (wave_form_buffer[i]>0)line(i+wfo_x, wfo_y + wave_form_buffer[i], wfo_x + i+1, wfo_y + wave_form_buffer[i+1]);
    line(i+wfo_x, wfo_y + wave_form_buffer[i], wfo_x + i+1, wfo_y);  
  }
image(overlayimage, 0, 0); 
}

void keyPressed() {
  println(byte(key));
  if (byte(key)==49) current_shape=0;
  if (byte(key)==50) current_shape=1;
  if (byte(key)==51) current_shape=2;
  if (byte(key)==52) current_shape=3;
  
  if (byte(key)==57) current_shape=9;
  background(0);
}


void logo_burst(){
   
   
  // tint(255,200); 
  //for (int p=0;p<10;p++) text(dna_lookup[int(random(0,3))], int(random(0,640)),int(random(0,480)));
  //image(movie, 0, 0);
  
 
  
  movie.loadPixels();
  values = new int[movie.width][movie.height];
  for (int y = 0; y < movie.height; y++) {
    for (int x = 0; x < movie.width; x++) {
      color pixel = movie.get(x, y);
      values[x][y] = int(brightness(pixel));
    }
  }
   //rotateX(radians(abs(int(in.right.get(0)))));
   translate((width/2)-(movie.width/2), (height/2)-(movie.height/2),0);

  // Display the image mass
  for (int y = 0; y < movie.height; y++) {
    for (int x = 0; x < movie.width; x++) {
      strokeWeight(15);
     // stroke(values[x][y]-abs(int(in.right.get(0))),);
     stroke(values[x][y]+int(in.left.get(40)*50),values[x][y]);
     point(x, y, ((-values[x][y])/8)-abs(int(in.right.get(0))*170)+260);
    }
  }
  
  image(Coreoverlayimage, -(movie.width/2)-150, -(movie.height/2)-35); 
  
}

