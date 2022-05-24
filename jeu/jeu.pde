import processing.serial.*;


int largeur = 640;
int hauteur = 960;

String val;
String [] dataTrie;
String []list_des_ports;

int redperso = largeur/2;
int bluepersoX = largeur/2;
int bluepersoY = hauteur/2;

int long_list_port;
int indice_port=0;

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
   
  list_des_ports=Serial.list();
  long_list_port = list_des_ports.length;
  if (long_list_port>1) {
  indice_port=1;
  }
  String nomDuPort = Serial.list()[indice_port];
  port = new Serial(this, nomDuPort, 9600);
  port.bufferUntil(lf);
}

void draw()
{
  background(3,34,76);
  fill(0,128,0);
  rect(0,950,640,960);
  
  
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
  if (key == 'Q'|| key == 'q'){
    rightblue = true;}
  if (key == 'Z'|| key == 'z'){
    upblue = true;}
  if (key == 'S'|| key == 's'){
    downblue = true;}
  if (key == 'D'|| key == 'd'){
    leftblue = true;}
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
  if (key == 'Q'|| key == 'q'){
    rightblue = false;}
  if (key == 'Z'|| key == 'z'){
    upblue = false;}
  if (key == 'S'|| key == 's'){
    downblue = false;}
  if (key == 'D'|| key == 'd'){
    leftblue = false;}
 
}
void serialEvent(Serial port){
  val = port.readStringUntil('\n');
  if (val.length() >= 1){
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
}
