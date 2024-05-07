/*
ArrayList: almacena un número variable de objetos. Podemos agregar o eliminar obj de manera dinámica.
 Es una implementación de Arrays de tamaño variable.
 
 size() = devuelve la longitud del arraylist
 add() = agrega un elemento
 remove() = elimina un elemento
 get() = devuelve un elemento en la posición específica en la lista
 
 */

// ArrayList <Ball> balls;
ArrayList <Img> imgs;
//int ballWidth;

void setup() {
  size( 1134, 1000 );
  noStroke( );
  //balls = new ArrayList<Ball>();
  imgs = new ArrayList<Img>();
}

void draw() {
  background( 255 );
  //ballWidth = int(random( 50, 100 ));
  
  for( int i = imgs.size()-1; i >= 0; i-- ){
    Img img = imgs.get(i);
    img.display();
  }
  /*
  for ( int i = balls.size()-1; i>= 0; i-- ) {
    Ball ball = balls.get(i);
    ball.move();
    ball.display();
    if ( ball.finished() ) {
      balls.remove( i );
    }
  }
 */
}

void mousePressed() {
  //balls.add( new Ball( mouseX, mouseY, ballWidth ) );
  // Esto debería darse en el draw/transcurso del tiempo, en posiciones aleatorias
  imgs.add( new Img( mouseX, mouseY ));
}
