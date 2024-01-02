class CountSendSignal {
  // Declarar una variable global de tipo int e inicializarla en 0.
  int _counter = 0;

  void increaseCounter() {
    _counter++;
  }

  // Función para reiniciar el contador a 0.
  void resetCounter() {
    _counter = 0;
  }

  // Función para obtener el valor actual del contador.
  int getCounterValue() {
    return _counter;
  }

  // Declarar el constructor privado para garantizar que solo haya una instancia.
  CountSendSignal._privateConstructor();

  // Crear una instancia única de la clase.
  static final CountSendSignal instance = CountSendSignal._privateConstructor();
}
