// Tested on Lollipo and Android 10

import android.os.Environment;
import java.io.IOException;
String image_folder = "MyPhotos"; // Must be an existing folder
PImage img;

void setup() {
  size(displayWidth, displayHeight);
  loadMyImage("jelly.jpg");
  imageMode(CENTER);
  if(img != null) image(img, width/2, height/2);
}


void loadMyImage(String s) {
  try {
    String directory = new String(Environment.getExternalStorageDirectory().getAbsolutePath()+"/"+image_folder+"/");
    img = loadImage(directory+s);
  } 
  catch (Exception e) {
    background(0, 0, 200);
    String str = "Image could not be found";
    pushStyle();
    textAlign(CENTER);
    textSize(12);
    float twf = width/textWidth(str);
    textSize(9*twf);
    text(str, width/2, height/2);
    popStyle();
  }
} 
