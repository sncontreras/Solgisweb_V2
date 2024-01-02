// ignore_for_file: overridden_fields, annotate_overrides

import 'package:solgis/projects/cargo/domain/entities/access_area.dart';

class AreasModel{
  List<AreaModel> items = [];
  AreasModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = AreaModel.fromJson(item);
      items.add(cargo);
    }
  }
}

// ignore: must_be_immutable
class AreaModel extends AccessArea{
  AreaModel({
    required this.codigo,
    required this.area,
  });

  String? codigo;
  String? area;

  AreaModel.fromJson(Map<String, dynamic> json) {
    codigo = json["codigo"];
    area = json["area"];
  }

}
