import processing.serial.*;

Serial myPort;  // Create object from Serial class

void setup() 
{
  size(500,500); //make our canvas 200 x 200 pixels big
  background(250);
  String portName = "COM6"; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}
String inBuffer;
void draw() {
  if (mousePressed == true) 
  {                           //if we clicked in the window
   myPort.write('w');         //send a 1
   println("r");   
  } else 
  {                           //otherwise
  myPort.write('g');  //send a 0
  //println("g");
  }   
  
   while (myPort.available() > 0) {
    inBuffer = myPort.readString();
    println(inBuffer);
  }
  
  if ("1".equals(inBuffer))  {
    fill(0);
    rect(0,0,40,40);
  //delay(100);
  }
}
