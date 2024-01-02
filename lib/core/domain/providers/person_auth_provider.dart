// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:solgis/core/domain/models/login_credentials_repsonse.dart';
import 'package:solgis/core/domain/models/login_dni_response.dart';

enum AuthStatus{
  Authenticated,
  Unauthenticated,
}

class PersonAuthProvider extends ChangeNotifier{

  late LoginDniResponse personAuth = LoginDniResponse();
  late LoginCredentialsResponse credentialAuth = LoginCredentialsResponse();

  //ALL: SE AGREGARÁ LOS PERMISOS(ALCANCE Y ACCIONES) ADEMAS TAMBIEN LAS APPS DISPONIBLES (PENDIENTE)

  AuthStatus status = AuthStatus.Unauthenticated;
  //METODOS PARA LA VARIABLE STATUS 
  AuthStatus get getstatus => status;

  set setstatus(AuthStatus valor){
    status = valor;
    notifyListeners();
  }

  //METODOS PARA LA VARIABLE PERSONA AUTH
  LoginDniResponse get personauth => personAuth;

  set personauth(LoginDniResponse valor){
    personAuth = valor;
    notifyListeners();
  }

  //METODOS PARA LA VARIABLE USER AUTH
  LoginCredentialsResponse get credentialauth => credentialAuth;

  set credentialauth(LoginCredentialsResponse valor){
    credentialAuth = valor;
    notifyListeners();
  }

}