import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/signin_service.dart';
import 'package:solgis/core/device/preferences.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/home_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/pages/home/home_page.dart';


Future<void> signInWithCredentials(BuildContext context, String user, String pass) async{
  
  final personProvider = Provider.of<PersonAuthProvider>(context, listen:false);
  final homeProvider = Provider.of<HomeProvider>(context, listen:false);

  if( user == '' ) return showSnackBarAwesome(context, 'Atencion', 'Falta el usuario'   , ContentType.failure );
  if( pass == '' ) return showSnackBarAwesome(context, 'Atencion', 'Falta la contraseña', ContentType.failure );

  homeProvider.isLoading = true;
  final signinService = SignInService();
  final userAuth= await signinService.signInCredentials( user, pass );

  // ignore: use_build_context_synchronously
  FocusScope.of(context).unfocus();

  if( userAuth == null ){

    homeProvider.isLoading = false;
    // ignore: use_build_context_synchronously
    return showSnackBarAwesome(context, 'Atencion', 'Las credenciales son incorrecta', ContentType.failure);

  }

  personProvider.credentialAuth =  userAuth;

  Preferences.codigoPersonal    = userAuth.codigoUsuario.toString();
  Preferences.dni               = userAuth.documento!;
  Preferences.pNombre           = userAuth.nombres!;
  Preferences.sNombre           = '';
  Preferences.pApellido         = userAuth.apellidos!;
  Preferences.sApellido         = '';
  Preferences.cargo             = 'user';
  Preferences.codtipoUsuario    = userAuth.codigoTipoUsuario!;
  Preferences.isAuthenticated = true;

  // ignore: use_build_context_synchronously
  openHomePage(context);


  homeProvider.userController.text = '';
  homeProvider.passController.text = '';
  homeProvider.isLoading = false;
  homeProvider.isdragged = false;
}

void openHomePage(BuildContext context){
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
