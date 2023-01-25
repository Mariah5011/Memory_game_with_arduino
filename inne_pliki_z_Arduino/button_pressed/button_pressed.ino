const int ledPin = 13;    //define the LED pin
const int buttonPin = 2;     // the number of the pushbutton pin
int buttonState = 0;         // variable for reading the pushbutton status
int lastButtonState;
int ledState = LOW;  

void setup(){

  pinMode(ledPin, OUTPUT);    //initialize LED output
  pinMode(buttonPin, INPUT);
  Serial.begin(9600);         //start the serial communication
  buttonState = digitalRead(buttonPin);
}

void loop(){
  // zapal diode po pierwszym kliknięciu, po drugim kliknięciu zgaś
  lastButtonState    = buttonState;
  buttonState = digitalRead(buttonPin);
  
  if(lastButtonState == HIGH && buttonState == LOW) {
    // toggle state of LED
    ledState = !ledState;

    // control LED arccoding to the toggled state
    digitalWrite(ledPin, ledState); 
  }

  Serial.println(buttonState);

  if(Serial.available() > 0){           //if some data is available of in the serial port
    char ledPinState = Serial.read();   //read the value
    if(ledPinState == '1'){             //if statement will be true(1)
      digitalWrite(ledPin, HIGH);       //turn ON the LED
      delay(5);
      digitalWrite(ledPin, LOW); 
    }
    if(ledPinState == '0'){             //if statement will be false(0)
      digitalWrite(ledPin, LOW);        //turn OFF the LED
    }
  }
}

