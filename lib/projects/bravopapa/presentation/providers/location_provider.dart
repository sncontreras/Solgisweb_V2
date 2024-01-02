import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String _location = "Obteniendo Ubicacion..";
  String get location => _location;

  void updateLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }
}
