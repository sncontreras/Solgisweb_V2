
// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/container_field.dart';

class ContainerModel extends ContainerField{

  ContainerModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  
  @override
  bool? isMultiple;

  ContainerModel.fromJson(Map<String, dynamic>? json){

    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }
    
  }

}