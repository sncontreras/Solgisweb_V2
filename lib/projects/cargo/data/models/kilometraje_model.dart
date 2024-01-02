// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/kilometraje_field.dart';

class KilometrajeModel extends KilometrajeField{

  KilometrajeModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  KilometrajeModel.fromJson(Map<String, dynamic>? json){

    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }


  }

}