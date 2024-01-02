import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/domain/models/area_model.dart';
import 'package:solgis/core/global/environment.dart';

class AccessAreaService {

  static const String _uncodePath = 'api/area/';

  //PETICION GET
  static Future<List<AreaModel>> _procesarRespuestaGet( Uri url )async{
    final response = await http.get( 
      url, 
      headers: {
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes)) ;
      final areas = AreasModel.fromJsonList(decodedData);
      return areas.items;
    }else{
      return[];
    }
  }

  //Obtencion de areas
  static Future<List<AreaModel>> getAreas(String idServicio, String codCliente)async{

    final url = Uri.http( 
      Environment.apiCargoUrl, 
      _uncodePath, {
      'idServicio': idServicio,
      'codCliente': codCliente,
    });
    final areas = await _procesarRespuestaGet(url);
    return areas;
  }

}