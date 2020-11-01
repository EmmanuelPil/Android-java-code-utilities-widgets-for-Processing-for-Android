import android.media.MediaPlayer;
import android.content.res.Resources;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.content.Context;
import android.app.Activity;
 

MediaPlayer player = new MediaPlayer();
AssetFileDescriptor fd;
Context context;
Activity activity;
String sound_file_name = "Over_the_horizon.mp3";

void setup() {
  fullScreen();
  background(0, 0, 200);
  orientation(PORTRAIT);
  textSize(60);
  textAlign(CENTER, CENTER);
  activity = this.getActivity();
  context = activity.getApplicationContext();
  try {
    fd = context.getAssets().openFd(sound_file_name);
    player.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  text("Press to start", width/2, height/2);
}

void draw() {
}

void mousePressed() {
  try {
    player.prepare();
    player.start();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void onPause() {
  super.onPause();
  if (player!=null) {
    player.release();
    player= null;
  }
}

void onStop() {
  super.onStop();
  if (player!=null) {
    player.release();
    player= null;
  }
}

void onDestroy() {
  super.onDestroy();
  if (player!=null) {
    player.release();
    player= null;
  }
}
