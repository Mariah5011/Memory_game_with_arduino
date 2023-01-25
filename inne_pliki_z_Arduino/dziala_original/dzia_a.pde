import processing.serial.*;

Serial myPort;  // Create object from Serial class

void setup() 
{
  size(200,200); //make our canvas 200 x 200 pixels big
  String portName = "COM5"; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

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
    String inBuffer = myPort.readString();
    println(inBuffer);
  }
  //delay(100);

}
