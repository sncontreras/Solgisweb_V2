import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solgis/core/domain/models/login_credentials_repsonse.dart';
import 'package:solgis/core/domain/models/login_dni_response.dart';
import 'package:solgis/core/global/environment.dart';

class SignInService{

  final String _uncodePath = 'api/auth';

  //PETICION GET
  Future<LoginDniResponse?> signInDNI( String dni ) async {

    final url = Uri.http(
      Environment.apiCargoUrl, 
      _uncodePath, {
      'dni' : dni,
      }
    );

    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
      }
    );

    final decodedData = json.decode(utf8.decode(resp.bodyBytes));

    if( decodedData['codigo_personal'] == 0 ) return null;
    final signinwithdni = LoginDniResponse.fromJson(decodedData);
    return signinwithdni;

  }

  //PETICION POST CON USER Y PASSWORD
  Future<LoginCredentialsResponse?> signInCredentials( String user, String password ) async {

    final url = Uri.http(
      Environment.apiCargoUrl, 
      _uncodePath 
    );

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=utf-8',
      },
      body: jsonEncode(
        <String, String> {
        'usuario'     : user ,
        'clave'       : password ,
        }
      )
    );

    if(  response.statusCode == 500) return null;

    final decodedData = json.decode(utf8.decode(response.bodyBytes));
    final signinwithCredentials = LoginCredentialsResponse.fromJson( decodedData );
    return signinwithCredentials;

  }

}