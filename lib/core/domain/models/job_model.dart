
// ignore_for_file: overridden_fields, annotate_overrides

import 'package:solgis/core/domain/entities/job.dart';

class JobsModel{
  List<JobModel> items = [];
  JobsModel.fromJsonList( List<dynamic> jsonList ) {
    for ( var item in jsonList ){
      final cargo = JobModel.fromJson(item);
      items.add(cargo);
    }
  }
}

class JobModel extends Job{
  JobModel({
    required this.codigo,
    required this.cargo,
  });

  String? codigo;
  String? cargo;

  JobModel.fromJson(Map<String, dynamic> json) {
    codigo = json["codigo"];
    cargo = json["cargo"];
  }

}
