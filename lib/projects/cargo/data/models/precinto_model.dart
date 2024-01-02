// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/precinto_field.dart';

class PrecintoModel extends PrecintoField{

  PrecintoModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  PrecintoModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }

  }

}