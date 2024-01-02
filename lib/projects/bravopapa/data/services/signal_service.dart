import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/bravopapa/data/models/create_signal_body.dart';
import 'package:solgis/projects/bravopapa/data/models/create_signal_response.dart';

class SignalService {

  static Future<CreateSignalResponse?> sendSignal(
      CreateSignalBody body) async {
    const String uncodePath = 'api/senal/sendSenal';
    final url = Uri.http(Environment.apiCargoUrl, uncodePath);

    final resp = await http.post(url,
        headers: {
          'Content-Type': "application/json; charset=utf-8",
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'puesto': body.puesto,
          'numero': body.numero,
          'latitud': body.latitud,
          'longitud': body.longitud,
          'mensaje': body.mensaje,
        }));

    if (resp.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final createResponse = CreateSignalResponse.fromJson(decodedData);
      return createResponse;
    } else {
      return null;
    }
  }

}
