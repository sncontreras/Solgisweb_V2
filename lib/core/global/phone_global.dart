import 'package:flutter/material.dart';

// Creamos una clase que hereda de InheritedWidget
class PhoneGlobal extends InheritedWidget {
  final String phoneGlobal;

  const PhoneGlobal({super.key, required this.phoneGlobal, required Widget child}) : super(child: child);

  // Esta función permite a los widgets hijos acceder al MyData mediante el contexto
  static PhoneGlobal? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PhoneGlobal>();
  }

  @override
  bool updateShouldNotify(PhoneGlobal oldWidget) {
    return phoneGlobal != oldWidget.phoneGlobal; // Se llama a rebuild si el valor cambia
  }
}
