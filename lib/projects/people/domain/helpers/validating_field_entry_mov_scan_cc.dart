import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/data/services/movimiento_service.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/domain/models/movimiento_model.dart';
import 'package:solgis/projects/people/domain/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/people/theme/theme.dart';

validatingFieldsEntryMovScanCC(
    BuildContext context, ConsultaModel consulta) async {
  // ignore: unused_local_variable
  final ingresoProvider = Provider.of<IngresoAutorizadoProvider>(context, listen: false);
  // ignore: unused_local_variable
  final loginGlobal = Provider.of<GlobalProvider>(context, listen: false).relationModel;
  final movimientoProvider = Provider.of<MovimientosProvider>(context, listen: false);

  CustomProgressDialog progressDialog = CustomProgressDialog(context, blur: 10);
  progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)
  ));

  progressDialog.show();

  //ACTUALIZANDO LOS CODIGOS DEL AUTORIZANTE, CODIGO DE AREA Y CODIGO MOTIVOO
  if (consulta.codigoAutorizante == 0 || consulta.codigoAutorizante == -1) {
    progressDialog.dismiss();
    return showSnackBarAwesome(
      context,
      'Atencion',
      'El autorizante no esta registrado para el personal',
      ContentType.failure
    );
  }

  if (consulta.codigoArea == 0 || consulta.codigoArea == -1) {
    progressDialog.dismiss();
    return showSnackBarAwesome( context, 'Atencion', 'El area no esta registrado para el personal', ContentType.failure);
  }

  if ( consulta.codigoMotivo == -1) {
    progressDialog.dismiss();
    return showSnackBarAwesome(context, 'Atencion',
        'El motivo no esta registrado para el personal', ContentType.failure);
  }

  //REGISTRANDO EL MOVIMIENTO Y OBTENIENDO EL CODIGO DE SERVICIO.
  // ignore: unused_local_variable
  final MovimientoResponseModel? movimientoResponse =
      await movimientoProvider.registerMovimiento(context, consulta);

  //print(movimientoResponse);

  progressDialog.dismiss();

  // ignore: use_build_context_synchronously
  showSnackBarAwesome(
    context,
    'Movimiento de Entrada',
    'Se registró el movimiento  para el personal ${consulta.docPersona} con exito',
    ContentType.success
  );

  // ignore: use_build_context_synchronously
  // Navigator.of(context).pop();
}
