import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/people/domain/models/cliente_model.dart';

class ClienteService {
  final String _uncodePath = 'api/customer';

  //obtengo todos los clientes del multicontrol.
  Future<List<ClienteModel>> getClientes(String entrada) async {
    final url = Uri.http(Environment.apiCargoUrl, '$_uncodePath/', {
      'entrada': entrada,
    });

    final resp = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
    });

    if (resp.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final clientes = ClientesModel.fromJsonList(decodedData);
      return clientes.items;
    }
    return [];
  }

  //obtengo los servicios de un cliente
  Future<List<ServicioXClienteModel>> getServiciosXCliente(
      String codCliente) async {
    final url = Uri.http(Environment.apiCargoUrl, '$_uncodePath/services/', {
      'codCliente': codCliente,
    });

    final resp = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
    });

    if (resp.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final servicios = ServiciosXClienteModel.fromJsonList(decodedData);
      return servicios.items;
    }
    return [];
  }
}
