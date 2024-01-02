
class AsignedParkingModel {

  AsignedParkingModel({
    this.codParqueo,
    this.nameParqueo,
  });

  int? codParqueo;
  String? nameParqueo;

  AsignedParkingModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      codParqueo = json["codParqueo"];
      nameParqueo = json["nameParqueo"];
    }
  }
}