import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/domain/consulta_model_cargo.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';


class ConsultaProviderCargo {

  //final String _uncodePath = 'solgis/people/detalle-personal/';
  final bool cargando = false;
  late ConsultaModel consulta;

  //SUBMETODO PARA PROCESAR LA PETICION GET
  Future<ConsultaModelCargo> _procesarRespuestaGet(Uri url) async{
    final resp  = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset= utf-8",
      }
    );
    if(resp.statusCode ==200){
      final decodedData = json.decode(resp.body);
      final consulta = ConsultaModelCargo.fromJson( decodedData );
      return consulta;
    }else{
      throw Exception('Error al cargar la Consulta');
    }
  }

  // METODO PARA LA CONSULTA 
  Future<ConsultaModelCargo>  getConsulta(String placa, String idServicio)async{
    const String uncodePath = 'api/movement/cargo/detail/';

    final url = Uri.http(Environment.apiCargoUrl, uncodePath,{
      'placa': placa,
      'idServicio' : idServicio,
    });
    final consulta = await _procesarRespuestaGet(url);
    return consulta;
  }

}