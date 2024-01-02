// ignore_for_file: must_be_immutable, overridden_fields


import 'package:solgis/projects/cargo/domain/entities/fields/tipo_material_field.dart';

class TipoMaterialModel extends TipoMaterialField{

  TipoMaterialModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  TipoMaterialModel.fromJson(Map<String, dynamic>? json){

    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }


  }

}