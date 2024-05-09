#define sensorBoton 2

 
 void setup() {
  // put your setup code here, to run once:
  pinMode( sensorBoton, INPUT );
  Serial.begin( 9600 );
}

void loop() {
  // put your main code here, to run repeatedly:
  int circuito = digitalRead( sensorBoton );
  if( circuito == 1 ){
    Serial.println("A");
  } else {
    Serial.println("B");
  }
  delay( 100 );
}
