
import processing.serial.*;

Serial myPort;        // The serial port

//Image
int yPos = 1;         
PImage myImage1;
PImage myImage2; 
PImage myImage3;
PImage currentImage;
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
  myPort = new Serial(this, Serial.list()[2], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  myImage1 = loadImage( "Barn.jpg" ); //load image data
  myImage2 = loadImage ("Farm.jpg");
  myImage3 = loadImage ("Landscape.jpg");

  currentImage = myImage1;
}
void draw () {
  //Arduino happens in the serialEvent()

  ellipse( penX, 0, 30, 30 );
  image(currentImage, -penX, 0); 

  //int imageWidth = myImage1.width;

  //for (int x = 1; x < 5; x++) {

  //  image(buttonPressed? myImage1: myImage2, -penX, 0); // make an image and load it to the screen
  //  image(buttonPressed? myImage1: myImage2, -penX + (x*imageWidth), 0); //ellipse controlled panorama
  //  image(buttonPressed? myImage1: myImage2, -penX - (x*imageWidth), 0);


  //}
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
      if ( label.equals( "button1" ) ) {
        if ( value.equals( "1" ) ) {// if button was pressed
          changeImage1();
        }
      }

      if ( label.equals( "button2" ) ) {
        if ( value.equals( "1" ) ) {// if button was pressed
          changeImage2();
        }
      }

      if ( label.equals( "button3" ) ) {
        if ( value.equals( "1" ) ) {// if button was pressed
          changeImage3();
        }
      }

      if ( label.equals( "x") ) {
        int v = int(value);
        penX = map( v, 0, 1023, 0, width);
      }
    }
  }
}


void changeImage1() {

  currentImage = myImage1;
  image(myImage1, -penX, 0); 
  buttonPressed = true;
}

void changeImage2() {

  currentImage = myImage2;
  image(myImage2, -penX, 0); 
  buttonPressed = true;
}


void changeImage3() {

  currentImage = myImage3;
  image(myImage3, -penX, 0); 
  buttonPressed = true;
}