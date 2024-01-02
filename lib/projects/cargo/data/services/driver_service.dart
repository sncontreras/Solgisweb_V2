import 'dart:convert';

import 'package:solgis/core/global/environment.dart';
import 'package:http/http.dart' as http;

class DriverService{


  static Future<bool> driverVerify( String dniPersonal, String codServicio, String codCliente ) async{

    const  String uncodePath = 'api/movement/';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      {
        'dni_personal': dniPersonal,
        'codigo_servicio': codServicio,
        'codigo_cliente': codCliente,
      }
    );


    final response = await http.get(
      url,
      headers:{
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return (decodedData['resultado'] == 1 ) ? true    : false;
    }

    return true;

  }

  static Future<String?> getDocumentInDriver( int codVeh, int codServicio) async {

    const  String uncodePath = 'api/driver/vehicle/verify/';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      <String, dynamic>{
        'codigo_vehiculo': codVeh.toString(),
        'CodigoServicio': codServicio.toString()
      }
    );

    final response = await http.get(
      url,
      headers:{
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return decodedData['document'];
    }
    return null;

  }

  static Future<String?> getDocumentInDriverForYobel( String nroPlaca, String codCliente ) async {

    const  String uncodePath = 'api/driver/vehicle/relation';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      <String, dynamic>{
        'placa': nroPlaca,
        'codCliente': codCliente
      }
    );

    final response = await http.get(
      url,
      headers:{
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      }
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return decodedData['document'];
    }
    return null;

  }


}