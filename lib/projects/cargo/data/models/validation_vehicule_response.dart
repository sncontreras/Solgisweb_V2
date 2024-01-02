import 'dart:convert';

ValidationVehicleResponse validationVehicleResponseFromJson(String str) =>
    ValidationVehicleResponse.fromJson(json.decode(str));

class ValidationVehicleResponse {
  ValidationVehicleResponse(
      {required this.resultado,
      required this.mensaje,
      required this.header,
      required this.codigoVehiculo,
      required this.codigoServicio,
      required this.codMovSgte,
      required this.tipoVehiculo,
      required this.img,
      required this.nroPlaca,
      required this.tProp,
      required this.fSoat,
      required this.fRevTec,
      required this.dni,
      required this.tieneAutorizacion,
      required this.mensajeAutorizacion});

  String? resultado;
  String? mensaje;
  String? header;
  int? codigoVehiculo;
  int? codigoServicio;
  int? codMovSgte;
  String? tipoVehiculo;
  String? img;
  String? nroPlaca;
  String? tProp;
  String? fSoat;
  String? fRevTec;
  String? dni;
  String? tieneAutorizacion;
  String? mensajeAutorizacion;

  ValidationVehicleResponse.fromJson(Map<String, dynamic> json) {
    resultado = json["resultado"];
    mensaje = json["mensaje"];
    header = json["header"];
    codigoVehiculo = json["codigoVehiculo"];
    codigoServicio = json["codigoServicio"];
    codMovSgte = json["codMovSgte"];
    tipoVehiculo = json["tipoVehiculo"];
    img = json["img"];
    nroPlaca = json["nroPlaca"];
    tProp = json["tarjeta_prop"];
    fSoat = json["f_venc_soat"];
    fRevTec = json["f_rev_tec"];
    dni = json["dni"];
    String tieneAut = json["tiene_aut"];
    String mensajeAut = json["mensaje_aut"];
    tieneAutorizacion = tieneAut;
    mensajeAutorizacion = mensajeAut;
  }
}
