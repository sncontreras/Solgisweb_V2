import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/patrol/data/models/subbien_model.dart';

class SubBienService {

  final String _uncodePath = 'api/patrol/subbien/listar';

  //PETICION GET
  Future<List<SubBienDbModel>> _procesarRespuestaGet( Uri url )async{

    final response = await http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes)) ;
      final subbienes = SubBienesDbModel.fromJsonList(decodedData);
      return subbienes.items;
    }else{
      return[];
    }

  }

  //OBTENCION DE LOS BIENES
  Future<List<SubBienDbModel>> getSubBienes(String codBien)async{

    final url = Uri.http( Environment.apiCargoUrl, _uncodePath, {
      'codBien': codBien,
    });
    final subbienes = await _procesarRespuestaGet(url);
    return subbienes;
  }

}


