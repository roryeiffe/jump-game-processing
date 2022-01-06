PImage image;
PImage big;
void setup() {  // setup() runs once
  size(400, 400);
  frameRate(150);
  image = loadImage("400by400.jpg");
  big = image.copy();
  image.resize(50, 50);
}

void draw(){

image(image,0,0);
image(big,100,100);
}