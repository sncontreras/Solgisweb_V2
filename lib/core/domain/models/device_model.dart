import 'dart:convert';

List<DeviceResponseModel> deviceResponseModelFromJson(String str) =>
    List<DeviceResponseModel>.from(
        json.decode(str).map((x) => DeviceResponseModel.fromJson(x)));

class DeviceResponseModel {
  DeviceResponseModel({
    this.estado,
    this.message,
    this.idDispositivo,
  });

  int? estado;
  String? message;
  int? idDispositivo;

  DeviceResponseModel.fromJson(Map<String, dynamic> json) {
    estado = json["estado"] ?? '';
    message = json["message"] ?? '';
    idDispositivo = json["id_dispositivo"] ?? '';
  }
}

RelacionDispositivoModel relacionDispositivoModelFromJson(String str) =>
    RelacionDispositivoModel.fromJson(json.decode(str));

class RelacionDispositivoModel {
  RelacionDispositivoModel({
    this.codigoDispositivo,
    this.numberDevice,
    this.isFasScan,
    this.codigoServicio,
    this.codigoCliente,
    this.codigoSubArea,
    this.nombreArea,
    this.nombreSubArea,
    this.nombreSucursal,
    this.nombreCliente,
    this.aliasSede,
    this.codigoTipoServicio,
    this.codigoPuesto,
    this.nombrePuesto,
    this.codigoPerfil,
    this.grupoUsuarioId,
    this.codPolitica,
  });

  int? codigoDispositivo;
  String? numberDevice;
  bool? isFasScan;
  int? codigoServicio;
  String? codigoCliente;
  int? codigoSubArea;
  String? nombreArea;
  String? nombreSubArea;
  String? nombreSucursal;
  String? nombreCliente;
  dynamic aliasSede;
  int? codigoTipoServicio;
  int? codigoPuesto;
  String? nombrePuesto;
  int? codigoPerfil;
  int? grupoUsuarioId;
  int? codPolitica;

  RelacionDispositivoModel.fromJson(Map<String, dynamic> json) {
    codigoDispositivo = json["codigo_dispositivo"];
    numberDevice = json["numero_dispositivo"];
    isFasScan = (json["version_people"] == 0 || json["version_people"] == null ) ? false : true;
    codigoServicio = json["codigo_servicio"];
    codigoCliente = json["codigo_cliente"];
    codigoSubArea = json["codigo_sub_area"];
    nombreArea = json["nombre_area"];
    nombreSubArea = json["nombre_sub_area"];
    nombreSucursal = json["nombre_sucursal"];
    nombreCliente = json["nombre_cliente"];
    aliasSede = json["alias_sede"];
    codigoTipoServicio = json["codigo_tipo_servicio"];
    codigoPuesto = json["codigo_puesto"];
    nombrePuesto = json["nombre_puesto"];
    codigoPerfil = json["codigo_perfil"];
    grupoUsuarioId = json["codigo_grupo_usuarios"];
    codPolitica = json["codigo_politica"];
  }
}


// List<RelationDeviceServiceModel> relationDeviceServiceModelFromJson(String str) => List<RelationDeviceServiceModel>.from(json.decode(str).map((x) => RelationDeviceServiceModel.fromJson(x)));

// class RelationDeviceServiceModel {
//     RelationDeviceServiceModel({
//         this.codigoDispositivo,
//         this.codigoServicio,
//         this.codigoCliente,
//         this.codigoSubArea,
//         this.nombreArea,
//         this.nombreSubArea,
//         this.nombreSucursal,
//         this.nombreCliente,
//         this.aliasSede,
//         this.codigoTipoServicio,
//         this.nombrePuesto,
//     });

//     int?    codigoDispositivo;
//     int?    codigoServicio;
//     String? codigoCliente;
//     int?    codigoSubArea;
//     String? nombreArea;
//     String? nombreSubArea;
//     String? nombreSucursal;
//     String? nombreCliente;
//     dynamic aliasSede;
//     int?    codigoTipoServicio;
//     String? nombrePuesto;

//     RelationDeviceServiceModel.fromJson(Map<String, dynamic> json) {
//       codigoDispositivo  = json["codigo_dispositivo"];
//       codigoServicio     = json["codigo_servicio"].toInt();
//       codigoCliente      = json["codigo_cliente"];
//       codigoSubArea      = json["codigo_sub_area"];
//       nombreArea         = json["nombre_area"];
//       nombreSubArea      = json["nombre_sub_area"];
//       nombreSucursal     = json["nombre_sucursal"];
//       nombreCliente      = json["nombre_cliente"];
//       aliasSede          = json["alias_sede"];
//       codigoTipoServicio = json["codigo_tipo_servicio"];
//       nombrePuesto       = json["nombre_puesto"];
//     }
// }
