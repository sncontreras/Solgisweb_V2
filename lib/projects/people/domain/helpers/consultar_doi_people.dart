import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/personal_service.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/models/person_validation_enterprise_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/projects/people/data/services/consulta_doi_service.dart';
import 'package:solgis/projects/people/data/services/datos_acceso_movimiento_service.dart';
import 'package:solgis/projects/people/data/services/personal_service.dart';
import 'package:solgis/projects/people/data/services/validar_tiempo_service.dart';
import 'package:solgis/projects/people/domain/helpers/validating_field_entry_mov_scan_cc.dart';
import 'package:solgis/projects/people/domain/helpers/validating_field_out_mov_scan_cc.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/domain/models/person_validation_time_model.dart';
import 'package:solgis/projects/people/domain/models/persona_model.dart';
import 'package:solgis/projects/people/domain/providers/numpad_provider.dart';
import 'package:solgis/projects/people/theme/theme.dart';

void consultarDOI(BuildContext context, String documento, String codServicio,
    String codCliente,
    {isScan = false, String? temperatura}) async {
  CustomProgressDialog progressDialog = CustomProgressDialog(context, blur: 10);
  final numpadProvider = Provider.of<NumPadProvider>(context, listen: false);
  final loginProvider =
      Provider.of<PersonAuthProvider>(context, listen: false).personauth;
  final gProvider = Provider.of<GlobalProvider>(context, listen: false);
  PersonValidationEnterpriseModel? enterpriseSelected;

  progressDialog.setLoadingWidget(CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation(AppThemePeople.lighThemePeople.primaryColor)));
  progressDialog.show();

  if (gProvider.relationModel.codigoCliente == customers["hayduk"] ||
      gProvider.relationModel.codigoCliente == customers["centinela"]) {
    final enterPrise = await PersonalService.getEnterPriseInduction(
        documento, gProvider.relationModel.codigoServicio!);

    if (enterPrise.length > 1) {
      // ignore: use_build_context_synchronously
      enterpriseSelected =
          // ignore: use_build_context_synchronously
          await showConfirmationDialog<PersonValidationEnterpriseModel>(
        context: context,
        message: "Seleccione una empresa",
        title: "Atencion",
        actions: enterPrise
            .map((enter) => AlertDialogAction<PersonValidationEnterpriseModel>(
                  key: enter,
                  label: StringHelper.patternString(enter.abreviatura ?? ""),
                ))
            .toList(),
        barrierDismissible: false,
      );
    } else {
      if (enterPrise.length == 1) {
        enterpriseSelected = enterPrise.first;
      } else {
        enterpriseSelected = null;
      }
    }
  }

  ConsultaModel consulta = await ConsultaDOIService().getConsulta(
      documento, codServicio, enterpriseSelected?.codEmpresa, codCliente);

  progressDialog.dismiss();

  if ((consulta.tieneAutorizacion == 0 &&
      gProvider.relationModel.codigoCliente == customers["chec"])) {
// ignore: use_build_context_synchronously
    /* await NDialog(
      dialogStyle: DialogStyle(
          titleDivider: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      title: const Text("INFORMACION",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      content: 
          Text('La persona ${consulta.personaAutorizacion} no tiene autorización',
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          
      actions: <Widget>[
        const Divider(color: Colors.black),
        TextButton(
            child: const Text("Aceptar",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);*/
    // ignore: use_build_context_synchronously
    return showSnackBarAwesome(
        context, 'Atencion', 'persona sin autorizacion', ContentType.failure);
  } else {
    if (consulta.resultado == 'OK') {
      if (consulta.tipoConsulta == 'INGRESO AUTORIZADO') {
        if (consulta.codigoTipoPersona == null ||
            consulta.codigoEmpresa == null ||
            consulta.codigoCargo == null) {
          // ignore: use_build_context_synchronously
          await NDialog(
            dialogStyle:
                DialogStyle(titleDivider: true, backgroundColor: Colors.white),
            title: const Text("INFORMACION",
                style: TextStyle(color: Colors.black)),
            content: const Text(
                "El Personal se encuentra en el sistema \n ¿Deseas habilitarlo ?",
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: const Text("Si"),
                onPressed: () async {
                  //ALL: REALIZAR LA VERIFICACION SI EL PERSONAL ESTA EN LA BASE DE DATOS O NO.
                  PersonalValidacionModel respValidacion =
                      await PersonalProvider()
                          .validarPersonal(documento, codCliente, codServicio);

                  //ALL: HACER LA HABILITACION Y CREACION DE LA RELACION CON EL SERVICIO.
                  await PersonalProvider().habilitarPersonal(
                      respValidacion.codPersonal!,
                      'PEOPLE_${loginProvider.dni}',
                      codCliente);

                  PersonalModel personalModel = await PersonalProvider()
                      .obtenerPersonal(respValidacion.codPersonal, codCliente);

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'habilitar_personal',
                      arguments: personalModel);
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ).show(context);
        } else {
          //MEJORA PARA EL SCANEO MASIVO DEPENDIENDO SI ESTA HABILITADO O NO
          if (gProvider.relationModel.isFasScan! && isScan == true) {
            // ignore: use_build_context_synchronously
            validatingFieldsEntryMovScanCC(context, consulta);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'ingreso_autorizado_people',
                arguments: consulta);
          }
        }
      } else {
        // ignore: use_build_context_synchronously
        if (consulta.codigoTipoPersona == null ||
            consulta.codigoEmpresa == null ||
            consulta.codigoCargo == null) {
          // ignore: use_build_context_synchronously
          await NDialog(
            dialogStyle:
                DialogStyle(titleDivider: true, backgroundColor: Colors.white),
            title: const Text("INFORMACION",
                style: TextStyle(color: Colors.black)),
            content: const Text(
                "El Personal se encuentra en el sistema \n ¿Deseas habilitarlo ?",
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: const Text("Si"),
                onPressed: () async {
                  //ALL: REALIZAR LA VERIFICACION SI EL PERSONAL ESTA EN LA BASE DE DATOS O NO.
                  PersonalValidacionModel respValidacion =
                      await PersonalProvider()
                          .validarPersonal(documento, codCliente, codServicio);
                  //ALL: HACER LA HABILITACION Y CREACION DE LA RELACION  CON EL SERVICIO.
                  await PersonalProvider().habilitarPersonal(
                      respValidacion.codPersonal!,
                      'PEOPLE_${loginProvider.dni}',
                      codCliente);
                  PersonalModel personalModel = await PersonalProvider()
                      .obtenerPersonal(respValidacion.codPersonal, codCliente);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'habilitar_personal',
                      arguments: personalModel);
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ).show(context);
        } else {
          //MEJORA PARA EL SCANEO MASIVO DE CREC Y CHEC
          if (gProvider.relationModel.isFasScan! && isScan == true) {
            PersonValidationTimeModel validarTiempo =
                await ValidarTiempoService().getConsulta(documento, codServicio,
                    enterpriseSelected?.codEmpresa, codCliente);

            //true si el tiempo es menor a 2 segundos
            if (validarTiempo.resultado) {
              // ignore: use_build_context_synchronously
              await NDialog(
                dialogStyle: DialogStyle(
                    titleDivider: true, backgroundColor: Colors.white),
                title: const Text("INFORMACION",
                    style: TextStyle(color: Colors.black)),
                content: Text(
                    "${validarTiempo.nombres} acaba de ingresar por ${validarTiempo.puesto} ¿Desea darle salida?",
                    style: const TextStyle(color: Colors.black)),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Si"),
                    onPressed: () async {
                      await validatingFieldsOutMovScanCC(context, consulta);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text("No"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ).show(context);
            } else {
              //MIRAR LA FUNCION QUE SE EJECUTA CUANDO SE HACE UNA SALIDA.
              // ignore: use_build_context_synchronously
              validatingFieldsOutMovScanCC(context, consulta);
            }
          } else {
            //OBTENGO LOS DATOS DE ACCESO DEL MOVIMIENTO DE ENTRADA.
            final datosAcceso = await DatosAccesoService()
                .getDatosAccesosMovimiento(
                    1, consulta.codigoServicio, consulta.docPersona!);

            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'salida_autorizada_people',
                arguments: {
                  'consulta': consulta,
                  'datos_acceso': datosAcceso,
                });
          }
        }
      }

      numpadProvider.dni = '';
      numpadProvider.carnet = '';
    } else {
      if (consulta.docPersona != null) {
        //MEJORA PARA EL SCANEO MASIVO DE CREC Y CHEC
        if (gProvider.relationModel.isFasScan! && isScan == true) {
          // ignore: use_build_context_synchronously
          return showSnackBarAwesome(
              context, 'Atencion', consulta.mensaje!, ContentType.failure);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, 'ingreso_denegado_people',
              arguments: consulta);
        }
      } else {
        //ALL: REALIZAR LA VERIFICACION SI EL PERSONAL ESTA EN LA BASE DE DATOS O NO.
        PersonalValidacionModel respValidacion = await PersonalProvider()
            .validarPersonal(documento, codCliente, codServicio);

        if (respValidacion.estadoTransaccion == 1) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, 'ingreso_denegado_people',
              arguments: consulta);
        }

        if (respValidacion.estadoTransaccion == -1) {
          // ignore: use_build_context_synchronously
          await NDialog(
            dialogStyle:
                DialogStyle(titleDivider: true, backgroundColor: Colors.white),
            title: const Text("INFORMACION",
                style: TextStyle(color: Colors.black)),
            content: Text(
                "El documento $documento no se encuentra en el sistema \n ¿Deseas registar al personal?",
                style: const TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: const Text("Si"),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, 'crear_personal_page_people',
                    arguments: documento),
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ).show(context);
        }

        if (respValidacion.estadoTransaccion == 2) {
          // ignore: use_build_context_synchronously
          await NDialog(
            dialogStyle:
                DialogStyle(titleDivider: true, backgroundColor: Colors.white),
            title: const Text("INFORMACION",
                style: TextStyle(color: Colors.black)),
            content: const Text(
                "El Personal se encuentra en el sistema \n ¿Deseas habilitarlo ?",
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: const Text("Si"),
                onPressed: () async {
                  //ALL: HACER LA HABILITACION Y CREACION DE LA RELACION CON EL SERVICIO.
                  await PersonalProvider().habilitarPersonal(
                      respValidacion.codPersonal!,
                      'PEOPLE_${loginProvider.dni}',
                      codCliente);

                  PersonalModel personalModel = await PersonalProvider()
                      .obtenerPersonal(respValidacion.codPersonal, codCliente);

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'habilitar_personal',
                      arguments: personalModel);
                },
              ),
              TextButton(
                  child: const Text("No"),
                  onPressed: () => Navigator.pop(context)),
            ],
          ).show(context);
        }
      }
    }
  }
}
