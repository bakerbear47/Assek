// TODO: Winther saiz: To use actual Kinect data, un-comment the following "import..." line, and rename the dummy "KinectPV2" class in here to something else (like "KinectPV2Temp")
<<<<<<< Updated upstream
//import KinectPV2.*;

import processing.sound.*;

=======
import KinectPV2.*;
>>>>>>> Stashed changes
KinectPV2 kinect;

FFT fft;
AudioIn in;

int bands = 512;
float[] spectrum = new float[bands];

//PImage img;

//color trackColor;

// Winther saiz: I moved "distThreshold" to the "Blob" class, since that is where it is used if it's needed at all (I would remove this and Blob both completely, but that's another hornets nest entirely...) 
//float distThreshold = 250;

//float threshold = 25;

//ArrayList<Blob> blobs = new ArrayList<Blob>();

static final float nearView = 500f;
static final float farView = 1500f;

// Winther saiz: Dummy class, quick fix hack... HACK! HACK!! HACK!!! // TODO: Find a better way to fix things in the absence of a real Kinect
<<<<<<< Updated upstream
public class KinectPV2 {
  static final int WIDTHDepth = 320;
  static final int HEIGHTDepth = 240;
  int ticks;
  KinectPV2(Object _) {
  }
  void enableDepthImg(boolean _) {
  }
  void enablePointCloud(boolean _) {
  }
  void enableInfraredImg(boolean _) {
  }
  void init() {
    ticks = 0;
  }
  int[] getRawDepthData() {
    int[] res = new int[WIDTHDepth*HEIGHTDepth];
    double ocx = .5d;
    double ocy = .5d;
    double odia = .85d;
    int pulse = 100;
    double t = (double)(ticks++%pulse)*2d/(pulse-1)-1d;

    odia -= .85d*t*t;

    for (int y = 0; y < HEIGHTDepth; y++) {
      for (int x = 0; x < WIDTHDepth; x++) {
        double ax = 2d * ((((double)x+.5d) / WIDTHDepth) - ocx);
        double ay = 2d * ((((double)y+.5d) / HEIGHTDepth) - ocy);
        int d = (int)Math.round((farView - nearView)*(odia - (ax*ax+ay*ay))/.85d);
        if (d > 0) {
          res[x+y*WIDTHDepth] = (int)farView-d;
        } else {
          res[x+y*WIDTHDepth] = 0;
        }
      }
    }

    return res;
  }
}
=======
//public class KinectPV2 {
//  static final int WIDTHDepth = 320;
//  static final int HEIGHTDepth = 240;
//  int ticks;
//  KinectPV2(Object _) {
//  }
//  void enableDepthImg(boolean _) {
//  }
//  void enablePointCloud(boolean _) {
//  }
//  void enableInfraredImg(boolean _) {
//  }
//  void init() {
//    ticks = 0;
//  }
//  int[] getRawDepthData() {
//    int[] res = new int[WIDTHDepth*HEIGHTDepth];
//    double ocx = .5d;
//    double ocy = .5d;
//    double odia = .85d;
//    int pulse = 100;
//    double t = (double)(ticks++%pulse)*2d/(pulse-1)-1d;

//    odia -= .85d*t*t;

//    for (int y = 0; y < HEIGHTDepth; y++) {
//      for (int x = 0; x < WIDTHDepth; x++) {
//        double ax = 2d * ((((double)x+.5d) / WIDTHDepth) - ocx);
//        double ay = 2d * ((((double)y+.5d) / HEIGHTDepth) - ocy);
//        int d = (int)Math.round(1200*(odia - (ax*ax+ay*ay))/.85d);
//        if (d > 0) {
//          res[x+y*WIDTHDepth] = 1500-d;
//        } else {
//          res[x+y*WIDTHDepth] = 0;
//        }
//      }
//    }

//    return res;
//  }
//}
>>>>>>> Stashed changes

void setup() {
  fullScreen();
  //size(640, 480);
  //size(640, 480, P3D);
  kinect = new KinectPV2(this);

  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  //kinect.enableInfraredImg(true);

  kinect.init();

  //img = createImage(KinectPV2.WIDTHDepth, KinectPV2.HEIGHTDepth, RGB);

  //trackColor = color(255, 0, 150);

<<<<<<< Updated upstream
  colorMode(HSB, 1f);

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
=======
/*
int x = 1;
long y = 1L;
float a = 1f;
double b = 1d;
*/
  colorMode(HSB, 1f); //<>//
>>>>>>> Stashed changes
}

