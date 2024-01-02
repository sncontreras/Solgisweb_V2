import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solgis/core/domain/entities/photo_vehicle_position.dart';
import 'package:solgis/projects/cargo/domain/entities/guia.dart';

class RegistroProvider extends ChangeNotifier {
  
  //bien
  int _bienTemp = 0;

  //subbien
  int _subbienTemp = 0;

  //Controla las guias creadas.
  final List<Guia> _selectedGuias = [];

  //Controla las fotos de las posiciones del vehiculo .
  final List<PhotoVehiclePosition> _photosTakedVehiclePosition = [];

  //Controla la cantidad de fotos del bien
  final List<Map<String, int>> _perfiles = [];

  //guia
  String _guiaTemp = '';

  //foto temporal
  XFile? _photoTemp;

  bool _isLoading = false;

  //METODOS PARA VER SI ESTA CARGANDO O NO
  bool get isLoading => _isLoading;
  set isLoading(bool valor) {
    _isLoading = valor;
    notifyListeners();
  }

  //METODOS PARA LAS GUIAS.
  List<Guia> get selectedGuias => _selectedGuias;

  setGuia(Guia guia) {
    _selectedGuias.add(guia);
    notifyListeners();
  }

  deleteGuia(int index) {
    _selectedGuias.removeAt(index);
    notifyListeners();
  }

  deleteAllGuias() {
    _selectedGuias.clear();
    notifyListeners();
  }

  getGuia(int index) {
    return _selectedGuias[index];
  }

  //METODOS PARA LOS TIPOS DE FOTOS DEL BIEN
  List<PhotoVehiclePosition> get selectedPhotosVPosition =>
      _photosTakedVehiclePosition;

  setPhotoVehiclePosition(PhotoVehiclePosition photo) {
    _photosTakedVehiclePosition.add(photo);
    notifyListeners();
  }

  //METODOS PARA LAS FOTOS TOMADAS DE LA POSICION DE VEHICULO.
  List<Map<String, int>> get perfiles => _perfiles;

  setPerfiles(Map<String, int> perfil) {
    _perfiles.add(perfil);
    notifyListeners();
  }

  deletePhotoVehiclePosition(int index) {
    if (_photosTakedVehiclePosition.isNotEmpty) {
      _photosTakedVehiclePosition
          .removeWhere((photo) => photo.position == index);
      notifyListeners();
    }
  }

  deleteAllPhotosVehiclePosition() {
    _photosTakedVehiclePosition.clear();
    notifyListeners();
  }

  getPhotoVehiclePosition(int index) {
    if (_photosTakedVehiclePosition.isNotEmpty) {
      for (var photo in _photosTakedVehiclePosition) {
        if (photo.position == index) {
          return photo;
        }
      }
    }
    return null;
  }

  //Metodos de bien
  int get bienTemp => _bienTemp;
  set bienTemp(int value) {
    _bienTemp = value;
    notifyListeners();
  }

  //Metodos de bien
  int get subbienTemp => _subbienTemp;
  set subbienTemp(int value) {
    _subbienTemp = value;
    notifyListeners();
  }

  //Metodos de guia temporal
  String get guiaTemp => _guiaTemp;
  set guiaTemp(String value) {
    _guiaTemp = value;
    notifyListeners();
  }

  //Metodos de foto temporal
  XFile? get photoTemp => _photoTemp;
  set photoTemp(XFile? value) {
    _photoTemp = value;
    notifyListeners();
  }

  cleanDriverInformation() {
    notifyListeners();
  }

  cleanEntryData() {
    _selectedGuias.clear();
    _guiaTemp = '';
    _photoTemp = null;
    notifyListeners();
  }

  cleanPhotosVehicle() {
    _photosTakedVehiclePosition.clear();
    notifyListeners();
  }

  cleanPerfiles() {
    _perfiles.clear();
    notifyListeners();
  }
}
