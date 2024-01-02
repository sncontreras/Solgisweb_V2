import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/detail_movimiento_cargo_model.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';


class DetailMovimientoCargoService {

  //final String _uncodePath = 'solgis/people/detalle-personal/';
  final bool cargando = false;
  late ConsultaModel consulta;

  //SUBMETODO PARA PROCESAR LA PETICION GET
  Future<DetailMovimientoCargoModel> _procesarRespuestaGet(Uri url) async{
    final resp  = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset= utf-8",
      }
    );
    if(resp.statusCode ==200){
      final decodedData = json.decode(resp.body);
      final consulta = DetailMovimientoCargoModel.fromJson( decodedData );
      return consulta;
    }else{
      throw Exception('Error al cargar la Consulta');
    }
  }

  // METODO PARA LA CONSULTA 
  Future<DetailMovimientoCargoModel>  getConsulta(String placa, String idServicio, String codMovimiento)async{
    const String uncodePath = 'api/movement/cargo/movimiento/detail/';

    final url = Uri.http(Environment.apiCargoUrl, uncodePath,{
      'placa': placa,
      'idServicio' : idServicio,
      'codigoMovimiento': codMovimiento,
    });
    final consulta = await _procesarRespuestaGet(url);
    return consulta;
  }

}