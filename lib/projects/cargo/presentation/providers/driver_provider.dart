import 'package:flutter/material.dart';
import 'package:solgis/core/domain/models/validation_person_model.dart';

class DriverProvider extends ChangeNotifier{

  ValidationPersonResponse? _driverResponse ;
  bool _isLoading = false;


  ValidationPersonResponse? get driverResponse => _driverResponse;

  set driverResponse( ValidationPersonResponse? validation ){
    _driverResponse = validation;
    notifyListeners();
  }

  set driverResponsesinRefresh( ValidationPersonResponse? validation ){
    _driverResponse = validation;
  }

  bool get isLoading => _isLoading;

  set isLoading( bool value ){
    _isLoading= value;
    notifyListeners();
  }

  cleanValidationPerson(){
    _driverResponse = null;
    notifyListeners();
  }
}