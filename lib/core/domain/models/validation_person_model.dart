import 'dart:convert';

ValidationPersonResponse validationPersonResponseFromJson(String str) => ValidationPersonResponse.fromJson(json.decode(str));

class ValidationPersonResponse {
  ValidationPersonResponse({
    required this.resultado,
    required this.mensaje,
    required this.header,
    required this.codPers,
    required this.codigoServicio,
    required this.codMovSgte,
    required this.copMotivo,
    required this.codEmpresa,
    required this.codAutoriX,
    required this.codArea,
    required this.codPersTipo,
    required this.codCargo,
    required this.nroPase,
    required this.persTipo,
    required this.persNombres,
    required this.persEmpresa,
    required this.persMotivo,
    required this.persArea,
    required this.img,
    required this.nroDoi,
    required this.persAutoriPor,
    required this.persCargo
  });

  String? resultado;
  String? mensaje;
  String? header;
  int? codPers;
  int? codigoServicio;
  int? codMovSgte;
  int? copMotivo;
  int? codEmpresa;
  int? codAutoriX;
  int? codArea;
  int? codPersTipo;
  int? codCargo;

  String? nroPase;
  String? persTipo;
  String? persNombres;
  String? persEmpresa;
  String? persMotivo;
  String? persArea;
  String? img;
  String? nroDoi;
  String? persAutoriPor;
  String? persCargo;

  ValidationPersonResponse.fromJson(Map<String, dynamic> json) {
    resultado = json["resultado"];
    mensaje = json["mensaje"];
    header = json["header"];
    codPers = json["codPers"];
    codigoServicio = json["codigoServicio"];
    codMovSgte = json["codMovSgte"];
    copMotivo = json["copMotivo"];
    codEmpresa = json["codEmpresa"];
    codAutoriX = json["codAutoriX"];
    codArea = json["codArea"];
    codPersTipo = json["codPersTipo"];
    codCargo = json["codCargo"];

    nroPase = json["nroPase"];
    persTipo = json["persTipo"];
    persNombres = json["persNombres"];
    persEmpresa = json["persEmpresa"];
    persMotivo = json["persMotivo"];
    persArea = json["persArea"];
    img = json["img"];
    nroDoi = json["nroDOI"];
    persAutoriPor = json["persAutoriPor"];
    persCargo = json["persCargo"];

  }

}
