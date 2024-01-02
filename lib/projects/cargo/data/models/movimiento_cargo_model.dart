import 'dart:convert';

List<MovimientoCargoModel> movimientoCargoModelFromJson(String str) =>
    List<MovimientoCargoModel>.from(
        json.decode(str).map((x) => MovimientoCargoModel.fromJson(x)));

class MovimientosCargoModel {
  List<MovimientoCargoModel> items = [];
  MovimientosCargoModel();
  MovimientosCargoModel.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final movimientoCargo = MovimientoCargoModel.fromJson(item);
      items.add(movimientoCargo);
    }
  }
}

class MovimientoCargoModel {
  int? codMovimiento;
  int? codigoVehicular;
  String? placa;
  int? codTipoVehiculo;
  String? tipoVehiculo;
  String? nombres;
  String? dni;
  String? cargo;
  String? empresa;
  DateTime? fechaIngreso;
  DateTime? fechaSalida;
  String? imagen;

  MovimientoCargoModel({
    this.codMovimiento,
    this.codigoVehicular,
    this.placa,
    this.codTipoVehiculo,
    this.tipoVehiculo,
    this.nombres,
    this.dni,
    this.cargo,
    this.empresa,
    this.fechaIngreso,
    this.fechaSalida,
    this.imagen,
  });

  MovimientoCargoModel.fromJson(Map<String, dynamic> json) {
    codMovimiento = json["cod_movimiento_entrada"];
    codigoVehicular = json["cod_vehicular"];
    placa = json["nro_placa"];
    codTipoVehiculo = json["cod_tipo_vehiculo"];
    tipoVehiculo = json["tipo_vehiculo"];
    nombres = json["nombres"];
    dni = json["dni"];
    cargo = json["cargo"];
    empresa = json["empresa"];
    fechaIngreso = DateTime.parse(json["fecha_entrada"]);
    fechaSalida = (json["fecha_salida"] != null)
        ? DateTime.parse(json["fecha_salida"])
        : null;
    imagen = json["imagen"];

  }
}
