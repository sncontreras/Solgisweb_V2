// ignore_for_file: overridden_fields

import 'package:solgis/projects/cargo/domain/entities/fields/op_logistico_field.dart';

// ignore: must_be_immutable
class OpLogModel extends OpLogisticoField{

  OpLogModel({
    this.hasfoto,
    this.isMultiple,
  });

  @override 
  bool? hasfoto;
  @override
  bool? isMultiple;

  OpLogModel.fromJson(Map<String, dynamic>? json){
    if( json != null){
      hasfoto = json["hasFoto"];
      isMultiple = json["isMultiple"];
    }


  }

}