// ignore_for_file: must_be_immutable, overridden_fields

import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';
import 'package:solgis/projects/cargo/domain/entities/movement.dart';

// ignore: non_constant_identifier_names
List<MovementModel> MovementModelFromJson(String str) => List<MovementModel>.from(json.decode(str).map((x) => MovementModel.fromJson(x)));

// @JsonSerializable()
class MovementModel extends Movement{

  MovementModel({
    this.codMovimiento, 
    this.codigoVehicular,
    this.placa,
    this.tipoCarga,
    this.nombres,
    this.dni,
    this.cargo,
    this.empresa,
    this.fechaIngreso,
    this.fechaSalida,
  });       

  MovementModel.fromJson(Map<String, dynamic> json) {
    codMovimiento   = json["cod_movimiento"];
    codigoVehicular = json["codigo_vehicular"];
    placa           = json["placa"];
    tipoCarga       = json["tipo_carga"];
    nombres         = json["nombres"];
    dni             = json["dni"];
    cargo           = json["cargo"];
    empresa         = json["empresa"];
    fechaIngreso    = DateTime.parse(json["fecha_ingreso"]);
    fechaSalida     = json["fecha_salida"];
  }
  @override
  String? codMovimiento;

  @override
  String? codigoVehicular;

  @override
  String? placa;

  @override
  String? tipoCarga;

  @override
  String? nombres;

  @override
  String? dni;

  @override
  String? cargo;

  @override
  String? empresa;

  @override
  DateTime? fechaIngreso;

  @override
  String? fechaSalida;



}
