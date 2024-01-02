import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/people/domain/models/area_model.dart';

class AreaService{
  
  final String _uncodePath = 'api/area/';

  //PETICION GET
  Future<List<AreaDbModel>> _procesarRespuestaGet( Uri url )async{

    final response = await http.get(
      url,
      headers: {
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes)) ;
      final areas = AreasDBModel.fromJsonList(decodedData);
      return areas.items;
    }else{
      return[];
    }

  }

  //OBTENCION DE LAS AREAS
  Future<List<AreaDbModel>> getAreas(String codServicio, String codCliente)async{

    final url = Uri.http( 
      Environment.apiCargoUrl, 
      _uncodePath, {
      'idServicio': codServicio,
      'codCliente': codCliente,
      }
    );

    final areas = await _procesarRespuestaGet(url);
    return areas;
  }
}
