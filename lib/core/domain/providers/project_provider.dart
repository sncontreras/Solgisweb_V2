import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solgis/core/domain/models/project_model_qa.dart';
import 'package:solgis/core/global/environment.dart';


class ProjectProvider extends ChangeNotifier{

  List<ProjectModel> projects = [];

  // //METODOS PARA LA VARIABLE PERSONA AUTH
  // List<ProjectModel> get projects => _projects;

  // set projects( List<ProjectModel> valor ){
  //   _projects = valor;
  //   notifyListeners();
  // }

  //PETICION GET
  Future<List<ProjectModel>> getAppsAllowed( int codGrupoUsuarios ) async {

    String uncodePath = 'api/auth/device/apps/';

    final url = Uri.http( 
      Environment.apiCargoUrl,
      uncodePath, {
      // ignore: unnecessary_brace_in_string_interps
      'codGrupoUsuarios' : '${codGrupoUsuarios}',
    });

    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
      }
    );

    final decodedData = json.decode(utf8.decode(resp.bodyBytes));
    // if( decodedData.length == 1 ) return null;
    final apps = ProjectsModel.fromJsonList(decodedData);

    projects = apps.items;

    return apps.items;

    // print(apps.items.length);


  }

}