#define BUTTON_PIN1 2
#define BUTTON_PIN2 3
#define BUTTON_PIN3 4
#define BUTTON_PIN4 5
#define BUTTON_PIN5 6
#define BUTTON_PIN6 7
#define RED_LED_PIN 10
#define GREEN_LED_PIN 9
#define YELLOW_LED_PIN 8
#define BUZZER_PIN 13

void setup()
{
  Serial.begin(9600);
  pinMode(BUTTON_PIN1, INPUT);
  pinMode(BUTTON_PIN2, INPUT);
  pinMode(BUTTON_PIN3, INPUT);
  pinMode(BUTTON_PIN4, INPUT);
  pinMode(BUTTON_PIN5, INPUT);
  pinMode(BUTTON_PIN6, INPUT);
  pinMode(RED_LED_PIN, OUTPUT);
  pinMode(GREEN_LED_PIN, OUTPUT);
  pinMode(YELLOW_LED_PIN, OUTPUT);
}


void loop()
{
  buttonState();
  ledBlink();
} 


void ledBlink(){
  if(ledState() == 'r'){
    digitalWrite(RED_LED_PIN, HIGH);
    delay(100);
    digitalWrite(RED_LED_PIN, LOW); 
  }

  if(ledState() == 'g'){
    digitalWrite(GREEN_LED_PIN, HIGH); 
    delay(100);
    digitalWrite(GREEN_LED_PIN, LOW);
  }

  if(ledState() == 'w'){ 
      digitalWrite(YELLOW_LED_PIN, HIGH); 
      delay(50);
      digitalWrite(YELLOW_LED_PIN, LOW);
      delay(50);
      digitalWrite(GREEN_LED_PIN, HIGH); 
      delay(50);
      digitalWrite(GREEN_LED_PIN, LOW);
      delay(50);
      digitalWrite(RED_LED_PIN, HIGH); 
      delay(50);
      digitalWrite(RED_LED_PIN, LOW);
      delay(50);
  }
}

char ledState(){
  char input;
  if (Serial.available()) input = Serial.read();
  return input;
}

void buttonState(){
  byte buttonState1 = digitalRead(BUTTON_PIN1);
  byte buttonState2 = digitalRead(BUTTON_PIN2);
  byte buttonState3 = digitalRead(BUTTON_PIN3);
  byte buttonState4 = digitalRead(BUTTON_PIN4);
  byte buttonState5 = digitalRead(BUTTON_PIN5);
  byte buttonState6 = digitalRead(BUTTON_PIN6);
  
  if(buttonState1) Serial.println(1);
  if(buttonState2) Serial.println(2);  
  if(buttonState3) Serial.println(3);
  if(buttonState4) Serial.println(4);
  if(buttonState5) Serial.println(5);
  if(buttonState6) Serial.println(6);

  delay(100);

  return 0;
}
  
