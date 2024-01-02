import 'dart:convert';
List<TiposFotoDbModel> autorizanteDbModelFromJson(String str) => List<TiposFotoDbModel>.from(json.decode(str).map((x) => TiposFotoDbModel.fromJson(x)));

class TiposFotosDbModel{

  List<TiposFotoDbModel> items = [];
  TiposFotosDbModel();

  TiposFotosDbModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final bien = TiposFotoDbModel.fromJson(item);
      items.add(bien);
    }
  }

}

class TiposFotoDbModel {
    TiposFotoDbModel({
        this.codigoBien,
        this.nombre,
    });

    int? codigoBien;
    String? nombre;

    TiposFotoDbModel.fromJson(Map<String, dynamic> json) {
      codigoBien = json["codigo_tipofoto"];
      nombre = json["nombre"];
    }

}
