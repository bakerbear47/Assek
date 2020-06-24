import KinectPV2.*;
KinectPV2 kinect;

PGraphics pg;

int blobCounter = 0;

int maxLife = 10;

//int id = 0;

PImage img;

color trackColor;

float distThreshold = 300;


ArrayList<Blob> blobs = new ArrayList<Blob>();


void setup() {


  fullScreen(P2D);
  //size(800, 600, P3D);
  kinect = new KinectPV2(this);


  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  //kinect.enableInfraredImg(true);

  kinect.init();

  //img = createImage(width, height, RGB);

  trackColor = color(255, 0, 150);

  pg = createGraphics(width, height);
}

void draw() {

  final float near = 300f;
  final float far = 1500f;

  pg.beginDraw();

  pg.loadPixels();


  int[] depth = kinect.getRawDepthData();

  //blobs.clear();
  ArrayList<Blob> currentBlobs = new ArrayList<Blob>();
  

  for (int x = 0; x < width; x++ ) {
    for (int y = 0; y < height; y++ ) {
      double kx = ((double)x/width) * KinectPV2.WIDTHDepth;
      double ky = ((double)y/height) * KinectPV2.HEIGHTDepth;
      int offset = (int)Math.floor(kx) + (int)Math.floor(ky) * KinectPV2.WIDTHDepth;
      int d = depth[offset];
      

      if (d>near && d<far) {

        pg.pixels[x+y*width] = trackColor;

        boolean found = false;
        
        for (Blob b : currentBlobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          currentBlobs.add(b);
        }
      }
      else if (blobs.size()==1  ) {
        colorMode(HSB);
        int sum = 0;
        for (Blob b : blobs) {
          float distOut = dist(x, y, b.getCenter().x, b.getCenter().y);
          sum += 10 * b.size()/distOut;
        }
        pg.pixels[x+y*width] = color(sum % 255, 255, 255);
      } 

      else {
        pg.pixels[x+y*width] = color(0, 0, 0);
      }
    }
  }


  for (int i = currentBlobs.size()-1; i >= 0; i--) {
    if (currentBlobs.get(i).size()<1500) {
      currentBlobs.remove(i);
    }
  }
  if (blobs.isEmpty() && currentBlobs.size()>0) {
    for (Blob b : currentBlobs) {
      b.id = blobCounter;
      blobs.add(b);
      blobCounter++;
    }
  } else if (blobs.size() <= currentBlobs.size()) {
    
    for (Blob b : blobs) {
      //b = new Blob(0.0,0.0);
      float recordD = 1000;
      Blob matched = null;
      
      for (Blob cb : currentBlobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();
        float d = PVector.dist(centerB, centerCB);
        if (d<recordD && !cb.taken) {
          recordD=d;
          matched = cb;
        }
      }if(matched != null){
      matched.taken = true;
      b.become(matched);
      }
    }

    for (Blob b : currentBlobs) {
      if (!b.taken) {
        b.id=blobCounter;
        blobs.add(b);
        blobCounter++;
      }
    }
  } else if (blobs.size() > currentBlobs.size()) {
    for (Blob b : blobs) {
      b.taken=false;
    }
    for (Blob cb : currentBlobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob b : blobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();
        float d = PVector.dist(centerB, centerCB);
        if (d<recordD && !b.taken) {
          recordD=d;
          matched = b;
        }
      }
      if (matched != null) {
        matched.taken = true;
        matched.become(cb);
      }
    }
    for (int i = blobs.size()-1; i >= 0; i--) {
      Blob b = blobs.get(i);
      if (!b.taken) {
        if (b.checkLife()) {
          blobs.remove(i);
        }
      }
    }
  }




  pg.updatePixels();

  pg.endDraw();

  image(pg, 0, 0);
  
  for (Blob b : blobs) {
    b.show();
  }

  textAlign(CENTER);
  fill(140);
  textSize(24);
  text(currentBlobs.size()+"currentblobs", width-10, 40);
  text(blobs.size()+"blobs", width-10, 80);
  text(blobCounter+ "nr", 20, 20);
}

//blobs.clear();
//image(img, 0, 0);
// Begin loop to walk through every pixel
//for (int x = 0; x < width; x ++ ) {
//for (int y = 0; y < height; y ++ ) {
/*double kx = ((double)x/width) * KinectPV2.WIDTHDepth;
 double ky = ((double)y/height) * KinectPV2.HEIGHTDepth;
 int loc = (int)Math.floor(kx) + (int)Math.floor(ky) * KinectPV2.WIDTHDepth;
 */
// What is current color
/*      color currentColor = pixels[offset];
 float r1 = red(currentColor);
 float g1 = green(currentColor);
 float b1 = blue(currentColor);
 float r2 = red(trackColor);
 float g2 = green(trackColor);
 float b2 = blue(trackColor);
 
 // Using euclidean distance to compare colors
 float d2 = distSq(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.
 */
// If current color is more similar to tracked color than
// closest color, save current location and current difference
//if (d2 < threshold*threshold ) {
//if(pixels[offset]==trackColor){
//worldRecord = d;
//avgX += x;
//avgY += y;
//count++;
//closestX = x;
//closestY = y;
/* boolean found = false;
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
 
 for (Blob b : blobs) {
 if (b.size()>500) {
 b.show();
 }
 }
 }
 */
float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) +(y2-y1)*(y2-y1);
  return d;
}

/*float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
 float d = (x2-x1)*(x2-x1) +(y2-y1)*(y2-y1)+(y2-y1)*(y2-y1);
 return d;
 }
 */
