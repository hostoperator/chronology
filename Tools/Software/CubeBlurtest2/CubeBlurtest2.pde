
float angle;
float v = 1.4/19.0;
float[][] kernel = { { 0.3, -0.2, 0.45 },
                     { 0.2, 0.2, -0.15 },
                     { -0.2, 0.3,0.1} };

int box_size = -250;                     

void setup() 
{
  size(640, 480,P3D);
  noStroke();
  frameRate(30);


  // Set the starting position of the shape

}


void draw() 
{
  background(0);
lights();
  angle = angle + 0.1;

//Draw Box Bit  
//noStroke();
//noFill();
//strokeWeight(10);
//stroke(100);
pushMatrix();
translate( width/2, height/2, 0);
rotateY(sin(angle/2));
rotateX(cos(angle/2));
fill(200);
//box(100);
box(box_size);
rotateY(sin(angle/2));
rotateX(-cos(angle/2));
//box(100);
box(box_size);
rotateY(-sin(angle/2));
rotateX(cos(angle/2));
//box(100);
box(box_size);
fill(250);
rotateY(-sin(angle/2));
rotateX(-cos(angle/2));
//box(100);
box(box_size);
rotateY(sin(angle/2));
rotateX(cos(angle/2));
//box(100);
box(box_size);

rotateY(sin(angle/2));
rotateX(-cos(angle/2));
box(box_size);
//box_size=abs(int(400*sin(angle/2)))-(2*(abs(int(400*sin(angle/2)))));

popMatrix();

loadPixels();

for (int y = 1; y < height-1; y++) { // Skip top and bottom s
  for (int x = 1; x < width-1; x++) { // Skip left and right s
    float sum = 0; // Kernel sum for this pixel
    for (int ky = -1; ky <= 1; ky++) {
      for (int kx = -1; kx <= 1; kx++) {
        // Calculate the adjacent pixel for this kernel point
        int pos = (y + ky)*width + (x + kx);
        // Image is grayscale, red/green/blue are identical
        float val = red(pixels[pos]);
        // Multiply adjacent pixels based on the kernel values
        sum += kernel[ky+1][kx+1] * val;
      }
    }
    // For this pixel in the new image, set the gray value
    // based on the sum from the kernel
    pixels[y*width + x] = color(sum);
  }
}


updatePixels();
  
 
  
}