void draw() {
  final float near = 300f;
  final float far = 1500f;
  
  int[] depth = kinect.getRawDepthData();
  //scale(0.5);
  loadPixels();

  background(0);
  fft.analyze(spectrum);

  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  line(i, height, i, height - spectrum[i]*height*5 );
  } 

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      double kx = ((double)x/width) * KinectPV2.WIDTHDepth;
       double ky = ((double)y/height) * KinectPV2.HEIGHTDepth;
       double wx = kx % 1d;
       double wy = ky % 1d;
       int i = (int)Math.floor(kx) + (int)Math.floor(ky) * KinectPV2.WIDTHDepth;
       int d = depth[i];
<<<<<<< Updated upstream
       /** Interpolering:
=======
       /** Interpolation:
>>>>>>> Stashed changes
       int d = (int)Math.round((i+1)%KinectPV2.WIDTHDepth > 0 ? 
       (((i/KinectPV2.WIDTHDepth)+1)%KinectPV2.HEIGHTDepth > 0 ?
       (1d-wy)*((1d-wx)*depth[i]+wx*depth[i+1])+wy*((1d-wx)*depth[i+KinectPV2.WIDTHDepth]+wx*depth[i+KinectPV2.WIDTHDepth+1]) :
       (1d-wx)*depth[i]+wx*depth[i+1]) :
       (((i/KinectPV2.WIDTHDepth)+1)%KinectPV2.HEIGHTDepth > 0 ? (1d-wy)*depth[i]+wy*depth[i+KinectPV2.WIDTHDepth] : depth[i]));
       */
<<<<<<< Updated upstream
       if (d>=nearView && d<farView) {
       pixels[x+y*width] = color(((float)d-nearView)/(farView-nearView), .5f, .5f);
=======
       if (d>=near && d<far) {
       pixels[x+y*width] = color(((float)d-near)/(far-near), .5f, .5f);
>>>>>>> Stashed changes
       } else {
       pixels[x+y*width] = color(0);
       }
    }
  }

  updatePixels();

// TODO: Winther saiz: I'd remove all this commented code, but thought you might want to have a last look to see if you'll need anything, before it gets sent to the eternal /dev/null
  /*
  img.loadPixels();
   
   int[] depth = kinect.getRawDepthData();
   
   for (int x = 0; x < KinectPV2.WIDTHDepth; x++ ) {
   for (int y = 0; y < KinectPV2.HEIGHTDepth; y++ ) {
   int offset = x + y * KinectPV2.HEIGHTDepth;
   int d = depth[offset];
   
   if (d>300 && d<1500) {
   
   img.pixels[offset] = color(255, 0, 150);
   } else {
   img.pixels[offset] = color(0);
   }
   }
   }
   
   img.updatePixels();
   image(img, 0, 0, width, height);
   
   
   blobs.clear();
   
   // Begin loop to walk through every pixel
   for (int x = 0; x < img.width; x ++ ) {
   for (int y = 0; y < img.height; y ++ ) {
   int loc = x + y*img.width;
   // What is current color
   color currentColor = img.pixels[loc];
   float r1 = red(currentColor);
   float g1 = green(currentColor);
   float b1 = blue(currentColor);
   float r2 = red(trackColor);
   float g2 = green(trackColor);
   float b2 = blue(trackColor);
   
   // Using euclidean distance to compare colors
   float d = distSq(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.
   
   // If current color is more similar to tracked color than
   // closest color, save current location and current difference
   if (d < threshold*threshold ) {
   //worldRecord = d;
   //avgX += x;
   //avgY += y;
   //count++;
   //closestX = x;
   //closestY = y;
   boolean found = false;
   for (Blob b : blobs) {
   if (b.isNear(x, y)) {
   b.add(x, y);
   found = true;
   break;
   }
   }
   
   if (!found) {
   Blob b = new Blob(x, y);
   blobs.add(b);
   }
   }
   }
   }
   boolean showMeta = false;
   for (Blob b : blobs) {
   if (b.size() < 4) {
   showMeta = !showMeta;
   }
   }
   
   
   if (showMeta) {
   colorMode(HSB);
   loadPixels();
   for (int x = 0; x<width; x++) {
   for (int y = 0; y < height; y++) {
   int index = x + y * width;
   float sum = 0;
   for (Blob b : blobs) {
   float d = dist(x, y, b.getX(), b.getY());
   sum += 15000/d;
   }
   
   pixels[index] = color(sum, 255, 255);
   }
   }
   updatePixels();
   colorMode(RGB);
   }
   for (Blob b : blobs) {
   if (b.size()>500) {
   b.show();
   }
   }
   */
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) +(y2-y1)*(y2-y1);
  return d;
}

// TODO: Winther saiz: Strongly consider using (64-bit) double-s instead of (32-bit) float-s
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float dx = x2 - x1;
  float dy = y2 - y1;
  float dz = z2 - z1;

  return dx*dx + dy*dy + dz*dz;
}
