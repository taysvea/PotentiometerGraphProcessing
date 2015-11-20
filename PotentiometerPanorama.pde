
import processing.serial.*;

Serial myPort;        // The serial port

//Image
int yPos = 1;         
PImage myImage1;
PImage myImage2;
int pointX = 0;
int x;



//ellipse
float penX;
color penColor = color( 60, 120, 20 ); // color of our pen

//change image
boolean buttonPressed;

 
void setup () {
  size(1400, 800);
  fill( penColor ); // set pen color

    penX = width/2; // starting x position of pen

  // List all the available serial ports
  println( Serial.list() );

  //Check the port!!! 
  myPort = new Serial(this, Serial.list()[0], 9600);


  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  myImage1 = loadImage( "Barn.jpg" ); //load image data
  myImage2 = loadImage ("Farm.jpg");
//  myImage3 = loadImage ("Landscape.jpg");
//  myImage4 = loadImage ("Sunset.jpg");

}
void draw () {
  //Arduino happens in the serialEvent()
  //Panorama controlled by mouse

  ellipse( penX, 0, 30, 30 );

  int imageWidth = myImage1.width;

  for (int x = 1; x < 5; x++) {
    image(buttonPressed? myImage1: myImage2, -penX, 0); // make an image and load it to the screen
    image(buttonPressed? myImage1: myImage2, -penX + (x*imageWidth), 0); //ellipse controlled panorama
    image(buttonPressed? myImage1: myImage2, -penX - (x*imageWidth), 0);
  }


  
  
 

  ellipse( penX, mouseY, 30, 30 );
}


void serialEvent (Serial p) {

  // get the ASCII string:

  String inString = p.readString();

  //  println(inString);
  String pairs[] = split( inString, ';' ); // split up string into pairs

  // go through each pair of label and value
  // and assign it to its variable

  for ( int i=0; i<pairs.length; i++) {
    String data[] = split( pairs[i], ':' );

    if ( data.length == 2 ) { // continue only if there are 2 things
      String label = trim( data[0] ); // remove extra whitespace
      String value = trim( data[1] ); // remove extra whitespace
     
print(label);
print(value);
      if ( label.equals( "number of button pushes" ) ) {
        if ( value.equals( "1" ) ) {// if button was pressed
          changeImage1();
        }
      }
      
//          if ( label.equals( "number of button pushes" ) ) {
//        if ( value.equals( "3" ) ) {// if button was pressed
//          changeImage2();
//        }
//      }


      if ( label.equals( "x") ) {
        int v = int(value);
        penX = map( v, 0, 1023, 0, width);
      }
    }
  }
}

  void changeImage1() {
  
    int imageWidth = myImage2.width;

  for (int x = 1; x < 5; x++) {
    image(myImage1, -penX, 0); // make an image and load it to the screen
    image(myImage1, -penX + (x*imageWidth), 0); //ellipse controlled panorama
    image(myImage1, -penX - (x*imageWidth), 0);
  }
    buttonPressed = true;
  }
  
//    void changeImage2() {
//  
//    int imageWidth = myImage3.width;
//
//  for (int x = 1; x < 5; x++) {
//    image(myImage3, -penX, 0); // make an image and load it to the screen
//    image(myImage3, -penX + (x*imageWidth), 0); //ellipse controlled panorama
//    image(myImage3, -penX - (x*imageWidth), 0);
//  }
//    buttonPressed = true;
//  }
//  
