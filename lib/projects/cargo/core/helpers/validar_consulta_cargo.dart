import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
//import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/projects/cargo/domain/consulta_model_cargo.dart';
import 'package:solgis/projects/cargo/domain/services/consulta_service_cargo.dart';
//import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';
import 'package:solgis/projects/people/theme/theme.dart';

void validarConsultaCargo(BuildContext context, String placa,
    String codServicio, String? codCliente) async {
  //final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

  CustomProgressDialog progressDialog = CustomProgressDialog(context, blur: 10);
  progressDialog.setLoadingWidget(CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)));
  progressDialog.show();

  ConsultaModelCargo consulta =
      await ConsultaProviderCargo().getConsulta(placa, codServicio);

  progressDialog.dismiss();

  if (consulta.resultado == 'OK') { 
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, 'consulta_page_cargo', arguments: {
      'consulta': consulta,
    });
  } else {
    // ignore: use_build_context_synchronously
    return showSnackBarAwesome(context, 'Atencion',
        'El vehiculo no se encuntra adentro', ContentType.failure);
  }
}
