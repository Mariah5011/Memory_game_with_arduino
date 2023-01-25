//-------------- importowanie bibliotek ----------------
import processing.serial.*;

//-------------- zmienne globalne ----------------
//x,y - współrzędne kart w tablicy
//awers - lista jaki obrazek jest w każdym miescu planszy
//  np. [1 2 3
//       1 2 3]
//cardUp - lista dwuelementowa lokalizacji kart, które sa obrócone względem lokalizacji na planszy 
//      [0 1 2
//       3 4 5]
//clicked - lista zawierająca informacje o obróceniu kart' potrzeba do tego, żeby nie poswolić na zebranie pary przez klinięcie dwa zary tego samego obrazka
//      [false true false
//      false false true]

int liczbaKart = 6;

int[] x = new int[liczbaKart];
int[] y = new int[liczbaKart];
int[] awers = new int[liczbaKart];
int[] cardUp = new int[2]; 
boolean[] clicked = new boolean[liczbaKart]; 
int flipped = 0; // określa, ile kart jest już obróconych 
int win = 0; //określa ile par już zebrano
int tableWidth = 300;
int tableHeight = 300;

Cards[] myCard = new Cards[liczbaKart];
Serial myPort;

//PImage tlo; 
//Confetti[] conf = new Confetti[100]; - zdefiniowanie tablicy z nowymi obiektami confetti

int inBuffer; //zawiera informacje z Arduino
// uzaleznic odsłanianie kart od inBuffer, ktory przyjmuje wartosci guzikow tak :
// 1  2  3
// 4  5  6

//-------------- setup() ----------------  
void setup() {
  /* tło z corgisiem
  tlo = loadImage("corgi_tlo.jpg");
  tlo.resize(1500,900);
  */
  
  myPort = new Serial(this, "COM6",9600);
  
  frameRate(30);
  size(1500,900);

  RysowanieKart();
 // myFont = createFont("data/vanilla_caramel.otf", 30) - nowa czcionka
 /* stworzenie nowego obiektu confetti 
  for (int i = 0; i< conf.length; i++){
  conf[i] = new Confetti();
  */
}

//-------------- draw() ----------------
void draw() {
//background(tlo); - tło musi być w draw, żeby confetti działało:(
  //czytaie informacji z Arduino
  while (myPort.available() > 0) {
    inBuffer = myPort.read();
  }  
  
  //ładowanie kart na planszy
  for (int i =0; i < liczbaKart; i ++) {
    myCard[i].display();
  }
    ObrocKarte(); 
    SprawdzaniePar();
}
 
//-------------- RysowanieKart() ---------------- 
//funkcja tworząca tabelę kart i rysująca ją
void RysowanieKart(){
  int odstep = 25;
  int myX = (width - 3*tableWidth- odstep)/2;
  int myY = height/45;

  Tasowanie(); //tworzy awers[] z lista odpowienich par w tabeli
  // tworzenie tabeli kart i ustawianie clicked na false   
  for (int i = 0; i < liczbaKart; i++){
    clicked[i] = false; // jeżeli karta kliknięta to nie można jej kliknąć drugi raz, żeby nie była traktowana jako para
    x[i] = myX;
    y[i] = myY;
   
    if (myX < 2.5 * tableWidth){ //rysowanie pierwszego rzedzu tabeli
      myX += tableWidth+odstep;
    }
    else if (myX > 2.5 * tableWidth){ //rysowanie drugiego rzedu tabeli
      myX = (width - 3*tableWidth- odstep)/2;
      myY += tableHeight + odstep;
    }
   //rysowanie karty w odpowiednim miejscach 
   myCard[i] = new Cards(x[i], y[i],awers[i]); 
   println(awers[i]);
  }
}

