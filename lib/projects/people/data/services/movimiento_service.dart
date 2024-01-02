import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/people/data/services/datos_acceso_movimiento_service.dart';
import 'package:solgis/projects/people/data/services/foto_acceso_service.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/domain/models/movimiento_model.dart';

class MovimientosProvider extends ChangeNotifier {
  // ignore: unused_field
  final String _uncodePath = 'solgis/people/movimientos/';
  final bool cargando = false;
  File? pictureFile;
  List<MovimientoModel> movimientosTotalesSelected = [];
  String tipoSeleccionado = 'todos';
  int movimientosContador = 0;
  final datosAccesoService = DatosAccesoService();

  int get getmovimientosContador => movimientosContador;

  //PETICION GET
  Future<List<MovimientoModel>> _procesarRespuestaGet(Uri url) async {
    final resp = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
    });
    final decodedData = json.decode(utf8.decode(resp.bodyBytes));
    final movimientos = MovimientosModel.fromJsonList(decodedData);
    return movimientos.items;
  }

  //PETICION POST ---
  Future<MovimientoResponseModel?> _procesarRespuestaPost(
      BuildContext context, Uri url, ConsultaModel consulta) async {
    // ignore: unused_local_variable
    final authProvider =
        Provider.of<PersonAuthProvider>(context, listen: false);
    final gProvider = Provider.of<GlobalProvider>(context, listen: false);

    final resp = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'codigo_mov_peatonal': '${0}',
        'codigo_personal': '${consulta.codigoPersona}',
        'codigo_servicio': '${consulta.codigoServicio}',
        'codigo_tipo_movimiento': '${consulta.codigoMovSgt}',
        'codigo_tipo_motivo': '${consulta.codigoMotivo}', //DINAMICO NO ESTATICO
        'codigo_empresa': '${consulta.codigoEmpresa}',
        'codigo_tipo_carga': null,
        'es_vehicular': 0,
        'autorizado_por':
            '${consulta.codigoAutorizante}', //DINAMICO Y NO ESTATICO
        'codigo_conductor': null,
        'codigo_carreta': null,
        'codigo_area': '${consulta.codigoArea}', //DINAMICO Y NO ESTATICO
        'creado_por': "PEOPLE_${gProvider.relationModel.numberDevice}",
        // 'creado_por': (authProvider.credentialAuth.documento == null)
        //     ? "PEOPLE_${authProvider.personauth.dni}"
        //     : "PEOPLE_${authProvider.credentialAuth.documento}",
        'parqueo': null
      }),
    );

    if (resp.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(resp.bodyBytes));
      final movResponse = MovimientoResponseModel.fromJson(decodedData);
      return movResponse;
    }

    return null;
  }

  //OBTENER LOS MOVIMIENTOS
  Future<List<MovimientoModel>> getMovimientos(
      String idServicio, String tipoMovimiento,
      {String tipoPersonal = "0"}) async {
    const String uncodePath = 'api/movement/people/';

    final url = Uri.http(Environment.apiCargoUrl, uncodePath, {
      'tipoMovimiento': tipoMovimiento,
      'idServicio': idServicio,
      'tipoPersonal': tipoPersonal,
    });

    final movimientos = await _procesarRespuestaGet(url);
    movimientosContador = movimientos.length;
    
    notifyListeners();
    if (tipoPersonal == '0') movimientosTotalesSelected = [...movimientos];
    return movimientos;
  }

  //CONSULTAR UN MOVIMIENTO
  Future<List<MovimientoModel>> getSearchMovimientos(String query) async {
    final List<MovimientoModel> movimientosFiltered = [];

    for (int i = 0; i < movimientosTotalesSelected.length; i++) {
      if (movimientosTotalesSelected[i].dni!.contains(query) ||
          movimientosTotalesSelected[i]
              .nombres!
              .contains(query.toUpperCase())) {
        movimientosFiltered.add(movimientosTotalesSelected[i]);
      }

      // if( movimientosTotalesSelected[i].dni!.contains(query)) movimientosFiltered.add(movimientosTotalesSelected[i]);
    }
    return movimientosFiltered;
  }

  //REGISTRAR UN MOVIMIENTO
  Future<MovimientoResponseModel?> registerMovimiento(
      BuildContext context, ConsultaModel consulta) async {
    const uncodePath = "api/movement/";
    final url = Uri.http(Environment.apiCargoUrl, uncodePath);
    final movimientoId = await _procesarRespuestaPost(context, url, consulta);
    return movimientoId;
  }

  //SUBIR LAS IMAGENES AL SERVIDOR DE SOLMAR CON EL API APISOLGISFOTOS.
  Future<int> obtenerCodigoUltimoMovimiento(
      String codServicio, String codPersonal) async {
    final url = Uri.http(Environment.apiCargoUrl, 'api/movement/people/last/', {
      'codServicio': codServicio,
      'codPersonal': codPersonal,
    });
    final resp = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
    });
    final decodedData = json.decode(utf8.decode(resp.bodyBytes));
    return decodedData['codigo_movimiento'];
  }

  Future uploadImage(String pathImage, String creadoPor, int datosAcceso,
      String codigoServicio, String codPersonal,
      {isCosco = false}) async {
    final codigoMovimiento =
        await obtenerCodigoUltimoMovimiento(codigoServicio, codPersonal);

    if (!isCosco) {
      pictureFile = File.fromUri(Uri(path: pathImage));
      pictureFile = await changeFileNameOnly(
          pictureFile!, '${codigoMovimiento.toString()}.jpg');
      // print('imprimiendo del pictureFile');
      // print(pictureFile!.path);

      if (pictureFile == null) return null;

      final url = Uri.parse('http://190.116.178.163:92/api/photo/upload-photo');
      final imageUploadRequest = http.MultipartRequest('POST', url);

      final file = await http.MultipartFile.fromPath('file', pictureFile!.path,
          contentType: MediaType('image', 'jpg'));

      imageUploadRequest.fields['creado_por'] = creadoPor;
      imageUploadRequest.fields['datoAcceso'] = datosAcceso.toString();
      imageUploadRequest.fields['cod_movimiento'] = codigoMovimiento.toString();
      imageUploadRequest.files.add(file);
      final streamResponse = await imageUploadRequest.send();
      // ignore: unused_local_variable
      final resp = await http.Response.fromStream(streamResponse);
    } else {
      await FotoAccesoService.updateFotoAcceso(
          codigoMovimiento.toString(), codPersonal, datosAcceso.toString());
    }
  }

  Future uploadImageQA(String pathImage, String creadoPor, int tipoDatosAcceso,
      String codigoServicio, String codCliente, int codDatoAcceso) async {
    pictureFile = File.fromUri(Uri(path: pathImage));

    if (pictureFile == null) return null;

    final url = Uri.parse('http://190.116.178.163:92/api/photo/upload-photo');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('File', pictureFile!.path,
        contentType: MediaType('image', 'jpg'));

    imageUploadRequest.fields['CreadoPor'] = creadoPor;
    imageUploadRequest.fields['TipoDatoAcceso'] = tipoDatosAcceso.toString();
    imageUploadRequest.fields['CodServicio'] = codigoServicio.toString();
    imageUploadRequest.fields['CodCliente'] = codCliente;
    imageUploadRequest.fields['CodDatoAcceso'] = codDatoAcceso.toString();
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    // ignore: unused_local_variable
    final resp = await http.Response.fromStream(streamResponse);
    // print(resp);
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  Future registerDatoAcceso(
      String datoAcceso,
      int codMovimiento,
      String creadoPor,
      int codTipoDatoAcceso,
      String codServicio,
      String codCliente,
      XFile? pathGuia) async {
    if (datoAcceso != '') {
      final codDatoAcceso = await datosAccesoService.registerDatosAcceso(
          codServicio,
          codMovimiento,
          datoAcceso,
          creadoPor,
          codTipoDatoAcceso.toString());
      if (pathGuia != null) {
        await uploadImageQA(pathGuia.path, creadoPor, codTipoDatoAcceso,
            codServicio, codCliente, codDatoAcceso!);
      }
    }
  }
}
