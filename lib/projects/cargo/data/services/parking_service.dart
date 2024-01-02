import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/asigned_parking_model.dart';
import 'package:solgis/projects/cargo/data/models/parking_model.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class ParkingService{

  static Future<List<ParkingModel>> getParkingForYobel( String nroPlaca, String codServicio, String codCliente, String codPersonal ) async{

    const  String uncodePath = 'api/parking/owner/available/';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      {
        'placa': nroPlaca,
        'cod_servicio': codServicio,
        'codigo_cliente': codCliente,
        'codPersonal': codPersonal,
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
      final parkings = ParkingsModel.fromJsonList(decodedData);
      return parkings.items;
    }

    return [];

  }

  static Future<AsignedParkingModel?> getAsignedParkingFromEntry( BuildContext context, String codPersona, String codServicio ) async{

    final outProvider = Provider.of<SalidaAutorizadaProvider>(context, listen: false);

    const  String uncodePath = 'api/parking/vehicle/';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      {
        'codPersonal': codPersona,
        'cod_servicio': codServicio
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
      final asigParking = AsignedParkingModel.fromJson(decodedData);
      outProvider.asignedParking = asigParking;
      return asigParking; 
    }

    return null;

  }

  static Future<void> setReserverParking( int codDriver, int codParqueo, String nameParqueo, String creadoPor, String nroPlaca, String codCliente, int codServicio ) async {

    String uncodePath = 'api/parking/reserver';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'codDriver':      codDriver,
          'codParqueo':     codParqueo,
          'nameParqueo':    nameParqueo,
          'creadoPor':      creadoPor,
          'nroPlaca':       nroPlaca,
          'codigo_cliente': codCliente,
          'cod_servicio':   codServicio,
        }
      )
    );

    if( resp.statusCode == 200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      // ignore: avoid_print
      print(decodedData);
    }

  }

  static Future<void> setResetParking( int codDriver, int codParqueo, String nroPlaca, String codCliente, int codServicio ) async {

    String uncodePath = 'api/parking/reset';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'codDriver':      codDriver,
          'codParqueo':     codParqueo,
          'nroPlaca':       nroPlaca,
          'codigo_cliente': codCliente,
          'cod_servicio':   codServicio,
        }
      )
    );

    if( resp.statusCode == 200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      // ignore: avoid_print
      print(decodedData);
    }

  }

}