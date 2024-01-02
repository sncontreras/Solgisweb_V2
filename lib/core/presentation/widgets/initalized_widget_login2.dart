import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/device/preferences.dart';
import 'package:solgis/core/domain/helpers/send_data_device.dart';
import 'package:solgis/core/domain/models/device_model.dart';
import 'package:solgis/core/domain/models/login_credentials_repsonse.dart';
import 'package:solgis/core/domain/models/login_dni_response.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/pages/pages.dart';

class InitializedWidgetAuth2 extends StatefulWidget{
  const InitializedWidgetAuth2({super.key});

  @override
  State<InitializedWidgetAuth2> createState() => _InitializedWidgetAuth2State();
}

class _InitializedWidgetAuth2State extends State<InitializedWidgetAuth2> {

  late RelacionDispositivoModel relacion = RelacionDispositivoModel();

  @override
  void initState() {
    _initStateDevice();
    super.initState();
  }

  _initStateDevice() async{
    final configuracionPanel = await getConfiguracionPanel();
    relacion  = configuracionPanel;
    setState( () {} );
  }

  @override
  Widget build(BuildContext context) {

    final personAuthProvider = Provider.of<PersonAuthProvider>(context);

    final gProvider = Provider.of<GlobalProvider>(context, listen:false);

    if(relacion.codigoDispositivo != null){

      gProvider.relationModel = relacion;

      //ASIGNACION DE VARIABLES PARA EL SHARED PREFERENCES
      Preferences.codDispositivo    = gProvider.relationmodel.codigoDispositivo!;
      Preferences.codServicio       = gProvider.relationmodel.codigoServicio.toString();
      Preferences.codCliente        = gProvider.relationmodel.codigoCliente!;
      Preferences.codSubArea        = gProvider.relationmodel.codigoSubArea!;
      Preferences.nombreArea        = gProvider.relationmodel.nombreArea!;
      Preferences.nombreSubArea     = gProvider.relationmodel.nombreSubArea!; 
      Preferences.nombreSucursal    = gProvider.relationmodel.nombreSucursal!;
      Preferences.nombreCliente     = gProvider.relationmodel.nombreCliente!;
      Preferences.aliasSede         = gProvider.relationmodel.aliasSede;
      Preferences.codTipoServicio   = gProvider.relationmodel.codigoTipoServicio!;
      Preferences.codPuesto         = gProvider.relationmodel.codigoPuesto!;
      Preferences.nombrePuesto      = gProvider.relationmodel.nombrePuesto!;
      Preferences.codPerfil         = gProvider.relationmodel.codigoPerfil!;

      if( Preferences.isAuthenticated ){

        personAuthProvider.status = AuthStatus.Authenticated; 
        final personaLogeada      = LoginDniResponse();
        final userLogeado         = LoginCredentialsResponse();

        if( gProvider.relationmodel.codigoPerfil == 1 || gProvider.relationmodel.codigoPerfil == 2 ){

          if( Preferences.codtipoUsuario == 1 || Preferences.codtipoUsuario == 2 ){

            personaLogeada.codigoPersonal  = Preferences.codigoPersonal;
            personaLogeada.dni             = Preferences.dni;
            personaLogeada.pNombre         = Preferences.pNombre;
            personaLogeada.sNombre         = Preferences.sNombre;
            personaLogeada.pApellido       = Preferences.pApellido;
            personaLogeada.sApellido       = Preferences.sApellido;
            personaLogeada.cargo           = Preferences.cargo;
            personaLogeada.codTipoUsuario  = Preferences.codtipoUsuario;
            personAuthProvider.personAuth  = personaLogeada;

          }else{

            Preferences.limpiarPreferences();
            personAuthProvider.status = AuthStatus.Unauthenticated;

          }

        } else {

          if ( Preferences.codtipoUsuario == 3 || Preferences.codtipoUsuario == 4 ){

            userLogeado.codigoUsuario           = int.parse(Preferences.codigoPersonal);
            userLogeado.documento               = Preferences.dni;
            userLogeado.nombres                 = Preferences.pNombre;
            userLogeado.apellidos               = Preferences.pApellido;
            userLogeado.codigoTipoUsuario       = Preferences.codtipoUsuario;
            personAuthProvider.credentialAuth   = userLogeado;

          } else {
            Preferences.limpiarPreferences();
            personAuthProvider.status = AuthStatus.Unauthenticated;
          }

        }

      } else {
        personAuthProvider.status = AuthStatus.Unauthenticated;
      }

    }

    switch( personAuthProvider.status ){
      case AuthStatus.Unauthenticated:
        return const LoginPage();
      case AuthStatus.Authenticated:
        return  const HomePage();
    }

  }

  getRelacionAsync(BuildContext context) async {

    final gProvider = Provider.of<GlobalProvider>(context, listen:false);
    final personAuthProvider = Provider.of<PersonAuthProvider>(context, listen: false);

    //ASIGNACION DE VARIABLES PARA EL SHARED PREFERENCES
    Preferences.codDispositivo    = gProvider.relationmodel.codigoDispositivo!;
    Preferences.codServicio       = gProvider.relationmodel.codigoServicio.toString();
    Preferences.codCliente        = gProvider.relationmodel.codigoCliente!;
    Preferences.codSubArea        = gProvider.relationmodel.codigoSubArea!;
    Preferences.nombreArea        = gProvider.relationmodel.nombreArea!;
    Preferences.nombreSubArea     = gProvider.relationmodel.nombreSubArea!; 
    Preferences.nombreSucursal    = gProvider.relationmodel.nombreSucursal!;
    Preferences.nombreCliente     = gProvider.relationmodel.nombreCliente!;
    Preferences.aliasSede         = gProvider.relationmodel.aliasSede;
    Preferences.codTipoServicio   = gProvider.relationmodel.codigoTipoServicio!;
    Preferences.codPuesto         = gProvider.relationmodel.codigoPuesto!;
    Preferences.nombrePuesto      = gProvider.relationmodel.nombrePuesto!;
    Preferences.codPerfil         = gProvider.relationmodel.codigoPerfil!;

    if( Preferences.isAuthenticated ) {

      personAuthProvider.status = AuthStatus.Authenticated;
      final personaLogeada      = LoginDniResponse();
      final userLogeado         = LoginCredentialsResponse();

      if( gProvider.relationmodel.codigoPerfil == 1 || gProvider.relationmodel.codigoPerfil == 2 ){
        personaLogeada.codigoPersonal  = Preferences.codigoPersonal;
        personaLogeada.dni             = Preferences.dni;
        personaLogeada.pNombre         = Preferences.pNombre;
        personaLogeada.sNombre         = Preferences.sNombre;
        personaLogeada.pApellido       = Preferences.pApellido;
        personaLogeada.sApellido       = Preferences.sApellido;
        personaLogeada.cargo           = Preferences.cargo;
        personaLogeada.codTipoUsuario  = Preferences.codtipoUsuario;
        personAuthProvider.personAuth  = personaLogeada;
      } else {
        userLogeado.codigoUsuario           = int.parse(Preferences.codigoPersonal);
        userLogeado.documento               = Preferences.dni;
        userLogeado.nombres                 = Preferences.pNombre;
        userLogeado.apellidos               = Preferences.pApellido;
        userLogeado.codigoTipoUsuario       = Preferences.codtipoUsuario;
        personAuthProvider.credentialAuth   = userLogeado;
      }
    } else {
      personAuthProvider.status = AuthStatus.Unauthenticated;
    }
  }

}