import 'dart:convert';
List<BienDbModel> autorizanteDbModelFromJson(String str) => List<BienDbModel>.from(json.decode(str).map((x) => BienDbModel.fromJson(x)));

class BienesDbModel{

  List<BienDbModel> items = [];
  BienesDbModel();

  BienesDbModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final bien = BienDbModel.fromJson(item);
      items.add(bien);
    }
  }

}

class BienDbModel {
    BienDbModel({
        this.codigoBien,
        this.nombre,
    });

    int? codigoBien;
    String? nombre;

    BienDbModel.fromJson(Map<String, dynamic> json) {
      codigoBien = json["codigo_bien"];
      nombre = json["nombre"];
    }

}
