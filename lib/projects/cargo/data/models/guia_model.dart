
// ignore_for_file: overridden_fields, must_be_immutable

import 'package:solgis/projects/cargo/domain/entities/fields/guia_field.dart';

class GuiaModel extends GuiaField{

  GuiaModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  GuiaModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }

  }

}