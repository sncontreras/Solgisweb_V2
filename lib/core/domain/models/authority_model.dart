// ignore_for_file: overridden_fields, annotate_overrides

//import 'dart:convert';

import 'package:solgis/core/domain/models/authority.dart';


class AuthoritysModel{
  List<AuthorityModel> items = [];
  AuthoritysModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = AuthorityModel.fromJson(item);
      items.add(cargo);
    }
  }
}


// ignore: must_be_immutable
class AuthorityModel extends Authority{
  AuthorityModel({
    required this.codigo,
    required this.codPersonal,
    required this.nombrePersonal,
    required this.dniPersonal,
  });

  String? codigo;
  String? codPersonal;
  String? nombrePersonal;
  String? dniPersonal;

  AuthorityModel.fromJson(Map<String, dynamic> json) {
    codigo = json["codigo"];
    codPersonal = json["cod_personal"];
    nombrePersonal = json["nombre_personal"];
    dniPersonal = json["dni_personal"];
  }

}