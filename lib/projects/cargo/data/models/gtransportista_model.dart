// ignore_for_file: overridden_fields, must_be_immutable

import 'package:solgis/projects/cargo/domain/entities/fields/g_transportista_field.dart';

class GTranspModel extends GTransportistaField{

  GTranspModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;

  @override
  bool? isMultiple;

  GTranspModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }


  }

}