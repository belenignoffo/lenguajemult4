import processing.serial.*;

Serial myPort;  // Creo un objeto Serial
String val;      // Variable en la que voy a almacenar los datos de Arduino ( en este caso son enteros )

String estado = " ";

void setup() {
  size( 1134, 1000 );

  // Busco el puerto Serial en la lista
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background( 255 );

  if ( myPort.available() > 0) {  // Si el puerto no está ocupado,
    val = myPort.readString();         // leo la información y la almaceno en una variable
  }
  println( val );
  //Lo muestra por consola
}
