import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';
import 'package:solgis/projects/cargo/domain/services/tipo_carga_service.dart';

class CargaTypeService {
  static const String _uncodePath = 'api/cargatype/';

  //PETICION GET
  static Future<List<TipoCargaModel>> getCargaType(String codCliente,
      {bool isMaterial = false}) async {
    final url = Uri.http(Environment.apiCargoUrl, _uncodePath);
    int esmaterialint = 0;
    if (isMaterial) {
      esmaterialint = 1;
    }
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        "CustomerCode": codCliente,
        "isMaterial": esmaterialint
      }),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final cargos = TiposCargaModel.fromJsonList(decodedData);
      return cargos.items;
    }

    return [];
  }
}

//CLASE NO USADA
class HttpTiposCargaService extends ICargaTypeService {
  final String _uncodePath = 'solgis/cargo/tiposcarga/';

  @override
  Future<List<TipoCargaModel>> getTipoCarga({String? codCliente}) async {
    final url =
        Uri.http(Environment.apiUrl, _uncodePath, {'CodCliente': codCliente});

    final response = await http.get(url, headers: {
      'Content-Type': "application/json; charset=utf-8",
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final cargos = TiposCargaModel.fromJsonList(decodedData);
      return cargos.items;
    }

    return [];
  }
}
