// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:solgis/projects/cargo/domain/entities/access_area.dart';

List<AreaDbModel> areaDbModelFromJson(String str) => List<AreaDbModel>.from(json.decode(str).map((x) => AreaDbModel.fromJson(x)));

class AreasDBModel{

  List<AreaDbModel> items = [];
  AreasDBModel();
  AreasDBModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = AreaDbModel.fromJson(item);
      items.add(cargo);
      
    }
  }
}

class AreaDbModel extends AccessArea{
  AreaDbModel({
      this.codigo,
      this.area,
  });

  String? codigo;
  String? area;

  AreaDbModel.fromJson(Map<String, dynamic> json) {
    codigo  = json["codigo"];
    area    = json["area"];
  }

}
