/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/configuration_model.dart';
import 'package:solgis/projects/patrol/domain/tipos_foto_patrol.dart';

class CargarTipoFotosProvider extends ChangeNotifier{

  TipoFotosPatrol? _tiposFotosPatrol;

  TipoFotosPatrol? get tiposFotosPatrol => _tiposFotosPatrol;

  Future init( String codeBien, BuildContext context ) async {

    const String uncodePath = 'api/cargarfotospatrol/cargar';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          "CodigoBien"  : codeBien,
        }
      ),
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final config = ConfigurationModel.fromJson(decodedData);
      _tiposFotosPatrol = config;
      notifyListeners();
      return true;
    }else{
      // ignore: use_build_context_synchronously
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ( _ ) => AlertDialog(
          title: const Text("Informacion"),
          content: const Text('No existe configuracion del cargo con este servicio. \nPor favor contactarse con soporte'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              } , 
              child: const Text("Aceptar"),
            )
          ],
        ),
      );
    }
  }

}*/