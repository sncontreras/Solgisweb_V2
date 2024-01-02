import 'dart:convert';

DatoAccesoMCargoModel datosAccesoMModelFromJson(String str) => DatoAccesoMCargoModel.fromJson(json.decode(str));

class DatosAccesoCargoModel {  
  List<DatoAccesoMCargoModel> items = [];
  DatosAccesoCargoModel();
  DatosAccesoCargoModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final datoAcceso = DatoAccesoMCargoModel.fromJson(item);
      items.add(datoAcceso);
    }
  }
}


class DatoAccesoMCargoModel {
    int? codigoDatosAcceso;
    int? codigoMovimiento;
    String? descripcion;
    DateTime? fechaCreacion;
    String? creadoPor;
    int? codTipoDatoAcceso;
    String? pathImage;

    DatoAccesoMCargoModel({
        this.codigoDatosAcceso,
        this.codigoMovimiento,
        this.descripcion,
        this.fechaCreacion,
        this.creadoPor,
        this.pathImage,
    });

    DatoAccesoMCargoModel.fromJson(Map<String, dynamic> json) {
      codigoDatosAcceso         = json["codigo_dato_acceso"];
      codigoMovimiento          = json["codigo_mov_peatonal"];
      descripcion               = json["descripcion"] ?? '';
      fechaCreacion             = DateTime.parse(json["fecha_creacion"]?? '');
      creadoPor                 = json["creado_por"]?? '';
      codTipoDatoAcceso         = json["cod_tipo_dato_acceso"]?? '';
      pathImage                 = json["pathImage"]?? '';
    }
}
