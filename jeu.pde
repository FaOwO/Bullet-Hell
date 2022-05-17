import processing.serial.*;


int largeur = 640;
int hauteur = 960;

String val;
String [] dataTrie;

int redperso = largeur/2;
int bluepersoX = largeur/2;
int bluepersoY = hauteur/2;

PImage tank;
PImage vaisseau;

Serial port;
int lf = 10;

Boolean leftred = false;
Boolean rightred = false;

Boolean leftblue = false;
Boolean rightblue = false;
Boolean upblue = false;
Boolean downblue = false;

int vitesse = 5;

void setup()
{
  size(640,960);
  tank = loadImage("RedPlayer.png");
  vaisseau = loadImage("BluePlayer.png");
   
  String nomDuPort = Serial.list()[0];
  port = new Serial(this, nomDuPort, 9600);
  port.bufferUntil(lf);
}

void draw()
{
  background(3,34,76);
  
  
  if (leftred){
    if (redperso >= 0) redperso -= vitesse;
  }
  
  if (rightred){
    if (redperso <= largeur - 38) redperso += vitesse;
  }
  
  image(tank,redperso,930);
  
  
  
  if (leftblue){
    if (bluepersoX >= 0) bluepersoX -= vitesse;
  }
  
  if (rightblue){
    if (bluepersoX <= largeur - 28) bluepersoX += vitesse;
  }
  
  if (upblue){
    if (bluepersoY <= hauteur - 250) bluepersoY += vitesse;
  }
  
  if (downblue){
    if (bluepersoY >= 0) bluepersoY -= vitesse;
  }
  
  image(vaisseau, bluepersoX, bluepersoY);
}

void keyPressed()
{
  if (key == CODED) {
    if (keyCode == LEFT) {
      leftred = true;}
      
    if (keyCode == RIGHT) {
      rightred = true;}
  }
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == LEFT){
      leftred = false;
    }
    
    if (keyCode == RIGHT){
      rightred = false;
    }
  }
}
void serialEvent(Serial port){
  val = port.readStringUntil('\n');
  dataTrie = split(val, ";");
  
  if (int(dataTrie[0]) >= 20){
    rightblue = true;
  } else rightblue = false;
  
  if (int(dataTrie[0]) <= -20){
    leftblue = true;
  } else leftblue = false;
  
  if (int(dataTrie[1]) >= 20){
  downblue = true;
  } else downblue = false;
  
  if (int(dataTrie[1]) <= -20){
  upblue = true;
  } else upblue = false;
}