//-------------- ObrocKarte() ---------------- 
//1) sprawdza położenie myszki i gdy ta została kliknięta w obszarze karty to rysuje jej awers
//2) sprawdza kliknięcie guzika z Arduino i gdy ten został kliknięty to rysuje awers karty
void ObrocKarte() {
  //1) obracanie Kart myszką
    for (int i = 0; i < liczbaKart; i ++){
      if( mousePressed && mouseX > x[i] && mouseX<(x[i] + myCard[0].cardWidth) &&
      mouseY > y[i] && mouseY < (y[i] + myCard[0].cardHeight) && (clicked[i] == false) ){
        myCard[i].displayAwers();
        clicked[i] = true;     
        cardUp[flipped] =  i; //cardUp[0] i cardUp[1] - uzupełnianie listy cardUp lokalizacją dwóch odwróconych kart    
        flipped ++;
      }
    }

  //2) obracanie kart przyciskami Arduino
  //inBuffer:   1 2 3      karty:  0 1 2
  //            4 5 6              3 4 5
  int j=0;
  if (inBuffer <10){ //zabezpieczenie przed presyłaniem z Arduino innych liczb niż 0-6
    if((inBuffer) != 0 && (clicked[inBuffer-1] == false) ){
      j = int(inBuffer) - 1;
      //println("flipped:",flipped);
      myCard[j].displayAwers();
      clicked[j] = true;
      //println("j",j);
      cardUp[flipped] = j ; //cardUp[0] i cardUp[1]
      //print("cardUp",cardUp[0], cardUp[1]);

      flipped ++;
      inBuffer = 0;
    }
  }
}

//-------------- SprawdzaniePar() ---------------- 
//funkcja sprawdza, czy dwie odsłonięte karty są parą
void SprawdzaniePar() {
  if (frameCount%4 == 0){ //co 4 klatkę sprawdza czy jest para (dzieki temu pokazują się zawsze dwie karty)
     if (flipped == 2) {  
        println("0: ", awers[cardUp[0]]);
        println("1: ", awers[cardUp[1]]);
        
        if (awers[cardUp[0]] == awers[cardUp[1]]){ //para
          myCard[cardUp[0]].Para();
          myCard[cardUp[1]].Para();
          win +=1;
          
          //wysyłanie informacji do Arduino o parze
          myPort.write(2);
          delay(1000);
          myPort. write(0);
        }
 
        else if(awers[cardUp[0]] != awers[cardUp[1]]){ //nie ma pary
            ResetKarty(cardUp[0]);
            ResetKarty(cardUp[1]);
            
            //wysyłanie informacji do Arduino o braku pary
            myPort.write(1);
            delay(1000);
            myPort.write(0);
        }
     flipped = 0;
     }

     if (win == 3){ //wygrana
       Wygrana();
       /* Jeśli wygrałeś, to włącza się confetti
       for (int i =0; i < conf.length; i++){
          conf[i].fall();
          conf[i].show();
       }*/
       
       //wysyłanie informacji do Arduino o wygranej
       myPort.write(3);
       delay(1000);
       myPort.write(0);
     }
  }
}

//-------------- Tasowanie() ---------------- 
//ustalenie nowych indeksów kart w awersie
void Tasowanie() {
//tworzenie listy par do tasowania [1 2 3 1 2 3]
  IntList numberList;
  numberList = new IntList();
   for (int i=0; i<2; i++){
    for (int j=0; j<(liczbaKart)/2; j++){
      numberList.append(j+1);
    }
  }
  //tasowanie listy
  numberList.shuffle();
  
  //przypisywanie nowej kolejności indeksów w awers, które odnoszą się do ułozenia par na planszy
  for (int w = 0; w <liczbaKart; w ++){
    awers[w] = numberList.get(w);
  }
}

//-------------- ResetKarty() ---------------- 
//int i - lokalizacja karty do obrócenia rewersem
void ResetKarty(int i){
    myCard[i].ObrocKarte();
    clicked[i] = false;
    flipped = 0; 
}

//-------------- Wygrana() ---------------- 
void Wygrana() {
  fill(255);
  textSize(40);
  text("Wygrałeś!", 3*width/7,4*height/5);
}
/* Tekst wygranej dostosowany do nowej czcionki
void tekstWygranej() {
  textFont(myFont);
  fill(#FA910F);
  textSize(80);
  text("YOU WIN!", 3*width/7,4*height/5);

}*/
