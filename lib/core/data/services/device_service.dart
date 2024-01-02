import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/domain/models/device_information_provider.dart';
import 'package:solgis/core/domain/models/device_model.dart';
import 'package:solgis/core/global/environment.dart';

class DeviceService{

  //PETICION POST
  Future<DeviceResponseModel?> sendDataDevice( DeviceInformationModel dispositivo, String number, String? token )async{
    
    String uncodePath = 'api/auth/device/';
    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath
    );

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode( <String, dynamic> {
        'serial'     : dispositivo.serialNumber ?? '',
        'hardware'   : dispositivo.hardware ?? '',
        'modelo'     : dispositivo.model ?? '',
        'fabricante' : dispositivo.brand ?? '',
        'version_api': dispositivo.release ?? '',
        'numero'     : number ,
        'sdk'        : dispositivo.sdkInt ?? '',
        'incremental': dispositivo.incremental ?? '',
        'dispositivo': dispositivo.device ?? '',
        'id'         : dispositivo.id ?? '',
        'id_fb'      : token ?? '',
      })
    );

    return DeviceResponseModel.fromJson( json.decode( response.body ) );

  }

  Future<int> checkAuthDevice(String serial) async {
    final url = Uri.http(
      Environment.apiCargoUrl, 
      'api/auth/device/', 
      {
        'serial': serial
      }
    );

    final response = await http.get(
      url, 
      headers: {
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    final estadoData = json.decode(response.body);
    return estadoData['estado'];

  }

}