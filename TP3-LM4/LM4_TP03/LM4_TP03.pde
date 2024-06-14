/* COMUNICACION SERIAL */
import processing.serial.*;
Serial myPort;
String val;

import processing.sound.*;
import processing.core.*;
import java.util.ArrayList;

AudioIn input;
Amplitude analyzer;

ArrayList<ImageInfo> images = new ArrayList<ImageInfo>();
PImage[] imgArray;
int imgDuration = 60;

// --
float timer = 0;
float timerConstante = 0;

void setup() {
  size(400, 400);
  background(0);

  imgArray = new PImage[2];
  imgArray[0] = loadImage("1.png");
  imgArray[1] = loadImage("2.png");

  input = new AudioIn(this, 0);
  input.start();

  analyzer = new Amplitude(this);
  analyzer.input(input);

  // --- PUERTO SERIAL
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);

  if ( soplidoFuerte() ) {
    timer++;
    if ( timer <= 6 ) {
      myPort.write( 1 );
    } else {
      myPort.write( 0 );
    }
  } else if ( soplidoConstante() ) {

    timerConstante++;

    if ( timerConstante <= 80 ) {
      myPort.write( 2 );
    } else {
      myPort.write( 0 );
    }
  } else if ( !soplidoFuerte() && !soplidoConstante()) {
    timerConstante = 0;
    timer = 0;
  }


  float vol = analyzer.analyze();

  if (vol > 0.1 || !images.isEmpty()) {
    if (vol > 0.1 && images.size() < 10) {
      ImageInfo newImage = new ImageInfo(random(width), random(height), int(random(imgArray.length)));
      images.add(newImage);
    }

    for (int i = images.size() - 1; i >= 0; i--) {
      ImageInfo imgInfo = images.get(i);
      PImage img = imgArray[imgInfo.imgIndex];

      image(img, imgInfo.x, imgInfo.y, imgInfo.size, imgInfo.size);

      imgInfo.size += imgInfo.direction * 2;
      if (imgInfo.size >= 70 || imgInfo.size <= 30) {
        imgInfo.direction *= -1;
      }

      imgInfo.timer++;
      if (imgInfo.timer >= imgDuration) {
        images.remove(i);
      }
    }
  }

  int centerX = width / 2;
  int centerY = 395;
  int diameter = (int)(50 + vol * 200);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float distance = dist(x, y, centerX, centerY);
      float transparency = map(distance, 0, diameter / 2, 255, 0);
      transparency = constrain(transparency, 0, 255);
      fill(255, 127, 0, transparency);
      noStroke();
      ellipse(x, y, 1, 1);
    }
  }

  println( timerConstante );
}

void stop() {
  input.stop();
  super.stop();
}

void keyPressed() { /*
  if ( key == 'k' || key == 'K' ) {
 myPort.write( 1 );
 } else if ( key == 'a' || key == 'A' ) {
 myPort.write( 0 );
 } */
}

boolean soplidoFuerte() {
  if ( keyPressed ) {
    if ( key == 'k' || key == 'K' ) {
      return true;
    }
  }

  return false;
}

boolean soplidoConstante() {
  if ( keyPressed ) {
    if ( key == 'a' || key == 'A' ) {
      return true;
    }
  }
  return false;
}
