import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:solgis/core/errors/exceptions.dart';
import 'package:solgis/projects/cargo/data/datasource/remote/remote_data_source.dart';
import 'package:solgis/projects/cargo/data/models/movements_model.dart';
import 'package:solgis/projects/cargo/domain/entities/movement.dart';


class HttpMovementsDataSource implements IRemoteDataSource{

  HttpMovementsDataSource({
    String? url,
    Client? client,
  }) :  assert(url != null),
        assert(client != null),
        _url = url!,
        _client = client!;

  final String _url;
  final Client _client;

  @override
  Future<List<Movement>> getMovements( String? codTipoCarga, String? codServicio, String? tipoConsulta) async {

    try {

      String uncodePath = 'solgis/cargo/movimientos/';
      final uri = Uri.http(
        _url, 
        uncodePath,
        {
          "codTipoCarga": codTipoCarga,
          "codServicio":  codServicio,
          "tipoConsulta": tipoConsulta,
        }
      );

      final result =  await _client.get(uri);

      if( result.statusCode == 200 ){

        final decode = json.decode(result.body);
        final movements = MovementsModel.fromJsonList(decode);
        return movements.items;

      }else{
        throw ServerException();
      }

    } catch ( e ) {
      throw ServerException();
    }

  }

}