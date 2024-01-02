import 'package:flutter/material.dart';

class MarcarServicioProvider extends ChangeNotifier {
  List<List<bool>> cellStates = List.generate(3, (_) => List.filled(4, false));

  String getColumnName(int index) {
    switch (index) {
      case 0:
        return 'km';
      case 1:
        return 'Liv';
      case 2:
        return 'PLATA';
      default:
        return 'CHE';
    }
  }

  void updateCellState(int rowIndex, int colIndex, bool value) {
    cellStates[rowIndex][colIndex] = value;
    notifyListeners();
  }

  void saveData() {
    // Implementa la lógica para guardar los datos aquí
  }
}
