

// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/carga_field.dart';

class CargaModel extends CargaField{

  CargaModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  CargaModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }

  }

}