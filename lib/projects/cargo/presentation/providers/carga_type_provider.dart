import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';

class CargaTypeProvider extends ChangeNotifier{

  TipoCargaModel? _selectedCargaType;

  TipoCargaModel? get selectedCargaType=> _selectedCargaType;

  set selectedCargaType( TipoCargaModel? cargatype ){
    _selectedCargaType = cargatype;
    notifyListeners();
  }

}