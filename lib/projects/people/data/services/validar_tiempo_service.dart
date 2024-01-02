import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/domain/models/person_validation_time_model.dart';


class ValidarTiempoService {

  final String _uncodePath = 'api/validation/person/time/';
  final bool cargando = false;
  late ConsultaModel consulta;

  Future<PersonValidationTimeModel> _procesarRespuestaGet(Uri url) async{

    final resp  = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset= utf-8",
      }
    );

    if(resp.statusCode ==200){
      final decodedData = json.decode(resp.body);
      final consulta = PersonValidationTimeModel.fromJson( decodedData);
      return consulta;
    }else{
      throw Exception('Error al cargar la Consulta');
    }

  }

  // METODO PARA LA CONSULTA 
  Future<PersonValidationTimeModel> getConsulta( String doc, String idServicio, int? codTrainning, String codCliente) async {
    final url = Uri.http(
      Environment.apiCargoUrl, 
      _uncodePath,{
        'doc': doc,
        'idServicio' : idServicio,
        'codEmpresaTrainning': "${codTrainning ?? 0}",
        'codCliente': codCliente,
      }
    );
    final consulta = await _procesarRespuestaGet(url);
    return consulta;
  }

}