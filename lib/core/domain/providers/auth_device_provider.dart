// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AuthDeviceStatus{

  Uninitialized,    //CUANDO INICIALIZA LA APP POR PRIMERA VEZ EN UN DISPOSITIVO.
  Authenticanting,  //CUANDO ESTA PROCESANDO LA AUTENTICACION
  Pending,          //CUANDO SE HA ENVIADO LOS DATOS Y AUN NO HAY APROBACION POR EL PANEL DE CONTROL.
  Aproved,          //CUANDO EL DISPOSITIVO HA SIDO APROBADO Y SE LE HA ASIGNADO DATOS DESDE EL PANEL DE CONTROL.
  Refused,          //CUANDO EL DISPOSITIVO HA SIDO RECHAZADO DESDE EL PANEL DE CONTROL.
}

class AuthDeviceProvider extends ChangeNotifier{

  String _serialNumber  = '';

  String get serialNumber => _serialNumber;

  set serialNumber(String value){
    _serialNumber = value;
    notifyListeners();
  }

  //EL ENVIO DE LOS DATOS DEL DISPOSITIVO A LA BASE DE DATOS.
  AuthDeviceStatus status = AuthDeviceStatus.Uninitialized;

  changeState(AuthDeviceStatus state){
    status = state;
    notifyListeners();
  }

}