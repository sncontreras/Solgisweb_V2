import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/cargo/data/models/create_cargo_body.dart';
import 'package:solgis/projects/cargo/data/models/create_cargo_response.dart';

class CargoService{

  static Future<CreateCargoResponse?> createCargo( CreateCargoBody body )async{

    const  String uncodePath = 'api/movement/cargo';
    final url = Uri.http( Environment.apiCargoUrl, uncodePath );

    final resp = await http.post(

      url,
      headers:{
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      },

      body: jsonEncode(
        <String, dynamic>{
          'codTipoCarga': body.codTipoCarga,
          'alcoholimetro': (body.alcoholimetro == null ) ? false : body.alcoholimetro,
          'codCliente': body.codCliente,
          'codServicio': body.codServicio,
          'codMovPeatonal': body.codMovPeatonal,
          'codMovVehicular': body.codMovVehicular,
          'carreta': body.carreta,
          'carga': (body.carga == null ) ?true :body.carga,
          'idOrigen': body.idOrigen,
          'contenedor': body.contenedor,
          'codTContenedor': body.codTContenedor,
          'booking': body.booking,  
          'contrato': body.contrato,
          'codAutorizante': body.codAutorizante,
          'codMotivo': body.codMotivo,
          'codAreaAcceso': body.codAreaAcceso,
          'codOpLogis': body.codOpLogis,
          'creadoPor': body.creadoPor,     
          'guiaTransp': body.guiaTransp,
          'codMaterial': (body.codMaterial== null) ? 0 : body.codMaterial,
          'destino': (body.destino == null ) ? '' : body.destino,
          'tVehiculo': (body.tipoVehiculo == null) ? 0 : body.tipoVehiculo,
          'kilometraje': (body.kilometraje == null) ? '' : body.kilometraje,
        }
      )

    );

    if( resp.statusCode == 200 ){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes)) ;
      final createResponse = CreateCargoResponse.fromJson(decodedData);
      return createResponse;
    }else{
      return null;
    }

  }

}