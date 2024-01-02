import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/people/domain/models/foto_acceso_model.dart';


class FotoAccesoService {

  static const String _uncodePath = 'solgis/people/fotos_acceso/';

  static Future<FotoAccesoModel?> getFotoAcceso(String fotoId)async{

    final url = Uri.http(
      Environment.apiUrl, 
      _uncodePath,
      {
        'foto_id': fotoId, 
      }
    );

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if(resp.statusCode == 200){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final fotoAcceso    = FotoAccesoModel.fromJson(decodedData);
      return fotoAcceso;
    }

    return null;

  }



  static Future updateFotoAcceso(String codigoMovimiento, String codPersonal, String datoAcceso)async{

    final url = Uri.http(
      Environment.apiUrl, 
      '${_uncodePath}copiar_foto/',
      {
        'cod_movimiento': codigoMovimiento, 
        'cod_personal': codPersonal,
        'datoAcceso': datoAcceso,
      }
    );

    // ignore: unused_local_variable
    final resp = await http.get(
      url,
      headers: {
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    // print(resp.body);

  }

} 