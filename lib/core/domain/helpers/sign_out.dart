import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/device/preferences.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/home_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/widgets/initialized_widget.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';

Future<void>signOut(BuildContext context)async {

  final personProvider = Provider.of<PersonAuthProvider>(context, listen:false);
  final gProvider      = Provider.of<GlobalProvider>(context, listen: false);
  final homeProvider   = Provider.of<HomeProvider>(context, listen:false);
  final personauth     = personProvider.personauth;
  final userauth       = personProvider.credentialauth;

  if( gProvider.relationModel.codigoPerfil == 1  || gProvider.relationModel.codigoPerfil == 2){

    homeProvider.isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    Preferences.codigoPersonal = personauth.codigoPersonal    = '';
    Preferences.pNombre        = personauth.pNombre           = '';
    Preferences.sNombre        = personauth.sNombre           = '';
    Preferences.pApellido      = personauth.pApellido         = '';
    Preferences.sApellido      = personauth.sApellido         = '';
    Preferences.cargo          = personauth.cargo             = '';
    Preferences.codtipoUsuario = personauth.codTipoUsuario    =  0 ;

    // ignore: use_build_context_synchronously
    showSnackBarAwesome(context, 'Atencion', 'Cerro Sesion Exitosamente', ContentType.success);

    // ignore: use_build_context_synchronously
    openLoginPage(context);
    homeProvider.isLoading = false;
    Preferences.isAuthenticated = false;

  }else{

    homeProvider.isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    Preferences.codigoPersonal = '';
    userauth.codigoUsuario     = 0;
    Preferences.dni            = userauth.documento         = '';
    Preferences.pNombre        = userauth.nombres           = '';
    Preferences.sNombre        = '';
    Preferences.pApellido      = userauth.apellidos         = '';
    Preferences.sApellido      = '';
    Preferences.cargo          = '';
    Preferences.codtipoUsuario = 0;
    userauth.codigoTipoUsuario = 0; 
    Preferences.aliasSede      = '';

    // ignore: use_build_context_synchronously
    showSnackBarAwesome(context, 'Atencion', 'Cerro Sesion Exitosamente', ContentType.success);

    // ignore: use_build_context_synchronously
    openLoginPage(context);
    homeProvider.isLoading = false;
    Preferences.isAuthenticated = false;

  }

}

void openLoginPage(BuildContext context) {
  final newRoute = PageRouteBuilder<dynamic>(
    transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (context, animation, secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: const InitializedWidget(),
      );
    },
  );
  Navigator.pushAndRemoveUntil(context, newRoute, ModalRoute.withName(''));

}