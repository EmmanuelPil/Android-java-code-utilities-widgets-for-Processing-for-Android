// Remember to give READ WRITE permissions


import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.PopupMenu;
import android.widget.PopupMenu.OnMenuItemClickListener;
import android.widget.TextView;
import android.app.Activity;
import android.content.Context;
import android.widget.FrameLayout;
import android.view.ViewGroup.LayoutParams;
import android.view.Gravity;
import android.R;
import android.widget.RelativeLayout;
import processing.android.CompatUtils;
import android.graphics.Color;
import android.view.WindowManager;
import android.os.Bundle;
import android.os.Environment;
import android.widget.Toast;
import android.view.ViewParent;
import android.view.ViewGroup;
import android.view.LayoutInflater;
import android.R.string;
import java.lang.reflect.Method;
import java.util.ArrayList;
import processing.core.PApplet;
import android.view.View;
import android.view.ViewManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.Manifest; 
import android.content.pm.PackageManager; 
import android.os.Build; 
import android.os.Build.VERSION_CODES; 
import processing.core.PConstants;

PImage img;
Activity act; 
Context mC;
FrameLayout fl;
SelectionList selectionlist;
RelativeLayout rl;

boolean image_saved, permissions_granted;
boolean restart, clickable, first_run, image_drawn, listview_placed;
int menuanchorId, menubarId, lvbgId, imgy;
String item_choise, last_action;
String plotfilespath, selection;
String[] plotfiles, plotfilesclean;
double x, y, zr, zi, zr2, zi2, cr, ci, n;
double zmx1, zmx2, zmy1, zmy2, f, di, dj;
double fn1, fn2, fn3, re, gr, bl, xt, yt, i, j;
float mtrx, mtry; 

