/* COMUNICACION SERIAL */
import processing.serial.*;
Serial myPort;
String val;

String estado = "quieto";
float timer = 0;
boolean fueRapido = false;
boolean fueConstante = false;

void setup() {
  size(800, 800);

  // --- PUERTO SERIAL
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);

  if (keyPressed) {
    if ((key == 'r' || key == 'R') && !fueRapido) {
      estado = "rapido";
      fueConstante = false; // Resetear el flag de "constante" cuando se cambia a "rapido"
      myPort.write(1); // Enviar 1 a Arduino cuando se activa "rapido"
    } else if ((key == 'c' || key == 'C') && !fueConstante) {
      estado = "constante";
      fueRapido = false; // Resetear el flag de "rapido" cuando se cambia a "constante"
      myPort.write(2); // Enviar 2 a Arduino cuando se activa "constante"
    }
  } else {
    if (estado.equals("rapido")) {
      fueRapido = true;
    } else if (estado.equals("constante")) {
      fueConstante = true;
    }
    estado = "quieto";
    myPort.write(0); // Enviar 0 a Arduino cuando el estado es "quieto"
  }

  if (estado.equals("rapido")) {
    timer++;

    if (timer <= 80) {
      background(255, 0, 0);
    } else {
      estado = "quieto";
      fueRapido = true;
      myPort.write(0); // Enviar 0 a Arduino cuando el timer de "rapido" se cumple
    }
  } else if (estado.equals("constante")) {
    timer++;

    if (timer <= 400) {
      background(0, 255, 0);
    } else {
      estado = "receso";
      myPort.write(3); // Enviar 3 a Arduino cuando el timer de "constante" se cumple
    }
  } else if (estado.equals("receso")) {
    estado = "quieto";
    fueConstante = true;
    myPort.write(3); // Enviar 3 a Arduino cuando el estado es "receso"
    // Si el estado en Arduino es == "Receso", entonces la lógica de apagado es similar a la de encendido gradual nada más que a la inversa (va decreciendo de 250 hasta llegar a 10)
  }

  if (estado.equals("quieto")) {
    if (!keyPressed) {
      timer = 0;
    }
  }

  println("Estado: " + estado + ", Timer: " + timer);
}
