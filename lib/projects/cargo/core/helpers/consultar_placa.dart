import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/projects/cargo/core/theme/theme_cargo.dart';
import 'package:solgis/projects/cargo/data/services/vehicle_service.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

consultarPlaca(BuildContext context, String placa, String codServicio,
    String codCliente) async {
  final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

  if (placa.trim().isEmpty || placa.trim().length < 6) {
    return showSnackBarAwesome(context, 'Atencion',
        'Por favor ingrese una placa valida', ContentType.failure);
  }

  CustomProgressDialog progressDialog =
      CustomProgressDialog(context, loadingWidget: const Text('Cargando'));

  progressDialog.setLoadingWidget(CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation(AppThemeCargo.lighThemeCargo.primaryColor)));

  progressDialog.show();

  final validationVehicle = VehicleService();
  final response =
      await validationVehicle.validarPlaca(placa, codServicio, codCliente);
  progressDialog.dismiss();

  if (response!.resultado == 'OK') {
    vehicleProvider.vehicleResponse = response;
    // final photoresponse = await validationVehicle.getDocuments(placa);

    //vehicleProvider.vehicleResponse = response;
    if (codCliente == customers["chec"]) {
      if (response.tieneAutorizacion == '1') {
        if (response.header == "Ingreso Autorizado") {
          // ignore: use_build_context_synchronously
          return Navigator.pushNamed(context, 'ingreso_autorizado_page_cargo');
        } else {
          // ignore: use_build_context_synchronously
          return Navigator.pushNamed(context, 'salida_autorizada_page_cargo');
        }
      } else {
        // ignore: use_build_context_synchronously
        return showSnackBarAwesome(context, 'Atencion',
            'Vehículo sin autorizacion', ContentType.failure);
      }
    }

    if (response.header == "Ingreso Autorizado") {
      // ignore: use_build_context_synchronously
      return Navigator.pushNamed(context, 'ingreso_autorizado_page_cargo');
    } else {
      // ignore: use_build_context_synchronously
      return Navigator.pushNamed(context, 'salida_autorizada_page_cargo');
    }
  } else {
    // ignore: use_build_context_synchronously
    await NDialog(
      dialogStyle:
          DialogStyle(titleDivider: true, backgroundColor: Colors.white),
      title: const Text("Informacion", style: TextStyle(color: Colors.black)),
      content: Text(
          "El vehiculo con placa $placa \nno se encuentra en el sistema \nDesea Registrarlo?",
          style: const TextStyle(color: Colors.black)),
      actions: <Widget>[
        TextButton(
            child: const Text("Si"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'crear_vehiculo_page_cargo',
                  arguments: {
                    'placa': placa,
                  });
            }),
        TextButton(
            child: const Text("No"), onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }
}
