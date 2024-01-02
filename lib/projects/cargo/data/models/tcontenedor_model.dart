// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/tamanio_contenedor_field.dart';

class TContenedorModel extends TContenedorField{

  TContenedorModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  TContenedorModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }

  }

}