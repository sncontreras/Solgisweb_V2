// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/photos_vehicule_field.dart';

class PhotosVehicleModel extends PhotosVehicleField{

  PhotosVehicleModel({
    this.delantera, 
    this.derecho, 
    this.trasera,
    this.izquierdo, 
    this.cabina, 
    this.guantera,
    this.carga
  });

  @override 
  bool? delantera;
  @override
  bool? derecho;
  @override 
  bool? trasera;
  @override
  bool? izquierdo;
  @override 
  bool? cabina;
  @override
  bool? guantera;
  @override
  bool? carga;

  PhotosVehicleModel.fromJson(Map<String, dynamic>? json){

    if( json != null){
      delantera = json["delantera"];
      derecho   = json["derecho"];
      trasera   = json["trasera"];
      izquierdo = json["izquierdo"];
      cabina    = json["cabina"];
      guantera  = json["guantera"];
      carga     = json["carga"];
    }

  }

}