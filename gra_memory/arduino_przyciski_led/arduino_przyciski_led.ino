#define BUTTON_PIN1 2
#define BUTTON_PIN2 3
#define BUTTON_PIN3 4
#define BUTTON_PIN4 5
#define BUTTON_PIN5 6
#define BUTTON_PIN6 7
#define RED_LED_PIN 10
#define GREEN_LED_PIN 9
#define YELLOW_LED_PIN 8

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

//włączanie LED zależne od aktualnej informacji przesłanej z Procesisng:
//1 - czerwony LED
//2 - zielony LED
//3 - wszystkie kolory naprzemiennie
void ledBlink(){

  switch(ledState()){
        case 1:
          digitalWrite(RED_LED_PIN, HIGH);
          delay(100);
          digitalWrite(RED_LED_PIN, LOW); 
          return;
        case 2:
          digitalWrite(GREEN_LED_PIN, HIGH); 
          delay(100);
          digitalWrite(GREEN_LED_PIN, LOW);
          return;
        case 3:
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
          return; 

  }
}
 // }
  // if(ledState() == 'r'){
  //   digitalWrite(RED_LED_PIN, HIGH);
  //   delay(100);
  //   digitalWrite(RED_LED_PIN, LOW); 
  //  }

  // if(ledState() == 'g'){
  //   digitalWrite(GREEN_LED_PIN, HIGH); 
  //   delay(100);
  //   digitalWrite(GREEN_LED_PIN, LOW);
  // }

  // else if(ledState() == 'y'){ 
  //   digitalWrite(YELLOW_LED_PIN, HIGH); 
  //   delay(100);
  //   digitalWrite(YELLOW_LED_PIN, LOW);
  // } 

int ledState(){
  int input;
  if (Serial.available()) 
    input = Serial.read();
    return input;
}

//informacja o klikniętym przycisku jest wysyłana do Processingu; wysyłane komentarze odpowiednio do ułożenia przycisku:
// 1 2 3
// 4 5 6 
void buttonState(){
  byte buttonState1 = digitalRead(BUTTON_PIN1);
  byte buttonState2 = digitalRead(BUTTON_PIN2);
  byte buttonState3 = digitalRead(BUTTON_PIN3);
  byte buttonState4 = digitalRead(BUTTON_PIN4);
  byte buttonState5 = digitalRead(BUTTON_PIN5);
  byte buttonState6 = digitalRead(BUTTON_PIN6);
  
  if(buttonState1) Serial.write(1);
  if(buttonState2) Serial.write(2);    
  if(buttonState3) Serial.write(3);
  if(buttonState4) Serial.write(4);
  if(buttonState5) Serial.write(5);
  if(buttonState6) Serial.write(6);

//   if(buttonState1) Serial.println("1");
//  if(buttonState2) Serial.println("2");    
//  if(buttonState3) Serial.println("3");
//  if(buttonState4) Serial.println("4");
//  if(buttonState5) Serial.println("5");
//  if(buttonState6) Serial.println("6");

  delay(100);
  return;
}
  
