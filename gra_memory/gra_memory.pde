//https://www.youtube.com/watch?v=EkTOTw_lpVg - zródło inspiracji


int liczbaKart = 6;
Cards[] myCard = new Cards[liczbaKart+1];
int[] x = new int[liczbaKart+1];
int[] y = new int[liczbaKart+1];
int[] fv = new int[liczbaKart+1]; // określa jaki obrazek się pokaże (z listy 1,2,3,1,2,3); 0 to obraz przykrytej karty

int[] cardUp = new int[2]; //karty, które sa obrócone - odniesione do lokalizacji na planszy
boolean[] clicked = new boolean[liczbaKart];

PFont myFont;
int flipped = 0; // określa, czy karta jest obrócona, czy nie
int win = 0; //określa ile par już zebrano
int count = 1; // potrzebne do liczenia fv

// niestety musiałam zrobić drugie względem klasy, bo za późno tworze obiekty ://
int cardWidth = 300;
int cardHeight = 300;
  
void setup() {
  frameRate(10);
  size(1500,900);

  RysowanieKart();
  myFont = createFont("Verdana",40,true);

}

void draw() {
  for (int i =0; i < liczbaKart; i ++) {
    myCard[i].display();
  }
    obrocKarte(); //funkcja, która obraca karty i patrzy czy są falami

}


void RysowanieKart(){
  int odstep = 25;
  int myX = (width - 3*cardWidth- odstep)/2;
  int myY = height/45;
  int myFv = 0; //rysowanie zewnętrzej strony karty

  // tworzenie mapy do wrysowania kart i ustawianie clicked na false   
  for (int i = 0; i < liczbaKart; i++){
    clicked[i] = false; // jeżeli karta kliknięta to nie można jej kliknąć drugi raz, żeby nie była traktowana jako para
    x[i] = myX;
    y[i] = myY;
    fv[i] = count; //nadawanie indeksów 1-3 dla kart, żeby można było szukać par
    print(count);
    count += 1;
    
    if (count == 4){
      count = 1;
    }
    
    if (myX < 2.5 * cardWidth){
      myX += cardWidth+odstep;
    }
    else if (myX > 2.5 * cardWidth){
      myX = (width - 3*cardWidth- odstep)/2;
      myY += cardHeight + odstep;
    }
  }
   tasowanie();
   
   // rysowanie kart 
   for (int i = 0; i < liczbaKart; i++){
     myCard[i] = new Cards(x[i], y[i],fv[i]); 
     println(fv[i]);
  }
}

// sprawdza położenie myszki i gdy ta została kliknięta w obszarze karty to rysuje jej środek
void obrocKarte() {
  if (mousePressed){
    for (int i = 0; i < liczbaKart+1; i ++){
      if(mouseX > x[i] && mouseX<(x[i] + myCard[0].cardWidth) &&
      mouseY > y[i] && mouseY < (y[i] + myCard[0].cardHeight) && 
      (clicked[i] == false)){
        myCard[i].displayFront();
        clicked[i] = true;
        cardUp[flipped] =  i;
        
        flipped ++;

     if (flipped == 2) {
        println("0: ", fv[cardUp[0]]);
        println("1: ", fv[cardUp[1]]);
        
      //sprawdzanie, czy to te same karty
      if (fv[cardUp[0]] == fv[cardUp[1]]){
        myCard[cardUp[0]].matched();
        myCard[cardUp[1]].matched();
        win +=1;
      } 
      
      //UWAGA! tu jest problem, bo nie pokazują się dobrze karty, jak nie ma pary ;//
      else if(fv[cardUp[0]] != fv[cardUp[1]]){
        print("nie ma pary");
        resetPlanszy(cardUp[0]);
        //myCard[cardUp[1]].displayFront();

        resetPlanszy(cardUp[1]);
      }
        flipped = 0;
          
       if (win == 3){
         tekstWygranej();
       }
       }
      }
    }
  }
}

//zmienianie indeksów kart
void tasowanie() {
//tworzenie listy par do tasowania
  IntList numberList;
  int a = liczbaKart;
  numberList = new IntList();
   for (int j=0; j<2; j++){
    for (int i=0; i<a/2; i++){
      numberList.append(i+1);
    }
  }
  //tasowanie listy
  numberList.shuffle();
  println(numberList);
  
  //przypisywanie nowej kolejności indeksów 
  int temp = 0;
  int rand = 0;
  for (int w = 0; w <liczbaKart; w ++){
    rand = numberList.get(w);
    temp = fv[w];
    fv[w] = fv[rand];
    fv[rand] = temp;
  }
}

void resetPlanszy( int i){
    myCard[i].faceDown();
    clicked[i] = false;
    flipped = 0; 
}
void tekstWygranej() {
  textFont(myFont);
  fill(255);
  textSize(40);
  text("Wygrałeś!", 3*width/7,4*height/5);

}
