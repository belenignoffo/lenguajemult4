import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

/*
ArrayList: almacena un número variable de objetos. Podemos agregar o eliminar obj de manera dinámica.
 Es una implementación de Arrays de tamaño variable.
 
 size() = devuelve la longitud del arraylist
 add() = agrega un elemento
 remove() = elimina un elemento
 get() = devuelve un elemento en la posición específica en la lista
 
 */



ArrayList <Img> imgs;


void setup() {
  size( 1134, 1000 );
  noStroke( );
  imgs = new ArrayList<Img>();


  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background( 255 );
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  if ( val < 15 ) {
    background( 150, 200, 200 );
  }
  println(val); //Lo muestra por consola
}


void mousePressed() {
  // Esto debería darse en el draw/transcurso del tiempo, en posiciones aleatorias
  imgs.add( new Img( mouseX, mouseY ));
}
