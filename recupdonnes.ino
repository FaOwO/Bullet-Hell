#include <Esplora.h>

#define SerialSpeed 115200    // Vitese de communication série


void setup() {
  Serial.begin(SerialSpeed);

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(Esplora.readJoystickX());
  Serial.print(";");
  Serial.print(Esplora.readJoystickY());
  Serial.print(";");
  Serial.print(Esplora.readButton(2));
  Serial.print(";");
  Serial.print(Esplora.readButton(3));
  Serial.print(";");
  Serial.println();  
}
