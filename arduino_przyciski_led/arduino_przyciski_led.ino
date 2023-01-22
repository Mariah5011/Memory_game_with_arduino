#define BUTTON_PIN1 2
#define BUTTON_PIN2 3
#define BUTTON_PIN3 4

char val; // Data received from the serial port
int ledPin = 13;

boolean ledState = LOW;

void setup()
{
  Serial.begin(9600);
  pinMode(BUTTON_PIN1, INPUT_PULLUP);
  pinMode(BUTTON_PIN2, OUTPUT);
  pinMode(BUTTON_PIN3, OUTPUT);
  pinMode(ledPin, OUTPUT);
}
void loop()
{
  byte buttonState1 = digitalRead(BUTTON_PIN1);
  byte buttonState2 = digitalRead(BUTTON_PIN2);
  byte buttonState3 = digitalRead(BUTTON_PIN3);
  
  if (buttonState1 == HIGH) {
      Serial.println("1");
  }
    
  if (buttonState2 == HIGH) {
      Serial.println("Button 2");
  }
    
  if (buttonState3 == HIGH) {
      Serial.println("Button 3");
  }
 
  delay(100);

  
  //----------światełka--------
  if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }
//   if (val == '1') 
//   { // If 1 was received
//     digitalWrite(ledPin, HIGH); // turn the LED on
// }  
//    delay(10); // Wait 10 milliseconds for next reading
//    digitalWrite(ledPin, LOW); // otherwise turn it off
if(val == '1') //if we get a 1
    {
       ledState = !ledState; //flip the ledState
       digitalWrite(ledPin, ledState); 
    }
    delay(10);
  } 
  
