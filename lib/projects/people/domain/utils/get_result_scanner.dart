import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/domain/helpers/consultar_doi_people.dart';
import 'package:solgis/projects/people/domain/providers/numpad_provider.dart';
import 'package:solgis/projects/people/domain/providers/radio_provider.dart';
import 'package:solgis/projects/people/domain/providers/registrar_form_provider.dart';

getResultScanner(BuildContext context, String barcode){

  final numpadProvider = Provider.of<NumPadProvider>(context, listen: false);
  final loginProvider= Provider.of<GlobalProvider>(context, listen:false).relationModel;
  final tipoProvider = Provider.of<RadioProvider>(context, listen:false);
  final registerForm = Provider.of<RegistrarFormProvider>(context, listen:false);

  if(barcode == '-1'){

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: '¡Alerta!',
        message:'Lo siento, no se ha escaneado nada',
        contentType: ContentType.warning,
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }else{

    registerForm.isScanning = true;

    if( tipoProvider.valorTipoDocumento == 1 ){
      
      if( barcode.length <= 8 ){
        numpadProvider.dni = barcode;
      }
      registerForm.dni = barcode;

      if( barcode.trim() == '' ) return showSnackBarAwesome(context, 'Error', 'Ingrese un DNI valido', ContentType.failure);
      return consultarDOI(context, barcode, loginProvider.codigoServicio.toString(), loginProvider.codigoCliente!);

    }else if( tipoProvider.valorTipoDocumento == 2 ){

      numpadProvider.carnet = barcode;
      registerForm.carnetExtranjeria = barcode;

      if( barcode.trim() == '' ) return showSnackBarAwesome(context, 'Error', 'Ingrese un CE valido', ContentType.failure);
      return consultarDOI(context, barcode, loginProvider.codigoServicio.toString(), loginProvider.codigoCliente!);

    }else{

      registerForm.pasaporte = barcode;

      if( barcode.trim() == '' ) return showSnackBarAwesome(context, 'Error', 'Ingrese un PASAPORTE valido', ContentType.failure);
      return consultarDOI(context, barcode, loginProvider.codigoServicio.toString(),  loginProvider.codigoCliente!);

    }

  }

}
