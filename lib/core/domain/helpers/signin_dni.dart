// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/signin_service.dart';
import 'package:solgis/core/device/preferences.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/home_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/pages/home/home_page.dart';

Future<void>signinWithDNI( BuildContext context, String dni )async{

  final personProvider = Provider.of<PersonAuthProvider>(context, listen:false);
  final homeProvider = Provider.of<HomeProvider>(context, listen:false);
  homeProvider.isLoading = true;
  final signinService = SignInService();
  final personAuth = await signinService.signInDNI(dni);

  if(personAuth == null){
    homeProvider.isLoading = false;
    FocusScope.of(context).unfocus();
    return showSnackBarAwesome(context, 'Atencion', 'El documento no corresponde a un agente o supervisor', ContentType.failure);
  } 

  personProvider.personauth = personAuth;

  Preferences.codigoPersonal = personAuth.codigoPersonal?? '';
  Preferences.dni            = personAuth.dni?? '';
  Preferences.pNombre        = personAuth.pNombre?? '';
  Preferences.sNombre        = personAuth.sNombre?? '';
  Preferences.pApellido      = personAuth.pApellido?? '';
  Preferences.sApellido      = personAuth.sApellido?? '';
  Preferences.cargo          = personAuth.cargo?? '';
  Preferences.codtipoUsuario = personAuth.codTipoUsuario ?? 0;

  Preferences.isAuthenticated = true;

  openHomePage(context);

  homeProvider.controller.text = '';
  homeProvider.isLoading = false;
  homeProvider.isdragged = false;

}

void openHomePage(BuildContext context) {

  final newRoute = PageRouteBuilder<dynamic>(
    pageBuilder: (context, animation, secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: const HomePage(),
      );
    },
  );
  Navigator.pushAndRemoveUntil(context, newRoute, ModalRoute.withName(''));

}