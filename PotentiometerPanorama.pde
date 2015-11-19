
import processing.serial.*;

Serial myPort;        // The serial port
int yPos = 1;         // position of Image


//Image
PImage myImage;
int pointX = 0;
int x;

//Potentiometer controlled mouse
float penX;
color penColor = color( 60, 120, 20 ); // color of our pen

void setup () {
  size(1000, 1000);
  fill( penColor ); // set pen color

    penX = width/2; // starting x position of pen

  // List all the available serial ports
  println(Serial.list());

  //Check the port!!! 
  myPort = new Serial(this, Serial.list()[2], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:

  myImage = loadImage( "optimized.jpg" ); //load image data
}
void draw () {
  //Arduino happens in the serialEvent()
  //Panorama controlled by mouse

  ellipse( penX, 0, 30, 30 );

  int imageWidth = myImage.width;
//
//  if (penX > 525) {
//    pointX = pointX + ((mouseX-375)/50);
//  }
//
//  if (penX < 475) {
//    pointX = ((mouseX-425)/50) + pointX;
//  }

  for (int x = 1; x < 5; x++) {
    image(myImage, -penX, 0); // make an image and load it to the screen
    image(myImage, -penX - (x*imageWidth), 0); //ellipse controlled panorama
    image(myImage, -penX + (x*imageWidth), 0);
  }
  
    ellipse( penX, mouseY, 30, 30 );
}

//void serialEvent (Serial myPort)
void serialEvent (Serial p) {

  // get the ASCII string:
  //  String inString = myPort.readStringUntil('\n');
  String inString = p.readString();
  inString = trim( inString );  // remove any whitespace
  println(inString);


  int v = int(inString); // convert from a string to int
  penX = map( v, 0, 1023, 0, width); // map to window size

  // // convert to an int and map to the screen width:
 

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

