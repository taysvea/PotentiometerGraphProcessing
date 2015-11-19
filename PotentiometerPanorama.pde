
import processing.serial.*;

Serial myPort;        // The serial port
int yPos = 1;         // position of line

//Image
PImage myImage;
int pointX = 0;
int x;

void setup () {
  size(1000, 1000);

  // List all the available serial ports
  println(Serial.list());

  //Check the port!!! 
  myPort = new Serial(this, Serial.list()[2], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  background(0);
  myImage = loadImage( "optimized.jpg" ); //load image data
}
void draw () {
  //Arduino happens in the serialEvent()
  //Panorama controlled by mouse

  int imageWidth = myImage.width;
  if (mouseX > 525) {
    pointX = pointX + ((mouseX-375)/50);
  }

  if (mouseX < 475) {
    pointX = ((mouseX-425)/50) + pointX;
  }
  for (int x = 1; x < 5; x++) {
    image(myImage, -pointX, 0); // make an image and load it to the screen
    image(myImage, -pointX - (x*imageWidth), 0);
    image(myImage, -pointX + (x*imageWidth), 0);
  }
}

void serialEvent (Serial myPort) {

  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
//  String temp = new String(inString);
  //  float inByte = float(inString);
  //  int temp = Integer.parseInt(inString.toString());
  println(inString);
//  println(temp);
  //  println(temp);
  //// if (inString != null) {
  // // trim off any whitespace:

  // // convert to an int and map to the screen width:
  // float inByte = float(inString);
  // inByte = map(inByte, 0, 1023, 0, width);
  //
  //// int imageWidth = myImage.width;
  //// draw the line:;
  //stroke(0);
  //line(width, yPos, width - inByte, yPos);
}


// at the edge of the screen, go back to the beginning:
// if (yPos >= width) {
//   yPos = 0;
// } else {
// // increment the position:
//   yPos++;
// }  
// } 
// }

