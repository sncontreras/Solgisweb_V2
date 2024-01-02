import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {

  //controla los inputs
  TextEditingController _inputController1 = TextEditingController();
  TextEditingController _inputController2 = TextEditingController();
  TextEditingController _inputController3 = TextEditingController();
  TextEditingController _inputController4 = TextEditingController();
  TextEditingController _inputController5 = TextEditingController();
  TextEditingController _inputController6 = TextEditingController();

  //controla el radio de tipo de registro
  int _tipoRegistro  = 1;

  //controla el radio de tipo de carga
  int _valorTipoCargaDentroPlanta = 0; //Deberia ir en su provider

  //controla el radio de tipo de carga movimiento del dia
  int _valorTipoCargaMovimientoDia= 0; //Deberia ir en su provider

  //controla el valor de la placa
  String _placa = '';

  //controla el valor del codigo
  String _codigo = '';

  //Metodos del documento
  TextEditingController get inputController1 => _inputController1;

  set inputController1( TextEditingController controller ){
    _inputController1 = controller;
    notifyListeners();
  }

  //Metodos del documento
  TextEditingController get inputController2 => _inputController2;

  set inputController2( TextEditingController controller ){
    _inputController2 = controller;
    notifyListeners();
  }

  //Metodos del documento
  TextEditingController get inputController3 => _inputController3;

  set inputController3( TextEditingController controller ){
    _inputController3 = controller;
    notifyListeners();
  }

  //Metodos del documento
  TextEditingController get inputController4 => _inputController4;

  set inputController4( TextEditingController controller ){
    _inputController4 = controller;
    notifyListeners();
  }

  //Metodos del documento
  TextEditingController get inputController5 => _inputController5;

  set inputController5( TextEditingController controller ){
    _inputController5 = controller;
    notifyListeners();
  }

  //Metodos del documento
  TextEditingController get inputController6 => _inputController6;

  set inputController6( TextEditingController controller ){
    _inputController6 = controller;
    notifyListeners();
  }

  String get placa => _placa;

  set placa(String valor){
    _placa = valor;
    notifyListeners();
  }

  String get codigo => _codigo;

  set codigo(String valor){
    _codigo = valor;
    notifyListeners();
  }

  int get tipoRegistro =>_tipoRegistro; 

  set tipoRegistro(int valor){
    _tipoRegistro = valor;
    notifyListeners();
  }

  int get valorTipoCargaMovimientoDia =>_valorTipoCargaMovimientoDia; 

  set valorTipoCargaMovimientoDia(int valor){
    _valorTipoCargaMovimientoDia = valor;
    notifyListeners();
  }

  int get valorTipoCargaDentroPlanta =>_valorTipoCargaDentroPlanta; 

  set valorTipoCargaDentroPlanta(int valor){
    _valorTipoCargaDentroPlanta = valor;
    notifyListeners();
  }

  cleanInputControllers(){
    _inputController1.clear();
    _inputController2.clear();
    _inputController3.clear();
    _inputController4.clear();
    _inputController5.clear();
    _inputController6.clear();
  }

}