void setup() {
  fullScreen();
  orientation(PORTRAIT);
  background(#F6BC47);
   if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) { 
    requestParticularPermission();
  }
  di = 0;
  dj = 0;
  f = 10;
  i = 520;
  imgy = (height-width-3)/2;
  fn1 = random(20); 
  fn2 = random(20); 
  fn3 = random(20);
  zmx1 = int(500/4);
  zmx2 = 2;
  zmy1 = int(500/4);
  zmy2 = 2;
  mtrx = (width-500)/2;
  mtry = (height-500)/2;
  img = loadImage("Startimg.png");
  img.resize(width-30, width);
  int imgstrty = (height-img.height)-height/7;
  image(img, 15, imgstrty);
  img = null;
  first_run = true;
  item_choise = "1,4";
  pushMatrix();
  stroke(#8A0000);
  noFill();
  strokeWeight(4);
  rect(15, imgstrty, width-30, width); 
  popMatrix();
  fill(#8A0000);
  textAlign(CENTER);
  textSize(height/43);
  int texty = height/10;
  int textbetween = height/44;
  text("Please use menu to start drawing.", width/2, texty);
  text("Tap on an interesting area with a lot of contours.", width/2, texty+textbetween); 
  text("Mandelbrot calculations are extremely slow.", width/2, texty+2*textbetween);
  text("Therefore working area is reduced to 500 by 500.", width/2, texty+3*textbetween);
  text("Then it will be resized.", width/2, texty+4*textbetween);
  text("You don't have to wait for a compleet drawing.", width/2, imgstrty+width+height/20);
  text("You may tap again while drawing.", width/2, imgstrty+width+height/20+textbetween);
  plotfilespath = Environment.getExternalStorageDirectory().toString() + "/Mandelbrot_zoomer";
}

void draw() {
  if (clickable) {
    //image_drawn = false;
    if (i <= 500) i++;
    x = (i+di)/zmx1-zmx2;
    for (j = 0; j <= 500; j++) {
      y = zmy2-(j+dj)/zmy1;
      zr = 0;
      zi = 0;
      zr2 = 0; 
      zi2 = 0; 
      cr = x; 
      ci = y; 
      n = 1;
      while (n < 200 && (zr2+zi2) < 4) {
        zi2 = zi*zi;
        zr2 = zr*zr;
        zi = 2*zi*zr+ci;
        zr = zr2-zi2+cr;
        n++;
        if (restart) break;
      } 
      re = (n*fn1) % 255;
      gr = (n*fn2) % 255;
      bl = (n*fn3) % 255;
      strokeWeight(1);
      stroke((float)re, (float)gr, (float)bl); 
      point((float)i+mtrx, (float)j+mtry);
      if (restart) break;
    }
  }
  if (i == 501){ 
     item_choise = "2,3,4";
     image_drawn = true;
     i++;
   }
}

void restart() {
  background(#F6BC47);
  x = 0; 
  y = 0; 
  zr = 0; 
  zi = 0; 
  zr2 = 0; 
  zi2 =0; 
  cr =0; 
  ci = 0; 
  n = 0;
  f = 0; 
  di = 0; 
  dj = 0; 
  fn1 = 0; 
  fn2 = 0; 
  fn3 = 0; 
  re = 0; 
  gr = 0;
  bl = 0; 
  xt = 0; 
  yt = 0; 
  i = 0; 
  j = 0; 
  di = 0; 
  dj = 0;
  f = 10;
  fn1 = random(20); 
  fn2 = random(20); 
  fn3 = random(20);
  zmx1 = int(500/4);
  zmx2 = 2;
  zmy1 = int(500/4);
  zmy2 = 2;
  restart = false;
}

void resizeImage() {
  clickable = false;
  if (image_drawn){ 
    img = get(int(mtrx), int(mtry), 500, 500);
    img.resize(width-30, width);
    //image_resized = true;
    drawRectangle();
    image(img, 15, imgy);
    item_choise = "1,3,4";
    i = 0;
  }
  
}

void mousePressed() {
  if (mouseX > mtrx && mouseX < mtrx+500 && mouseY > mtry && mouseY < mtry+500) {
    if (clickable) {
      background(#F6BC47); 
      xt = mouseX;
      yt = mouseY;
      di = di+xt-float(width/2);
      dj = dj+yt-float(height/2);
      zmx1 = zmx1*f;
      zmx2 = zmx2*(1/f);
      zmy1 = zmy1*f;
      zmy2 = zmy2*(1/f);
      di = di*f;
      dj = dj*f;
      i = 0;
      j = 0;
    }
  }
}

void saveImage() {
  if (img != null && img.height == width) { // image was resized
    save();
  } else if (image_drawn){
    img = get(int(mtrx), int(mtry), 500, 500);
    img.resize(width-30, width);
    image(img, 15, imgy);
    drawRectangle();
    save();
  } else if (i < 500){
    clickable = true;
    showToast("Cannot be saved at the moment.");
  }
  image_drawn = false;
}

void save() {
  try {
    String directory = new String(Environment.getExternalStorageDirectory().getAbsolutePath() + "/Mandelbrot_zoomer");
    File Mandelbrot_zoomer = new File(directory);
    if (!Mandelbrot_zoomer.exists()) {
      boolean success = true;
      success = Mandelbrot_zoomer.mkdirs();
    }
    plotfiles = listPaths(plotfilespath);
    img.save(directory+"/"+"Image "+(plotfiles.length +1)+"  Date  "+year()+"-"+month()+"-"+day()+" "+hour()+";"+minute()+ ".png");
    img = null;
    showToast("File saved  successfully.");
  } catch (Exception e) {
    println("Error while saving file: " + e);
  }
  item_choise = "1,4";
}

void select() {
  if(!listview_placed){
  plotfiles = listPaths(plotfilespath);
  plotfilesclean = listPaths(plotfilespath);
  for (int i = 0; i < plotfiles.length; i++) {
    String tempstr = plotfiles[i];
    tempstr = tempstr.substring(tempstr.lastIndexOf('/')+1);  // Leaves path before name out
    int firstindex =  tempstr.indexOf('.');
    plotfilesclean[i] = tempstr.substring(0, firstindex); // leaves files extension png out
  }   
  selectionlist = new SelectionList(this, plotfilesclean);
  item_choise = "1,4";
  } else {
    showToast("Not possible when list is open");
    }
}  

void onSelectionListSelection(SelectionList list) {
  selection = list.getSelection();  
  if (first_run) background(#F6BC47);
  first_run = false;
  for (int i = 0; i < plotfiles.length; i++) {  // loading image with trimmed selection name
    if (plotfiles[i].contains(selection)) {
      img = loadImage(plotfiles[i]);
    }
  }
  pushMatrix();
  fill(#F6BC47);
  noStroke();
  rect(0, imgy+width+5, width, 100); // to remove previous text
  fill(#8A0000);
  text(selection, width/2, imgy+width+50);
  popMatrix();
  image(img, 15, imgy);
  img = null;
  drawRectangle();
}

void drawRectangle() {
  pushMatrix();
  stroke(#8A0000);
  noFill();
  strokeWeight(6);
  rect(15, imgy, width-30, width); 
  popMatrix();
}

void showToast(final String message) { 
  act.runOnUiThread(new Runnable() { 
    public void run() { 
      android.widget.Toast.makeText(act.getApplicationContext(), message, android.widget.Toast.LENGTH_SHORT).show();
    }
  }
  );
} 

private static String[] PERMISSIONS_STORAGE = { Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE }; 
private void requestParticularPermission() { 
  act.requestPermissions(PERMISSIONS_STORAGE, 2020);
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
    act.onRequestPermissionsResult(requestCode, permissions, grantResults);
  }
}

public class SelectionList extends ListView {

  private PApplet parent;
  public ArrayAdapter<String> adapter;
  String name = "SelectionList";
  String selection = "";
  ListView myListview;
  RelativeLayout layout;
  private Method parentCallback;

  public SelectionList(PApplet _parent, String[] data) {
    super(_parent.getActivity().getApplicationContext());
    parent = _parent;
    adapter = new ArrayAdapter<String>(parent.getActivity(), android.R.layout.simple_list_item_1, data) {
      @Override
        public View getView(int position, View convertView, ViewGroup parent) {
        View view =super.getView(position, convertView, parent);
        TextView textView = (TextView) view.findViewById(android.R.id.text1);
        textView.setTextColor(Color.WHITE);
        //    textView.setTextSize(12); 
        return view;
      }
    };
    listview_placed = true;
    setBackgroundColor(#737474);
    setAlpha(25);
    myListview = this;
    layout = new RelativeLayout(parent.getActivity());
    setAdapter(adapter);

    parent.getActivity().runOnUiThread(new Runnable() {
      @SuppressWarnings("deprecation")
        public void run() {
        parent.getActivity().addContentView(myListview, new ViewGroup.LayoutParams( ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.FILL_PARENT));
        TextView lvbg = (TextView)act.findViewById(lvbgId);
        lvbg.setVisibility(View.VISIBLE);
        
        ViewGroup.MarginLayoutParams layoutParams = (ViewGroup.MarginLayoutParams) myListview.getLayoutParams();
        layoutParams.setMargins(width/6, height/6, width/6, height/6);
      }
    }
    );

    setOnItemClickListener(new OnItemClickListener() {
      public void onItemClick(AdapterView<?> p, View view, int position, long id) {
        selection = adapter.getItem(int(id)).toString();
        layout.removeAllViewsInLayout();
        try {
          parentCallback.invoke(parent, new Object[] { myListview });
        } 
        catch (Exception ex) {
        }
        myListview.setVisibility(View.GONE);
        ((ViewManager) myListview.getParent()).removeView(myListview);
        parent.getActivity().runOnUiThread(new Runnable() {
          public void run() {
            TextView lvbg = (TextView)act.findViewById(lvbgId);
            lvbg.setVisibility(View.GONE);
            layout.setVisibility(View.GONE);
            listview_placed = false;
          }
        }
        );
      }
    }
    );
    try {
      parentCallback = parent.getClass().getMethod("onSelectionListSelection", new Class[] { SelectionList.class });
    }
    catch (NoSuchMethodException e) {
    }
  }
  public String getSelection() {
    return selection;
  }
}

public void onStart() {
  act = this.getActivity();
  mC= act.getApplicationContext();
  // To prevent status bar showing up
  act.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);

  TextView menubar = new TextView(act);
  menubar.setLayoutParams(new RelativeLayout.LayoutParams(width-width/12, width/12));
  menubar.setTextSize(20);
  menubar.setX(0);
  menubar.setY(0);
  menubar.setGravity(Gravity.CENTER);
  menubar.setBackgroundColor(#8A0000);
  menubar.setTextColor(#F6BC47);
  menubar.setText("Mandelbrot Zoomer");
  menubarId=CompatUtils.getUniqueViewId();
  menubar.setId(menubarId);
  
  TextView lvbg = new TextView(act);
  lvbg.setLayoutParams(new RelativeLayout.LayoutParams((width-width/3)+12, (height-height/3)+12));
  lvbg.setX(width/6-6);
  lvbg.setY(height/6-6);
  lvbg.setGravity(Gravity.CENTER);
  lvbg.setBackgroundColor(#8A0000);
  lvbg.setVisibility(View.GONE);
  lvbgId=CompatUtils.getUniqueViewId();
  lvbg.setId(lvbgId);
  
  TextView menuanchor = new TextView(act);
  menuanchor.setLayoutParams(new RelativeLayout.LayoutParams(width/12, width/12));
  menuanchor.setTextSize(22);
  menuanchor.setTextColor(#F6BC47);
  menuanchor.setX(width-width/12);
  menuanchor.setY(0);
  menuanchor.setBackgroundColor(#8A0000);
  menuanchor.setGravity(Gravity.CENTER);
  menuanchor.setText("⋮");
  menuanchorId=CompatUtils.getUniqueViewId();
  menuanchor.setId(menuanchorId);
  menuanchor.setOnClickListener(new View.OnClickListener() {
    public void onClick(View view) {
      TextView menuanchor = (TextView) act.findViewById(menuanchorId);
      PopupMenu popupMenu = new PopupMenu(mC, menuanchor);
      popupMenu.getMenu().add(Menu.NONE, 1, 0, "Start");
      popupMenu.getMenu().add(Menu.NONE, 2, 1, "Resize");
      popupMenu.getMenu().add(Menu.NONE, 3, 2, "Save Image");
      popupMenu.getMenu().add(Menu.NONE, 4, 3, "Open Images");
      popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
        public boolean onMenuItemClick(MenuItem item) {
          switch (item.getItemId()) {
          case 1:
            if (!listview_placed) {
              item_choise = "2,3,4";
              restart = true;
              clickable = true;
              image_drawn = false;
              restart();
            } else {
              showToast("Not possible when list is open");
            }
            return true;
          case 2: 
            if (image_drawn) { 
              clickable = false;
              resizeImage();
            } else { 
              showToast("Cannot be resized at the moment.");
            }   
            return true;
          case 3: 
            clickable = false;
            saveImage();
            return true;
          case 4:
            clickable = false;
            select();
            return true;
          default:
            return false;
          }
        }
      }
      );
      if (item_choise == "1,4") {
        popupMenu.getMenu().findItem(1).setVisible(true);
        popupMenu.getMenu().findItem(2).setVisible(false);
        popupMenu.getMenu().findItem(3).setVisible(false);
        popupMenu.getMenu().findItem(4).setVisible(true);
      }  
      if (item_choise == "2,3,4") {
        popupMenu.getMenu().findItem(1).setVisible(false);
        popupMenu.getMenu().findItem(2).setVisible(true);
        popupMenu.getMenu().findItem(3).setVisible(true);
        popupMenu.getMenu().findItem(4).setVisible(true);
      }  
      if (item_choise == "1,3,4") {
        popupMenu.getMenu().findItem(1).setVisible(true);
        popupMenu.getMenu().findItem(2).setVisible(false);
        popupMenu.getMenu().findItem(3).setVisible(true);
        popupMenu.getMenu().findItem(4).setVisible(true);
      }  
      if (item_choise == "1,2,4") {
        popupMenu.getMenu().findItem(1).setVisible(true);
        popupMenu.getMenu().findItem(2).setVisible(true);
        popupMenu.getMenu().findItem(3).setVisible(false);
        popupMenu.getMenu().findItem(4).setVisible(true);
      }  
      popupMenu.show();
    }
  }
  );

  fl = (FrameLayout)act.findViewById(R.id.content);
  FrameLayout.LayoutParams params1 = new FrameLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT, Gravity.CENTER);
  fl.addView(menubar);
  fl.addView(menuanchor);
  fl.addView(lvbg);
}
