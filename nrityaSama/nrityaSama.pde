
import processing.sound.*;

float t = 0;
float r = random(255);
float g = random(255); 
float b = random(255);


FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];


void setup() {
  
  fullScreen();
  background(0);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  fft.input(in);
  
}

void draw() { 
    
    fft.analyze(spectrum); 
    
    drawMandala();
    drawEllipticalWaves();

}
void drawMandala(){
    
    stroke(r, g, b);
    strokeWeight(3);
    translate(width/2, height/2);
    
    
    r = (r + 1) % 255;
    g = (g + 1) % 255;
    b = (b + 1) % 255;
    
    point(x(t), y(t));
    t+=0.8;
}

void drawEllipticalWaves(){
  fill(0);
  
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    ellipse(width/32-20, height/16, i*0.75, spectrum[i]*height );
  } 
}

float x(float t){
  return sin(t/10) * 300 + cos(t/50) * 80;
}

float y(float t){
  return cos(t/10) * 300 + sin(t/50) * 120;
}