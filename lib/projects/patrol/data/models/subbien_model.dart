import 'dart:convert';
List<SubBienDbModel> autorizanteDbModelFromJson(String str) => List<SubBienDbModel>.from(json.decode(str).map((x) => SubBienDbModel.fromJson(x)));

class SubBienesDbModel{

  List<SubBienDbModel> items = [];
  SubBienesDbModel();

  SubBienesDbModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final subbien = SubBienDbModel.fromJson(item);
      items.add(subbien);
    }
  }

}

class SubBienDbModel {
    SubBienDbModel({
        this.codigoSubBien,
        this.nombre,
    });

    int? codigoSubBien;
    String? nombre;

    SubBienDbModel.fromJson(Map<String, dynamic> json) {
      codigoSubBien = json["codigo_subbien"];
      nombre = json["nombre"];
    }

}
