import 'package:flutter/material.dart';

class RadioListConsultaProvider extends ChangeNotifier {

  //controla el radio de tipo de documento
  int _valorTipoDocumento  = 1;

  //controla el radio de tipo de persona
  final int _valorTipoPersonaDentroPlanta = 0;

  //controla el radio de tipo de persona movimiento del dia
  final int _valorTipoPersonaMovimientoDia= 0;

  int get valorTipoDocumento =>_valorTipoDocumento; 

  set valorTipoDocumento(int valor){
    _valorTipoDocumento = valor;
    notifyListeners();
  }

  int get valorTipoPersonaMovimientoDia =>_valorTipoPersonaMovimientoDia; 

  set valorTipoPersonaMovimientoDia(int valor){
    valorTipoPersonaMovimientoDia = valor;
    notifyListeners();
  }

  int get valorTipoPersonaDentroPlanta =>_valorTipoPersonaDentroPlanta; 

  set valorTipoPersonaDentroPlanta(int valor){
    valorTipoPersonaDentroPlanta = valor;
    notifyListeners();
  }


}