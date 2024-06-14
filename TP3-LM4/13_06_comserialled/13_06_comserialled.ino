int ledPin = 10;
char val;
int aumento = 0;

unsigned long previousMillis = 0;
const long interval = 1000;  // intervalo de 1 segundo
bool ledOn = false;

void setup() {
  pinMode(ledPin, OUTPUT);
  analogWrite(ledPin, 10);
  Serial.begin(9600);
}

void loop() {

  if (Serial.available()) {
    val = Serial.read();
    if (val == 0) {  // estado 0 incio
      analogWrite(ledPin, 10);

    } else if (val == 1) {  //fuerte
      analogWrite(ledPin, 250);

    } else if (val == 2) {  //gradual
    aumento++;
      analogWrite(ledPin, 10 + aumento );
    }
  }
}
