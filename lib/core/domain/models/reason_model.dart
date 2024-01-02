
// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:solgis/core/domain/entities/reason.dart';

class ReasonsModel{
  List<ReasonModel> items = [];
  ReasonsModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = ReasonModel.fromJson(item);
      items.add(cargo);
    }
  }
}
class ReasonModel extends Reason{
    ReasonModel({
        this.codigo,
        this.tipo,
    });

    String? codigo;
    String? tipo;

    ReasonModel.fromJson(Map<String, dynamic> json) {
        codigo = json["codigo"];
        tipo = json["tipo"];
    }

}
