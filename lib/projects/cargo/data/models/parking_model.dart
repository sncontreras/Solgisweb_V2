//import 'dart:convert';

class ParkingsModel{

  List<ParkingModel> items = [];

  ParkingsModel.fromJsonList(List<dynamic> jsonList) {
    for ( var item in jsonList ){
      final parking = ParkingModel.fromJson(item);
      items.add(parking);
    }
  }
}

class ParkingModel {
  ParkingModel({
    this.codParqueo,
    this.nameParqueo,
  });

  int? codParqueo;
  String? nameParqueo;

  ParkingModel.fromJson(Map<String, dynamic> json) {
    codParqueo = json["codParqueo"];
    nameParqueo = json["nameParqueo"].toString();
  }

}
