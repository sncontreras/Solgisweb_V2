import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/dispositivo_servicio_service.dart';
import 'package:solgis/core/device/preferences.dart';
import 'package:solgis/core/domain/models/device_information_provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';

Future<void>getRelation(BuildContext context)async{

  final gprovider = Provider.of<GlobalProvider>(context, listen:false);
  final device = DeviceInformationModel();
  await device.getInformationDevice();
  final relationService = RelationDeviceService();
  final relation =  await relationService.getRelation(device.serialNumber!);
  gprovider.relationmodel = relation;

  //ASIGNACION DE VARIABLES PARA EL SHARED PREFERENCES
  Preferences.codDispositivo    = gprovider.relationModel.codigoDispositivo!;
  Preferences.codServicio       = gprovider.relationModel.codigoServicio.toString();
  Preferences.codCliente        = gprovider.relationModel.codigoCliente!;
  Preferences.codSubArea        = gprovider.relationModel.codigoSubArea!;
  Preferences.nombreArea        = gprovider.relationModel.nombreArea!;
  Preferences.nombreSubArea     = gprovider.relationModel.nombreSubArea!;
  Preferences.nombreSucursal    = gprovider.relationModel.nombreSucursal!;
  Preferences.nombreCliente     = gprovider.relationModel.nombreCliente!;
  Preferences.aliasSede         = gprovider.relationModel.aliasSede;
  Preferences.codTipoServicio   = gprovider.relationModel.codigoTipoServicio!;
  Preferences.codPuesto         = gprovider.relationModel.codigoPuesto!;
  Preferences.nombrePuesto      = gprovider.relationModel.nombrePuesto!;
  Preferences.codPerfil         = gprovider.relationModel.codigoPerfil!;

}