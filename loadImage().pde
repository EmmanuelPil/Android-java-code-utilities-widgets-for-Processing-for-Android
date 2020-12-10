// Tested on Lollipo and Android 10

import android.os.Environment;

String image_folder = "MyPhotos";
String directory = new String(Environment.getExternalStorageDirectory().getAbsolutePath()+"/"+image_folder+"/");
PImage img;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  imageMode(CENTER);
  loadMyImage("jelly.jpg");
  image(img, width/2, height/2);
}


void loadMyImage(String s) {
  img = loadImage(directory+s);
} 
