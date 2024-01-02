import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/data/models/vehicle_type_model.dart';

class VehicleTypeProvider extends ChangeNotifier{

  VehicleTypeModel? _selectedVehicleType;

  VehicleTypeModel? get selectedVehicleType=> _selectedVehicleType;

  set selectedVehicleType( VehicleTypeModel? vehicletype ){
    _selectedVehicleType = vehicletype;
    notifyListeners();
  }

}