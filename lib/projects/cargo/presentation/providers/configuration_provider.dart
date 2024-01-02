import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/configuration_model.dart';
import 'package:solgis/projects/cargo/data/models/input_model.dart';
import 'package:solgis/projects/cargo/domain/entities/configuration.dart';

class ConfigProvider extends ChangeNotifier{

  Configuration? _configuration;
  List<InputModel>? _fieldCargaType;
  List<InputModel>?  _fieldCargaState;

  Configuration? get configuration => _configuration;

  Future init( String codeCustomer, String codeService, BuildContext context ) async {

    const String uncodePath = 'api/cargoconfig/lazy';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          "CodeCustomer" : codeCustomer ,
          "CodeService"  : codeService,
        }
      ),
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final config = ConfigurationModel.fromJson(decodedData);
      _configuration = config;
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

  Future getInputsForCargaType( String codeCargaType, String codeCustomer, String codeService ) async {

    const String uncodePath = 'api/field/';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,{
        "cod_tipo_carga": codeCargaType,
        "cod_cliente" :   codeCustomer,
        "cod_servicio":   codeService
      }
    );

    final response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final inputs      = InputsModel.fromJsonList(decodedData);
      _fieldCargaType   = inputs.items;
      notifyListeners();
    }

  }

  Future getInputsForCargaState( bool codeCargaState, String codeCustomer, String codeService ) async {

    const String uncodePath = 'api/field/carga/state';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,{
        "carga_state":  "$codeCargaState",
        "cod_cliente" : codeCustomer,
        "cod_servicio": codeService
      }
    );

    final response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final inputs = InputsModel.fromJsonList(decodedData);
      _fieldCargaState = inputs.items;
      notifyListeners();
    }

  }

  //Tipo de Carga
  List<InputModel>? get fieldCargaType => _fieldCargaType;

  //Estado de Carga
  List<InputModel>? get fieldCargaState => _fieldCargaState;

}