// ignore_for_file: must_be_immutable, overridden_fields
/*
import 'package:solgis/projects/patrol/domain/tipo_foto.dart';

class TipoFotooModel{
  List<TipoFotoModel> items = [];
  TipoFotooModel.fromJsonList( List<dynamic>? jsonList ) {
    if( jsonList != null){
      for ( var item in jsonList ){
        final cargo = TipoFotoModel.fromJson(item);
        items.add(cargo);
      }
    }
  }
}

class TipoFotoModel extends TipoFoto{
  
  TipoFotoModel({
    super.codeTipoFoto, 
    super.name
  });

  @override
  String? codeTipoFoto;

  @override
  String? name;

  TipoFotoModel.fromJson(Map<String, dynamic> json) {
    codeTipoFoto   = json["code_tipofoto"].toString();
    name = json["name"];
  }

}*/