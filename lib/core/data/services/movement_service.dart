import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/models/entry_lazy_response.dart';
import 'package:solgis/core/domain/models/movement_body_model.dart';
import 'package:solgis/core/domain/models/movement_epps_body.dart';
import 'package:solgis/core/domain/models/movement_multi_body.dart';
import 'package:solgis/core/domain/models/movement_response_model.dart';
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class MovementService{

  static Future<MovementResponse?> registerMovement( MovementBody body ) async {
    
    String uncodePath = 'api/movement/';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'codigo_mov_peatonal': body.codigoMovPeatonal,
          'codigo_personal': body.codigoPersonal,
          'codigo_servicio': body.codigoServicio,
          'codigo_tipo_movimiento': body.codigoTipoMovimiento,
          'codigo_tipo_motivo': body.codigoTipoMotivo,
          'codigo_empresa': body.codigoEmpresa,
          'codigo_tipo_carga': body.codigoTipoCarga,
          'es_vehicular': body.esVehicular,
          'autorizado_por': body.autorizadoPor,
          'codigo_conductor': body.codigoConductor,
          'codigo_carreta': body.codigoCarreta,
          'codigo_area': body.codigoArea,
          'creado_por': body.creadoPor,
          'parqueo': body.parqueo
        }
      )
    );

    if( resp.statusCode == 200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      final movementResponse = MovementResponse.fromJson(decodedData);
      //print("${movementResponse.transaccion}, ${movementResponse.codMovCreado}");
      return movementResponse;
    }else{
      return null;
    }

  }

  static Future<int> checkDriver( String dni, String codServicio, String codCliente) async {

    String uncodePath = 'api/movement/';

    final url = Uri.http(
      Environment.apiCargoUrl, 
      uncodePath,
      { 
        'dni_personal' : dni,
        'codigo_servicio': codServicio,
        'codigo_cliente': codCliente,
      }
    );

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if( resp.statusCode == 200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      return decodedData["resultado"];
    }
    return -1;

  }

  static Future<void> registerEpps( MovementEppsBody body ) async {

    String uncodePath = 'api/movement/epps';

    final url = Uri.http(
      Environment.apiCargoUrl,
      uncodePath 
    );

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'codCargo':    body.codCargo,
          'codCliente':  body.codCliente,
          'codServicio': body.codServicio,
          'creadoPor':   body.creadoPor,
          'epps':        body.codeEpps
        }
      )
    );

    if( resp.statusCode == 200 ){
      // ignore: unused_local_variable
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      //print(decodedData);
    }

  }

  static Future<void> registerMulti( MovementMultiBody body ) async {

    String uncodePath = 'api/movement/multi';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'codCargo':    body.codCargo,
          'codCliente':  body.codCliente,
          'codServicio': body.codServicio,
          'creadoPor':   body.creadoPor,
          'multi':       body.multi
        }
      )
    );

    if( resp.statusCode == 200 ){
      // ignore: unused_local_variable
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      //print(decodedData);
    }

  }

  static Future<void> getLazyEntry( BuildContext context,  int codServicio, int codEntity ) async {

    final salidaProvider = Provider.of<SalidaAutorizadaProvider>(context, listen: false);
    String uncodePath = 'api/movement/entry/lazy';

    final url = Uri.http(
      Environment.apiCargoUrl,
      uncodePath,
      <String, dynamic>{ 
        'codServicio' : codServicio.toString(),
        'codEntity': codEntity.toString()
      }
    );

    final resp = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if( resp.statusCode == 200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      final decoded = EntryLazyResponse.fromJson(decodedData);
      salidaProvider.lazyResponse = decoded;
    }else{
      salidaProvider.lazyResponse = null;
    }
  }

}