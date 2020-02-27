// Be sure to give permission WRITE_EXTERNAL_STORAGE

import android.os.Environment;

void setup() {
  String[] holder = new String[3]; 
  holder[0] = "Just";
  holder[1] = "an";
  holder[2] = "example";
  // Folowing file name is the folder you save your text file in.
  // If it does not exist it will be created automatically
  String stringFolder = "MyStrings";
  // Folowing string is the name of your text file
  // Be sure to include extension.
  String textFile = "MyText.txt";
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
    println("File saved successfully.");
  } 
  catch (Exception e) { 
    println("Error while saving file: " + e);
  }
}  
