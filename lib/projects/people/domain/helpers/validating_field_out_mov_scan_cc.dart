import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/projects/people/data/services/movimiento_service.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/domain/models/movimiento_model.dart';
import 'package:solgis/projects/people/theme/theme.dart';

validatingFieldsOutMovScanCC(BuildContext context, ConsultaModel consulta) async {

  final movimientoProvider = Provider.of<MovimientosProvider>(context, listen: false);
  CustomProgressDialog progressDialog = CustomProgressDialog(context,blur: 10);
  progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)));
  progressDialog.show();
  // ignore: unused_local_variable
  final MovimientoResponseModel? movReponse = await movimientoProvider.registerMovimiento(context, consulta);
  progressDialog.dismiss();

  // ignore: use_build_context_synchronously
  showSnackBarAwesome(context, 'Movimiento de Salida', 'Se registro el movimiento para el personal ${consulta.docPersona} con exito', ContentType.failure);

}








