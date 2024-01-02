import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solgis/core/domain/models/device_model.dart';
import 'package:solgis/core/global/environment.dart';

class RelationDeviceService{

  final String _uncodePath = 'api/auth/device/config';

  //PETICION GET
  Future<RelacionDispositivoModel> getRelation(String serial)async{

    final url = Uri.http(
      Environment.apiCargoUrl, 
      _uncodePath,
      {
        'serial': serial,
      }
    );

    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
      }
    );

    final decodedData = json.decode(utf8.decode(resp.bodyBytes));
    final relation = RelacionDispositivoModel.fromJson(decodedData);
    return relation;

  }

}