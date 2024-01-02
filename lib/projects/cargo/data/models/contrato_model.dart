// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/contrato_field.dart';

class ContratoModel extends ContratoField{

  ContratoModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;

  @override
  bool? isMultiple;

  ContratoModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }

  }

}