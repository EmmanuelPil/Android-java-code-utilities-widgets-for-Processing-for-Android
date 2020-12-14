// Do not forget to give READ/WRITE permission

import android.os.Environment;
import android.Manifest; 
import android.content.pm.PackageManager; 
import android.os.Build; 
import android.os.Build.VERSION_CODES; 
import processing.core.PConstants;
import android.app.Activity; 

PImage img;
Activity activity; 
boolean image_saved;
boolean permissions_granted;

// Folowing file name is the folder you save your image file in.
// If it does not exist it will be created automatically
String folder_name = "MyImageFolder";

// Folowing string is the name of your image file
// Be sure to include extension.
String image_file = "MyImage.png";

void setup() {
  size(displayWidth, displayHeight);
  background(0, 0, 200); 
  rectMode(CENTER);
  rect(width/2, height/2, width, height/2);
  textAlign(CENTER);
  String str = "Click to save an image.";
  textSize(12);
  float twf = width/textWidth(str);
  textSize(8*twf);
  fill(0);
  text(str, width/2, height/2);
  activity = this.getActivity();
  if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) { 
    requestParticularPermission();
  }
  img = get();
}

void draw() {
  if (permissions_granted && image_saved) {
    background(0, 0, 200);
    fill(255);
    text("Image saved.", width/2, height/2);
  } 
}

void mousePressed() {
  saveMyImage(folder_name, image_file);
}

void saveMyImage(String sf, String tf) { 
  try { 
    String absolute_path = new String(Environment.getExternalStorageDirectory().getAbsolutePath()); 
    File file = new File(absolute_path+"/"+sf); 
    println(file);
    if (!file.exists()) { 
      boolean success = true; 
      success = file.mkdirs();
    } 
    save(file+"/"+tf);
    image_saved = true;
    println("File saved successfully.");
  } 
  catch (Exception e) { 
    println("Error while saving file: " + e);
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
      permissions_granted = true;
    } else { 
      println("permissions not granted");
    } 
    break; 
  default: 
    activity.onRequestPermissionsResult(requestCode, permissions, grantResults);
  }
}
