import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/patrol/data/models/tiposfoto_model.dart';

class TiposFotoService {

  final String _uncodePath = 'api/patrol/tiposfoto/listar';

  //PETICION GET
  Future<List<TiposFotoDbModel>> _procesarRespuestaGet( Uri url )async{

    final response = await http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes)) ;
      final tiposfoto = TiposFotosDbModel.fromJsonList(decodedData);
      return tiposfoto.items;
    }else{
      return[];
    }

  }

  //OBTENCION DE LOS BIENES
  Future<List<TiposFotoDbModel>> getTiposFoto(String codBien)async{

    final url = Uri.http( Environment.apiCargoUrl, _uncodePath, {
      'codBien': codBien,
    });
    final tiposfoto = await _procesarRespuestaGet(url);
    return tiposfoto;
  }

}


