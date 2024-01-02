import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solgis/projects/people/domain/models/autorizante_model.dart';
import 'package:solgis/core/global/environment.dart';

class AutorizanteService {

  final String _uncodePath = 'api/authority';

  //PETICION GET
  Future<List<AutorizanteDbModel>> _procesarRespuestaGet( Uri url )async{

    final response = await http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes)) ;
      final autorizantes = AutorizantesDbModel.fromJsonList(decodedData);
      return autorizantes.items;
    }else{
      return[];
    }

  }

  //OBTENCION DE LOS AUTORIZANTES
  Future<List<AutorizanteDbModel>> getAutorizantes(String codServicio, String tipoPersonal)async{

    final url = Uri.http( Environment.apiCargoUrl, _uncodePath, {
      'idServicio': codServicio,
      'tipoPersonal': tipoPersonal,
    });
    final autorizantes = await _procesarRespuestaGet(url);
    return autorizantes;
  }

}


