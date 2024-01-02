// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class VehicleType extends Equatable {

  VehicleType({
    this.codeVehicleType,
    this.vehicleType,
  });

  int? codeVehicleType;
  String? vehicleType; 
  
  @override
  List<Object?> get props => [ codeVehicleType, vehicleType];

}
