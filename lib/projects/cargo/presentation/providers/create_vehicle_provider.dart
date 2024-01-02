import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solgis/core/domain/models/enterprise_model.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';
import 'package:solgis/projects/cargo/domain/entities/vehicle_type.dart';

class CreateVehicleProvider extends ChangeNotifier{

  TextEditingController _placaControlller        = TextEditingController();
  VehicleType _selectedVehicleType               =  VehicleType() ;
  TipoCargaModel _selectedCargaType              = TipoCargaModel();
  TextEditingController _propertyCardControlller = TextEditingController();
  XFile? _propertyCardphoto;
  File? foto;
  List<DateTime?>? _soatExpirationDate;
  XFile? _soatExpirationDatephoto;
  List<DateTime?>? _technicalDate;
  XFile? _technicalDatephoto;
  bool _isLoading =false;
  EnterpriseModel _selectedEnterprise            = EnterpriseModel();

  EnterpriseModel get selectedEnterprise=> _selectedEnterprise;
  set selectedEnterprise( EnterpriseModel vehicletype ){
    _selectedEnterprise = vehicletype;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool valor){
    _isLoading = valor;
    notifyListeners();
  }

  XFile? get technicalDatephoto=> _technicalDatephoto;
  set technicalDatephoto( XFile? photo ){
    _technicalDatephoto = photo;
    notifyListeners();
  }

  List<DateTime?>?  get technicalDate => _technicalDate;
  set technicalDate( List<DateTime?>?  expirationDate ){
    _technicalDate = expirationDate;
    notifyListeners();
  }

  XFile? get soatExpirationphoto=> _soatExpirationDatephoto;
  set soatExpirationphoto( XFile? photo ){
    _soatExpirationDatephoto = photo;
    notifyListeners();
  }

  List<DateTime?>?  get soatExpirationDate => _soatExpirationDate;
  set soatExpirationDate( List<DateTime?>?  expirationDate ){
    _soatExpirationDate = expirationDate;
    notifyListeners();
  }

  XFile? get propertyCardphoto=> _propertyCardphoto;
  set propertyCardphoto( XFile? photo ){
    _propertyCardphoto = photo;
    notifyListeners();
  }

  TextEditingController get propertyCardControlller=> _propertyCardControlller;
  set propertyCardControlller( TextEditingController propertyCard ){
    _propertyCardControlller = propertyCard;
    notifyListeners();
  }

  VehicleType get selectedVehicleType=> _selectedVehicleType;
  set selectedVehicleType( VehicleType vehicletype ){
    _selectedVehicleType = vehicletype;
    notifyListeners();
  }

  TipoCargaModel get selectedCargaType=> _selectedCargaType;
  set selectedCargaType( TipoCargaModel vehicletype ){
    _selectedCargaType = vehicletype;
    notifyListeners();
  }

  TextEditingController get placaController=> _placaControlller;
  set placaController( TextEditingController placa ){
    _placaControlller = placa;
    notifyListeners();
  }

  void updateImage( String path ){
    foto = File.fromUri(Uri(path: path));
    notifyListeners();
  }

}