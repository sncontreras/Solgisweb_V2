import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/domain/models/reason_model.dart';
import 'package:solgis/core/global/environment.dart';

class ReasonService {

  static const String _uncodePath = 'api/reason/';

  //PETICION GET
  static Future<List<ReasonModel>> _procesarRespuestaGet( Uri url )async{
    final response = await http.get( 
      url, 
      headers: {
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes)) ;
      final autorizantes = ReasonsModel.fromJsonList(decodedData);
      return autorizantes.items;
    }else{
      return[];
    }
  }

  //Obtencion de autorizantes
  static Future<List<ReasonModel>> getReasons(String codServicio, String idCliente)async{
    final url = Uri.http( Environment.apiCargoUrl, _uncodePath, {
      'idServicio': codServicio,
      'idCliente': idCliente,
    });
    final reasons = await _procesarRespuestaGet(url);
    return reasons;
  }

}


