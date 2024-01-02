import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import  'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';

class PhotoCargoService{
  
  static Future uploadImageForm( BuildContext context, String pathImage, int codCampoForm, int codCargo, String descripcion) async{
    
    final url = Uri.parse('http://190.116.178.163:92/api/photo/cargo');
    final gProvider = Provider.of<GlobalProvider>(context, listen: false);
    File pictureFile = File.fromUri(Uri(path: pathImage));
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'File', 
      pictureFile.path,
      contentType: MediaType('image', 'jpg')
    );

    imageUploadRequest.fields['creadoPor']      = "CARGO_${gProvider.relationModel.codigoServicio}";
    imageUploadRequest.fields['codCliente']     = gProvider.relationModel.codigoCliente ?? '';
    imageUploadRequest.fields['codServicio']    = gProvider.relationModel.codigoServicio.toString();
    imageUploadRequest.fields['codCampoForm']   = codCampoForm.toString();
    imageUploadRequest.fields['codCargo']       = codCargo.toString();
    imageUploadRequest.fields['descripcion']    = descripcion.toString();
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    // ignore: avoid_print
    print(resp.body);

  }

  static Future<int> uploadImageMultiForm( BuildContext context, String pathImage, int codCampoForm, int codCargo, String descripcion ) async{

    final url = Uri.parse('http://190.116.178.163:92/api/photo/cargo/multi');
    final gProvider = Provider.of<GlobalProvider>(context, listen: false);
    File pictureFile = File.fromUri(Uri(path: pathImage));
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'File', 
      pictureFile.path,
      contentType: MediaType('image', 'jpg')
    );

    imageUploadRequest.fields['creadoPor'   ]   = "CARGO_${gProvider.relationModel.codigoServicio}";
    imageUploadRequest.fields['codCliente'  ]   = gProvider.relationModel.codigoCliente ?? '';
    imageUploadRequest.fields['codServicio' ]   = gProvider.relationModel.codigoServicio.toString();
    imageUploadRequest.fields['codCampoForm']   = codCampoForm.toString();
    imageUploadRequest.fields['codCargo']       = codCargo.toString();
    imageUploadRequest.fields['descripcion']    = descripcion.toString();
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    final decodedData = json.decode(resp.body);
    final codigo = decodedData["codigo"];

    return codigo;

  }


}