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

validatingFieldsEntryMov(BuildContext context, ConsultaModel consulta) async {

  final ingresoProvider    = Provider.of<IngresoAutorizadoProvider>(context, listen: false);
  final loginGlobal        = Provider.of<GlobalProvider>(context, listen: false).relationModel;
  final movimientoProvider = Provider.of<MovimientosProvider>(context, listen: false);

  if (!ingresoProvider.isValidForm()) {
    return showSnackBarAwesome(context, 'Atencion', 'Hay datos sin llenar', ContentType.failure);
  }

  CustomProgressDialog progressDialog = CustomProgressDialog(context, blur: 10);
  progressDialog.setLoadingWidget(CircularProgressIndicator(
    valueColor:AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)
  ));

  progressDialog.show();

  //ACTUALIZANDO LOS CODIGOS DEL AUTORIZANTE, CODIGO DE AREA Y CODIGO MOTIVOO
  if (consulta.codigoAutorizante == 0 || consulta.codigoAutorizante == -1) {
    consulta.codigoAutorizante = ingresoProvider.codautorizante;
    consulta.autorizante       = ingresoProvider.autorizante;
  }

  if (consulta.codigoArea == 0 || consulta.codigoArea == -1) {
    consulta.codigoArea = ingresoProvider.cod_area;
    consulta.area       = ingresoProvider.area_acceso;
  }

  if (consulta.codigoMotivo == 0 || consulta.codigoMotivo == -1) {
    consulta.codigoMotivo = ingresoProvider.cod_motivo;
    consulta.motivo       = ingresoProvider.motivo;
  }

  //REGISTRANDO EL MOVIMIENTO Y OBTENIENDO EL CODIGO DE SERVICIO.
  final MovimientoResponseModel? movimientoResponse = await movimientoProvider.registerMovimiento(context, consulta);

  //GUARDA LOS DATOS DE ACCESO

  if (ingresoProvider.selectedGuias.isNotEmpty) {
    for (var guia in ingresoProvider.selectedGuias) {
      await movimientoProvider.registerDatoAcceso(
        guia.description,
        movimientoResponse!.codMovimiento,
        'PEOPLE',
        1,
        loginGlobal.codigoServicio.toString(),
        loginGlobal.codigoCliente!,
        guia.file
      );
    }
  }

  if (ingresoProvider.selectedThings.isNotEmpty) {
    for (var thing in ingresoProvider.selectedThings) {
      await movimientoProvider.registerDatoAcceso(
        thing.description,
        movimientoResponse!.codMovimiento,
        'PEOPLE',
        2,
        loginGlobal.codigoServicio.toString(),
        loginGlobal.codigoCliente!,
        thing.file
      );
    }
  }

  // await movimientoProvider.registerDatoAcceso( ingresoProvider.guia, movimientoResponse!.codMovimiento, 'PEOPLE', 1, loginGlobal.codigoServicio.toString(), loginGlobal.codigoCliente!, ingresoProvider.fotoGuia );
  // await movimientoProvider.registerDatoAcceso( ingresoProvider.material_valor, movimientoResponse.codMovimiento, 'PEOPLE', 2, loginGlobal.codigoServicio.toString(), loginGlobal.codigoCliente!, ingresoProvider.fotoMaterialValor );

  // if (ingresoProvider.fotoPersonalUpdate != null)
  //   await PersonalProvider().uploadPhotoPersonal(
  //       ingresoProvider.fotoPersonalUpdate!,
  //       consulta.docPersona.toString(),
  //       loginGlobal.codigoServicio.toString()
  //   );

  progressDialog.dismiss();

  // ignore: use_build_context_synchronously
  showSnackBarAwesome(
    context,
    'EXITO',
    'Se registro el movimiento para el personal ${consulta.docPersona} con exito',
    ContentType.success
  );

  // ignore: use_build_context_synchronously
  Navigator.of(context).pop();
}
