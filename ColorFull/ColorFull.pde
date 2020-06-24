import KinectPV2.*;
KinectPV2 kinect;

void setup() {
  fullScreen();

  kinect = new KinectPV2(this);

  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);

  kinect.init();

  colorMode(HSB, 1f);
}

void draw() {
  final float near = 300f;
  final float far = 1500f;

  int[] depth = kinect.getRawDepthData();

  loadPixels();

  background(0);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      double kx = ((double)x/width) * KinectPV2.WIDTHDepth;
      double ky = ((double)y/height) * KinectPV2.HEIGHTDepth;
      double wx = kx % 1d;
      double wy = ky % 1d;
      int i = (int)Math.floor(kx) + (int)Math.floor(ky) * KinectPV2.WIDTHDepth;
      int d = depth[i];

      if (d>=near && d<far) {
        pixels[x+y*width] = color(((float)d-near)/(far-near), .5f, .5f);
      } else {
        pixels[x+y*width] = color(0);
      }
    }
  }

  updatePixels();
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
