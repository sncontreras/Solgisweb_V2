// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/destino_field.dart';

class DestinoModel extends DestinoField{

  DestinoModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  DestinoModel.fromJson(Map<String, dynamic>? json){

    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }


  }

}