import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solgis/projects/people/domain/models/tipos_personal_model.dart';
import 'package:solgis/core/global/environment.dart';


class TiposPersonalProvider{

  // final String _uncodePath = 'solgis/people/personal/tipos/';
  final String _uncodePath = 'api/person/type';

  final bool cargando = false;

  // peticion GET
  Future<List<TipoPersonalModel>> _procesarRespuestaGet(Uri url) async {

    final resp = await http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"}
    );

    if(resp.statusCode ==200){
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final tiposPersona = TiposPersonalModel.fromJsonList(decodedData);
      return tiposPersona.items;
    }

    return [];

  }

  //obtengo los tipos de personal
  Future<List<DropdownMenuItem<int>>> getTiposPersonal( String codCliente)async{

    List<DropdownMenuItem<int>> menuItems = [];

    final url = Uri.http( Environment.apiCargoUrl, _uncodePath, {
      'codCliente': codCliente,
    });

    final tipoPersonal = await _procesarRespuestaGet(url);

    for (var i=0; i<tipoPersonal.length; i++){
      DropdownMenuItem<int> item = DropdownMenuItem(value: int.parse(tipoPersonal[i].codigo!), child: Text(tipoPersonal[i].persona!));
      menuItems.add(item);
    }

    return menuItems;

  }

}