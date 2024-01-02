//import 'dart:convert';

// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:solgis/projects/cargo/domain/entities/vehicle_type.dart';

class VehicleTypesModel{
  List<VehicleTypeModel> items = [];
  VehicleTypesModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = VehicleTypeModel.fromJson(item);
      items.add(cargo);
    }
  }
}
class VehicleTypeModel extends VehicleType{
    VehicleTypeModel({
        this.codeVehicleType,
        this.vehicleType,
    });

    int? codeVehicleType;
    String? vehicleType;

    VehicleTypeModel.fromJson(Map<String, dynamic> json) {
        codeVehicleType = json["codigo"];
        vehicleType = json["tipo"];
    }

}
