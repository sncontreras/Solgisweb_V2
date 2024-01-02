import 'dart:convert';
List<ClienteModel> clienteModelFromJson(String str) => List<ClienteModel>.from(json.decode(str).map((x) => ClienteModel.fromJson(x)));

class ClientesModel {
  List<ClienteModel> items = [];

  ClientesModel();

  ClientesModel.fromJsonList( List<dynamic> jsonList ){
    for ( var item in jsonList ){
      final servicio = ClienteModel.fromJson(item);
      items.add(servicio);
    }
  }

}

class ClienteModel {
    ClienteModel({
        required this.codigo,
        required this.nombCliente,
    });
    String? codigo;
    String? nombCliente;
    ClienteModel.fromJson(Map<String, dynamic> json) {
        codigo = json["codigo"] ?? '';
        nombCliente = json["nomb_cliente"] ?? '';
    }
}


List<ServicioXClienteModel> servicioXClienteModelFromJson(String str) => List<ServicioXClienteModel>.from(json.decode(str).map((x) => ServicioXClienteModel.fromJson(x)));

class ServiciosXClienteModel {

  List<ServicioXClienteModel> items = [];

  ServiciosXClienteModel();

  ServiciosXClienteModel.fromJsonList( List<dynamic> jsonList ){
    for ( var item in jsonList ){
      final servicio = ServicioXClienteModel.fromJson(item);
      items.add(servicio);
    }
  }

}

class ServicioXClienteModel {
  ServicioXClienteModel({
      required this.codigo,
      required this.sede,
  });

  String? codigo;
  String? sede;
  int? codigoSubArea;
  String? nombreArea;
  String? nombreSubArea;
  String? nombreSucursal;
  String? aliasSede;
  int? codTipoServicio;

  ServicioXClienteModel.fromJson(Map<String, dynamic> json) {
    codigo           = json["codigo"] ?? '';
    sede             = json["sede"] ?? '';
    codigoSubArea    = json["codigo_sub_area"];
    nombreArea       = json["nombre_area"] ?? '';
    nombreSubArea    = json["nombre_sub_area"] ?? '';
    nombreSucursal   = json["nombre_sucursal"] ?? '';
    aliasSede        = json["alias_sede"] ?? '';
    codTipoServicio  = int.parse(json["codigo_tipo_servicio"]);
  }
}
