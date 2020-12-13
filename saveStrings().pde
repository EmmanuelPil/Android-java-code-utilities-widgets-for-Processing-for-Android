// Be sure to give permission WRITE_EXTERNAL_STORAGE

import android.os.Environment;
import android.Manifest; 
import android.content.pm.PackageManager; 
import android.os.Build; 
import android.os.Build.VERSION_CODES; 
import processing.core.PConstants;
import android.app.Activity; 

Activity activity; 
boolean permissions_granted;
boolean file_saved;

// Folowing file name is the folder you save your text file in.
// If it does not exist it will be created automatically
String stringFolder = "MyStrings";

// Folowing string is the name of your text file
// Be sure to include extension.
String textFile = "MyText.txt";

String[] holder;
String str;

void setup() {
  size(displayWidth, displayHeight);
  activity = this.getActivity();
  if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) { 
    requestParticularPermission();
  }
  holder = new String[3]; 
  holder[0] = "Just";
  holder[1] = "an";
  holder[2] = "example";
  textAlign(CENTER);
  str = "Click to save strings.";
  textSize(12);
  float twf = width/textWidth(str);
  textSize(8*twf);
  text(str, width/2, height/2);
}

void draw() {
  background(0, 0, 200); 
  if (permissions_granted && file_saved) {
    text("File saved", width/2, height/2);
  } else {
    text("Click to save strings", width/2, height/2);
  }
}


void mousePressed() {
  saveMyText(stringFolder, textFile, holder);
}

void saveMyText(String sf, String tf, String[] sh) { 
  try { 
    String absolute_path = new String(Environment.getExternalStorageDirectory().getAbsolutePath()); 
    File file = new File(absolute_path+"/"+sf); 
    println(file);
    if (!file.exists()) { 
      boolean success = true; 
      success = file.mkdirs();
    } 
    saveStrings(file+"/"+tf, sh);
    if (permissions_granted) {
      println("File saved successfully.");
      file_saved = true;
    }
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
