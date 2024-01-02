/*// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/data/models/epps_model.dart';
import 'package:solgis/projects/cargo/domain/entities/configuration.dart';
import 'package:solgis/projects/patrol/data/models/tipo_fotoo_model.dart';
import 'package:solgis/projects/patrol/domain/tipos_foto_patrol.dart';

class TipoFotosModel extends Configuration{

  TipoFotosModel({
    // this.fields, 
    this.tipoFotos
  });

  // @override
  // Field? fields;

  @override
  List<TipoFotosPatrol>? tipoFotos;

  TipoFotosModel.fromJson(Map<String, dynamic> json){
    final tipoFotos = TipoFotooModel.fromJsonList(json["TiposFoto"]);
    this.tipoFotos = tipoFotos.items;
  }

}*/