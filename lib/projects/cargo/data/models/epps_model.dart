// ignore_for_file: must_be_immutable, overridden_fields

import 'package:solgis/projects/cargo/domain/entities/epps.dart';

class EppssModel{
  List<EppsModel> items = [];
  EppssModel.fromJsonList( List<dynamic>? jsonList ) {
    if( jsonList != null){
      for ( var item in jsonList ){
        final cargo = EppsModel.fromJson(item);
        items.add(cargo);
      }
    }
  }
}

class EppsModel extends Epps{
  
  EppsModel({
    super.codeEpps, 
    super.description
  });

  @override
  String? codeEpps;

  @override
  String? description;


  EppsModel.fromJson(Map<String, dynamic> json) {
    codeEpps   = json["code_epps"].toString();
    description = json["description"];
  }

}