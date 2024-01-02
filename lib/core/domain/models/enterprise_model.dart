
// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:solgis/core/domain/entities/enterprise.dart';

class EnterprisesModel{
  List<EnterpriseModel> items = [];
  EnterprisesModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = EnterpriseModel.fromJson(item);
      items.add(cargo);
    }
  }
}
class EnterpriseModel extends Enterprise{
    EnterpriseModel({
      this.codigo,
      this.empresa,
      this.ruc,
      this.cliente,
    });

    int? codigo;
    String? empresa;
    String? ruc;
    String? cliente;


    EnterpriseModel.fromJson(Map<String, dynamic> json) {
        codigo = int.parse(json["codigo"]);
        empresa = json["empresa"];
        ruc = json["ruc"];
        cliente = json["cliente"];
    }

}
