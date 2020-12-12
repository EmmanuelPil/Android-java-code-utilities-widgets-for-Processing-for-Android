// Tested on Lollipop and Android 10
// Do not forget to give READ/WRITE permission

import android.os.Environment;
import android.Manifest; 
import android.content.pm.PackageManager; 
import android.os.Build; 
import android.os.Build.VERSION_CODES; 
import processing.core.PConstants;
import android.app.Activity; 

String image_folder = "MyPhotos"; // Must be an existing folder
PImage img;
boolean image_loaded;
Activity activity; 

void setup() {
  size(displayWidth, displayHeight);
  background(0, 0, 200); 
  textAlign(CENTER);
  String str = "Click to load image.";
  textSize(12);
  float twf = width/textWidth(str);
  textSize(8*twf);
  text(str, width/2, height/2);
  activity = this.getActivity();
  if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) { 
    requestParticularPermission();
  }
  imageMode(CENTER);
}

void draw() {
  if (image_loaded) {
    if (img != null) {
      background(0, 0, 200); 
      image(img, width/2, height/2);
    } else {
      text("Image could not be found", width/2, height/2);
    }
  }
}

void mousePressed() {
  loadMyImage("jelly.jpg");
}

void loadMyImage(String s) {
  try {
    String directory = new String(Environment.getExternalStorageDirectory().getAbsolutePath()+"/"+image_folder+"/");
    img = loadImage(directory+s);
    image_loaded = true;
  } 
  catch (Exception e) {
    background(0, 0, 200);
    text("Image could not be found.", width/2, height/2);
  }
}

private static String[] PERMISSIONS_STORAGE = { Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE }; 
private void requestParticularPermission() { 
  activity.requestPermissions(PERMISSIONS_STORAGE, 2020);
}

public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) { 
  switch (requestCode) { 
  case 2020: 
    if (grantResults[0] == PackageManager.PERMISSION_GRANTED) { 
      println("permissions granted");
    } else { 
      println("permissions not granted");
    } 
    break; 
  default: 
    activity.onRequestPermissionsResult(requestCode, permissions, grantResults);
  }
}
