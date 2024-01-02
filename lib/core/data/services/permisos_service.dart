import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:solgis/core/domain/models/permisos_model.dart';
import 'package:solgis/core/global/environment.dart';


//CLASE QUE NO SE USA
class PermisosService{

  static const String _uncodePath = 'solgis/usuario/permisos/';

  // PETICION GET
  static Future<List<PermisoModel>> getPermisos(int codTipoUsuario)async{

    final url = Uri.http(
      Environment.apiUrl, 
      _uncodePath,
      {'codTipoUsuario': codTipoUsuario.toString()}
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
      final permisos    = PermisosModel.fromJsonList(decodedData);
      
      return permisos.items;
    }

    return [];

  }
}