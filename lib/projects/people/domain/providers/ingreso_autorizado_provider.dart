// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solgis/projects/people/domain/models/guia_model.dart';
import 'package:solgis/projects/people/domain/models/value_thing_model.dart';

class IngresoAutorizadoProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cod_tipo_doc = '';
  String dni = '';
  String cod_persona = '';
  String nombres = '';
  String cod_cargo = '';
  String cod_empresa = '';
  String empresa = '';
  String cargo = '';
  int    _codAutorizante = 0;
  String _autorizante = '';
  int     cod_motivo = 0;
  String _motivo = '';
  int     cod_area = 0;
  String _area_acceso = '';
  String _guia = '';
  String _material_valor = '';
  XFile? _fotoGuia;
  XFile? _fotoMaterialValor;
  bool   _isLoading = false;

  final List<Guia> _selectedGuias      = [];
  final List<ValueThing> _selectThings = [];

  //METODOS PARA LAS COSAS DE VALOR
  List<ValueThing> get selectedThings => _selectThings;

  setThing(ValueThing thing) {
    _selectThings.add(thing);
    notifyListeners();
  }

  deleteThing(int index) {
    _selectThings.removeAt(index);
    notifyListeners();
  }

  deleteAllThings() {
    _selectThings.clear();
    notifyListeners();
  }

  getThing(int index) {
    return _selectThings[index];
  }

  //METODOS PARA LA GUIAS
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

  //CONTROLA LA FOTO CUANDO NO TIENE Y SE QUIERE ACTUALIZAR
  File? fotoPersonalUpdate;

  //FOTO
  void updateImage(String path) {
    fotoPersonalUpdate = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE LOADING
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE AUTORIZANTE
  int get codautorizante => _codAutorizante;

  set codautorizante(int value) {
    _codAutorizante = value;
    // notifyListeners();
  }

  // METODOS PARA LA VARIABLE AUTORIZANTE
  String get autorizante => _autorizante;

  set autorizante(value) {
    _autorizante = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE MOTIVO
  int get codmotivo => cod_motivo;

  set codmotivo(int value) {
    cod_motivo = value;
    // notifyListeners();
  }

  // METODOS PARA LA VARIABLE MOTIVO
  String get motivo => _motivo;

  set motivo(value) {
    _motivo = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE AREA ACCESO
  int get codarea => cod_area;

  set codarea(int value) {
    cod_area = value;
    // notifyListeners();
  }

  // METODOS PARA LA VARIABLE AREA ACCESO
  String get area_acceso => _area_acceso;

  set area_acceso(value) {
    _area_acceso = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE GUIA
  String get guia => _guia;

  set guia(String value) {
    _guia = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE MATERIAL VALOR
  String get material_valor => _material_valor;

  set material_valor(String value) {
    _material_valor = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE FOTO GUIA
  XFile? get fotoGuia => _fotoGuia;

  set fotoGuia(XFile? value) {
    _fotoGuia = value;
    notifyListeners();
  }

  // METODOS PARA LA VARIABLE FOTO MATERIAL VALOR
  XFile? get fotoMaterialValor => _fotoMaterialValor;

  set fotoMaterialValor(XFile? value) {
    _fotoMaterialValor = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
