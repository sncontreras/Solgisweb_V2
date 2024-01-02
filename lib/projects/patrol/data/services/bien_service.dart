import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/patrol/data/models/bien_model.dart';
import 'package:solgis/projects/patrol/presentation/providers/registro_provider.dart';

class BienService {
  final String _uncodePath = 'api/patrol/bien/listar';

  //PETICION GET
  Future<List<BienDbModel>> _procesarRespuestaGet(Uri url) async {
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
    });

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final bienes = BienesDbModel.fromJsonList(decodedData);
      return bienes.items;
    } else {
      return [];
    }
  }

  //OBTENCION DE LOS BIENES
  Future<List<BienDbModel>> getBienes(BuildContext context, codCliente) async {
    final registroProvider =
        Provider.of<RegistroProvider>(context, listen: false);

    final url = Uri.http(Environment.apiCargoUrl, _uncodePath, {
      'codCliente': codCliente,
    });
    final bienes = await _procesarRespuestaGet(url);
    //registroProvider.subbienTemp = bienes[0].codigoBien!;
    return bienes;
  }
}
