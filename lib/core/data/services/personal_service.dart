import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import  'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/models/person_basic_information_model.dart';
import 'package:solgis/core/domain/models/person_validation_enterprise_model.dart';
import 'package:solgis/core/domain/models/register_person_model.dart';
import 'package:solgis/core/domain/models/register_person_response.dart';
import 'package:solgis/core/domain/models/validation_person_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/global/environment.dart';

class PersonalService{

  final bool cargando = false;

  //OBTENER TODA LA INFORMACION DE UN PERSONAL 
  static Future<ValidationPersonResponse> validarDOI(String? numero, String codigo, String tipoDoc, String codServicio) async {
    
    String uncodePath = 'api/validation/person/';

    final url = Uri.http( 
      Environment.apiCargoUrl,
      uncodePath, {
        'numero': numero,
        'codigo': codigo,
        'tipoDocumento': tipoDoc,
        'codigoServicio': codServicio,
      }
    );

    final resp = await http.get(
      url, 
      headers:{
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    final decodedData = json.decode(utf8.decode(resp.bodyBytes));
    ValidationPersonResponse responseModel = ValidationPersonResponse.fromJson(decodedData);
    return responseModel;

  }

  // REGISTRAR UNA PERSONA O CONDUCTOR
  static Future<RegisterPersonResponse> personRegister(BuildContext context, RegisterPersonModel bodyRequest) async {

    final globalProvider  = Provider.of<GlobalProvider>(context, listen: false).relationModel;
    String uncodePath     = 'api/person';
    final url             = Uri.http(Environment.apiCargoUrl, uncodePath);

    final body = jsonEncode({
      'codigo_personal': 0,
      'codigo_tipo_personal': bodyRequest.codigoTipoPersonal,
      'codigo_empresa': bodyRequest.codigoEmpresa,
      'codigo_tipo_documento': bodyRequest.codigoTipoDocumento,
      'codigo_cargo': bodyRequest.codigoCargo,
      'nombre1': bodyRequest.nombre1,
      'nombre2': bodyRequest.nombre2,
      'apellido1': bodyRequest.apellido1,
      'apellido2': bodyRequest.apellido2,
      'doc_personal': bodyRequest.docPersonal,
      'sexo': bodyRequest.sexo,
      'creado_por': bodyRequest.creadoPor,
      'nroLicense' : bodyRequest.nroLicense,
      'brevete': '',
      'es_autorizante': 0,
      'habilitado': 1,
      'tiene_foto': 0,
      'codigo_cliente_control': globalProvider.codigoCliente,
    });

    final resp = await http.post(
      url,
      headers: {
        'Content-Type': "application/json; charset=utf-8",
        'Accept': 'application/json'
      },
      body: body,
    );

    final decodedData = json.decode(resp.body);
    final consulta = RegisterPersonResponse.fromJson( decodedData );
    return consulta;

  }

  //SUBIR FOTO DEL PERSONAL AL SERVIDOR
  static Future<void> uploadPersonPhoto(File file, String nombre, String codServicio)async {

    final url = Uri.parse('http://190.116.178.163:92/api/personal/upload-photo-personal');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final filemultipart = await http.MultipartFile.fromPath(
      'file', 
      file.path,
      contentType: MediaType('image', 'jpg')
    );

    imageUploadRequest.fields['nombre'] = '$nombre.jpg';
    imageUploadRequest.fields['cod_servicio'] = codServicio;

    imageUploadRequest.files.add(filemultipart);
    final streamResponse = await imageUploadRequest.send();
    //print(streamResponse);
    // ignore: unused_local_variable
    final resp = await http.Response.fromStream(streamResponse);
    //print(resp);

  } 

  //SUBIR FOTO DEL PERSONAL AL SERVIDOR
  static Future<void> uploadLicensePhoto(String filePath, String creadoPor, String docPersona)async {

    final url = Uri.parse('http://190.116.178.163:92/api/photo/person/license');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final filemultipart = await http.MultipartFile.fromPath(
      'File', 
      filePath,
      contentType: MediaType('image', 'jpg')
    );

    imageUploadRequest.fields['CreadoPor'] = creadoPor;
    imageUploadRequest.fields['docPersona'] = docPersona;
    imageUploadRequest.files.add(filemultipart);
    final streamResponse = await imageUploadRequest.send();
    //print(streamResponse);
    // ignore: unused_local_variable
    final resp = await http.Response.fromStream(streamResponse);
    //print(resp);

  } 

  //OBTENER LA INFORMACION BASICA DE UN PERSONAL 
  static Future<PersonBasicInformationReponse> getpersInforBasic(String? documento, int codServicio) async {
    
    String uncodePath = 'api/person/basic';

    final url = Uri.http( 
      Environment.apiCargoUrl,
      uncodePath, {
        'documento': documento,
        'codServicio': codServicio.toString(),
      }
    );

    final resp = await http.get(
      url, 
      headers:{
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    final decodedData = json.decode(utf8.decode(resp.bodyBytes));
    PersonBasicInformationReponse responseModel = PersonBasicInformationReponse.fromJson(decodedData);
    return responseModel;

  }

  //OBETENER LAS EMPRESAS DONDE TIENE INDUCCION
  static Future<List<PersonValidationEnterpriseModel>> getEnterPriseInduction(String documento, int codServicio) async {

    String uncodePath = 'api/person/enterprise_induction';

    final url = Uri.http(
      Environment.apiCargoUrl,
      uncodePath, {
        'documento': documento,
        'codServicio': "$codServicio",
      }
    );

    final resp = await http.get(
      url, 
      headers:{
        HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8"
      }
    );

    final decodedData   = json.decode(utf8.decode(resp.bodyBytes));
    final responseModel = PersonValidationsEnterpriseModel.fromJsonList(decodedData);
    return responseModel.items;

  }

}