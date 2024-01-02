import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/people/domain/models/datos_acceso_movimiento_model.dart';
import 'package:solgis/projects/people/domain/models/datos_acceso_salida_model.dart';

class DatosAccesoService{

  //final String _uncodePath = 'solgis/people/datos_acceso/';
  final String _uncodePath = 'api/movement/accessData/';

  Future<List<DatoAccesoMModel>?> getDatosAccesosMovimiento(int tipoMovimiento, int codServicio, String? documento) async {
    final url = Uri.http( 
      Environment.apiCargoUrl, 
      _uncodePath,{
        'tipo_movimiento' : tipoMovimiento.toString(),
        'codigo_servicio' : codServicio.toString(),
        'documento' : documento.toString(),
      }
    );

    final resp = await http.get(
      url,
      headers: { HttpHeaders.contentTypeHeader: "application/json; charset= utf-8"}
    );

    if(resp.statusCode == 200){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final consulta = DatosAccesoModel.fromJsonList(decodedData);
      return consulta.items;
    }

    return null;

  }

  Future<DatosAccesoSalidaModel?> getDatosAccesoSalida(String codServicio, String documento)async{

    String uncodePath = 'solgis/people/datos_acceso/salida/';

    final url = Uri.http( 
      Environment.apiUrl, 
      uncodePath,{
        'codServicio' : codServicio,
        'documento' : documento,
      }
    );

    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset= utf-8",
      }
    );

    if(resp.statusCode == 200){
      final decodedData = json.decode(resp.body);
      final consulta = DatosAccesoSalidaModel.fromJson(decodedData);
      return consulta;
    }

    return null;
  }

  Future<int?> registerDatosAcceso(String codServicio, int codMov, String descripcion, String creadoPor, String codTipoDatoAcceso) async {

    final url = Uri.http(
      Environment.apiCargoUrl, 
      _uncodePath
    );

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'cod_servicio'          : codServicio,
          'cod_mov_peatonal'      : '$codMov',
          'descripcion'           : descripcion,
          'creado_por'            : creadoPor,
          'cod_tipo_dato_acceso'  : codTipoDatoAcceso,
        }
      )
    );

    if(resp.statusCode == 200){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)); 
      return decodedData['codigo_dato_acceso'];
    }

    return null;
  }

}