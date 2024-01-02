// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:solgis/projects/cargo/domain/entities/carga_type.dart';
List<TipoCargaModel> tipoCargaModelFromJson(String str) => List<TipoCargaModel>.from(json.decode(str).map((x) => TipoCargaModel.fromJson(x)));

class TiposCargaModel{

  List<TipoCargaModel> items = [];
  TiposCargaModel();

  TiposCargaModel.fromJsonList( List<dynamic> jsonList ){
    for( var item in jsonList ){
      final carga = TipoCargaModel.fromJson(item);
      items.add(carga);
    }
  }

}

class TipoCargaModel extends CargaType {

  TipoCargaModel({
    this.codigo,
    this.cargaType,
  });

  String? codigo;
  String? cargaType;

  TipoCargaModel.fromJson(Map<String, dynamic> json){
    codigo = json["typeCargaId"];
    cargaType       = json["description"];
  }

}
