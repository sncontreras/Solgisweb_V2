import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/data/services/movimiento_service.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/domain/models/datos_acceso_movimiento_model.dart';
import 'package:solgis/projects/people/domain/models/movimiento_model.dart';
import 'package:solgis/projects/people/domain/providers/salida_provider.dart';
import 'package:solgis/projects/people/presentation/pages/salidas/widgets/widgets.dart';
import 'package:solgis/projects/people/theme/theme.dart';


class SalidaAutorizadaPage extends StatelessWidget{

  const SalidaAutorizadaPage({super.key});

  @override
  Widget build(BuildContext context) {

    Map argm = ModalRoute.of(context)!.settings.arguments as Map;
    ConsultaModel consulta = argm['consulta'];
    List<DatoAccesoMModel>? datosAcceso = argm['datos_acceso'];
    final salidaProvider = Provider.of<SalidaProvider>(context, listen: false);
    final loginGlobal = Provider.of<GlobalProvider>(context,listen: false).relationModel;

    return SalidaTemplatePage(
      titleIngreso: 'SALIDA AUTORIZADA', 
      colorAppBar: const Color(0xffF57E25), 
      body: SalidaAutorizadaWidget(consulta: consulta, datosAcceso: datosAcceso),
      consulta: consulta,
      registrarFunction: () async {

        final movimientoProvider = Provider.of<MovimientosProvider>(context, listen: false);
        CustomProgressDialog progressDialog = CustomProgressDialog(context,blur: 10);
        progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)));
        progressDialog.show();

        final MovimientoResponseModel? movReponse = await movimientoProvider.registerMovimiento(context, consulta);

        //GUARDAR LOS DATOS DE ACCESO.
        if (salidaProvider.selectedGuias.isNotEmpty) {
          for (var guia in salidaProvider.selectedGuias) {
            await movimientoProvider.registerDatoAcceso(
              guia.description,
              movReponse!.codMovimiento,
              'PEOPLE',
              1,
              loginGlobal.codigoServicio.toString(),
              loginGlobal.codigoCliente!,
              guia.file
            );
          }
        }

        if (salidaProvider.selectedThings.isNotEmpty) {
          for (var thing in salidaProvider.selectedThings) {
            await movimientoProvider.registerDatoAcceso(
              thing.description,
              movReponse!.codMovimiento,
              'PEOPLE',
              2,
              loginGlobal.codigoServicio.toString(),
              loginGlobal.codigoCliente!,
              thing.file
            );
          }
        }

        // await movimientoProvider.registerDatoAcceso( salidaProvider.guia , movReponse!.codMovimiento, 'PEOPLE', 1, loginGlobal.codigoServicio.toString(), loginGlobal.codigoCliente!, salidaProvider.fotoGuia );
        // await movimientoProvider.registerDatoAcceso( salidaProvider.materialValor , movReponse.codMovimiento, 'PEOPLE', 2, loginGlobal.codigoServicio.toString(), loginGlobal.codigoCliente!, salidaProvider.fotoMaterialValor );

        progressDialog.dismiss();

        // ignore: use_build_context_synchronously
        showSnackBarAwesome(context, 'EXITO', 'Se registro el movimiento para el personal ${consulta.docPersona} con exito', ContentType.success);

        // ignore: use_build_context_synchronously
        Navigator.pop(context);

      },

    );

  }

}
