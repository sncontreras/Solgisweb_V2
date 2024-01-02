import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solgis/projects/people/domain/models/cargo_model.dart';
import 'package:solgis/core/global/environment.dart';

//CLASE NO USADA
class CargosProvider {

  // final String _uncodePath = 'solgis/people/cargos/';
  final String _uncodePath  = "api/job/";
  final bool cargando = false;

  // peticion GET
  Future<List<CargoModel>> _procesarRespuestaGet(Uri url) async {

    final resp = await http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"}
    );

    if(resp.statusCode ==200){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final empresas = CargosModel.fromJsonList(decodedData);
      return empresas.items;
    }

    return [];

  }

  //obtengo los cargos
  Future<List<DropdownMenuItem<int>>> getCargos(String cargo, String codCliente)async{

    List<DropdownMenuItem<int>> menuItems = [];

    final url = Uri.http( 
      Environment.apiCargoUrl, 
      _uncodePath, {
        'cargo': cargo,
        'cod_cliente': codCliente,
      }
    );

    final cargos = await _procesarRespuestaGet(url);

    for (var i=0; i<cargos.length; i++) {
      DropdownMenuItem<int> item = DropdownMenuItem(value: int.parse(cargos[i].codigo!), child: Text(cargos[i].cargo!));
      menuItems.add(item);
    }

    return menuItems;

  }

}