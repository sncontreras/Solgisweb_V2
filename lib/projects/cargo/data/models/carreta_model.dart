// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/carreta_field.dart';

class CarretaModel extends CarretaField{

  CarretaModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  CarretaModel.fromJson(Map<String, dynamic>? json){

    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }


  }

}