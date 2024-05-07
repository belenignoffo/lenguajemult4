class Img {

  float x;
  float y;
  float w;

  PImage [] imagenes;
  int cantImagenes = 11;

  Img( float tempX, float tempY ) {
    cargaImagenes( );
    x = tempX;
    y = tempY;
  }

  void cargaImagenes(  ) {
    // Método para cargar las imágenes
    imagenes = new PImage[ cantImagenes ];
    for ( int i = 0; i < cantImagenes; i++ ) {
      imagenes[i] = loadImage("img_" + nf(i, 4) + ".png");
    }
  }

  void display() {
    // Acá hay un array fijo pero lo ideal sería pasarlo por parámetro y que sea aleatorio
    image( imagenes[0], x, y );
  }
}
