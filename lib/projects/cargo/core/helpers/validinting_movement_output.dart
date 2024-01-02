import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/movement_service.dart';
import 'package:solgis/core/domain/entities/photo_vehicle_position.dart';
import 'package:solgis/core/domain/entities/reason.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/models/authority.dart';
import 'package:solgis/core/domain/models/epp_register_model.dart';
import 'package:solgis/core/domain/models/movement_body_model.dart';
import 'package:solgis/core/domain/models/movement_multi_body.dart';
import 'package:solgis/core/domain/models/multi_input_model.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/projects/cargo/data/models/create_cargo_body.dart';
import 'package:solgis/projects/cargo/data/services/cargo_service.dart';
import 'package:solgis/projects/cargo/data/services/parking_service.dart';
import 'package:solgis/projects/cargo/data/services/photo_cargo_service.dart';
import 'package:solgis/projects/cargo/domain/entities/access_area.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

  movementValiditingOut(context) async {

    final gProvider       = Provider.of<GlobalProvider>(context, listen: false);
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen:false);
    final driverProvider  = Provider.of<DriverProvider>(context, listen:false);
    final outProvider     = Provider.of<SalidaAutorizadaProvider>(context, listen:false);
    final authProvider    = Provider.of<PersonAuthProvider>(context, listen: false);
    final confProvider    = Provider.of<ConfigProvider>(context,  listen: false);
    final List<String> fotosDisponibles      = [];
    final List<MultiInput>codesMultiGuias    = [];
    final List<MultiInput>codesMultiPrecinto = [];

    if( !outProvider.hasDriver ) return;

    if(driverProvider.driverResponse!.codAutoriX != 0 && driverProvider.driverResponse!.codAutoriX != -1 && driverProvider.driverResponse!.codAutoriX != null  ){
      final autorizante = Authority(
        codPersonal: driverProvider.driverResponse!.codAutoriX.toString(),
        nombrePersonal: driverProvider.driverResponse!.persAutoriPor,
      );
      outProvider.selectedAutorizante = autorizante;
    }

    if(driverProvider.driverResponse!.copMotivo != null && driverProvider.driverResponse!.copMotivo != -1  ){
      final reason = Reason(
        codigo: driverProvider.driverResponse!.copMotivo.toString(),
        tipo: driverProvider.driverResponse!.persMotivo
      );
      outProvider.selectedReason = reason;
    }

    if(driverProvider.driverResponse!.codArea != null && driverProvider.driverResponse!.codArea != -1 && driverProvider.driverResponse!.codArea != null ){
      final area = AccessArea(
        codigo: driverProvider.driverResponse!.codArea.toString(),
        area: driverProvider.driverResponse!.persArea,
      );
      outProvider.selectedAccessArea = area;
    }

    // if( outProvider.selectedAutorizante.codPersonal == null ) return mostrarAlertas(context, "Falta seleccionar autorizante");
    if( outProvider.selectedReason.codigo == null     )       return mostrarAlertas(context, "Falta seleccionar el motivo");
    if( outProvider.selectedAccessArea.codigo == null )       return mostrarAlertas(context, "Falta seleccionar el area de acceso");

    if( confProvider.configuration!.photos!.delantera!) fotosDisponibles.add("delantera");
    if( confProvider.configuration!.photos!.derecho!  ) fotosDisponibles.add("derecho");
    if( confProvider.configuration!.photos!.trasera!  ) fotosDisponibles.add("trasera");
    if( confProvider.configuration!.photos!.izquierdo!) fotosDisponibles.add("izquierdo");
    if( confProvider.configuration!.photos!.cabina!   ) fotosDisponibles.add("cabina");
    if( confProvider.configuration!.photos!.guantera! ) fotosDisponibles.add("guantera");
    if( confProvider.configuration!.photos!.carga!    ) fotosDisponibles.add("carga");

    if( outProvider.selectedPhotosVPosition.length != fotosDisponibles.length && outProvider.lazyResponse!.codTipoCarga != 152 ) return mostrarAlertas(context, "Faltan registrar algunas fotos del vehiculo");

    outProvider.isLoading = true;

    final MovementBody movementVehicleBody = MovementBody(
      autorizadoPor: int.parse(outProvider.selectedAutorizante.codPersonal!),
      codigoArea: int.parse( outProvider.selectedAccessArea.codigo! ),
      codigoCarreta: "-",
      codigoMovPeatonal: 0,
      codigoServicio: gProvider.relationModel.codigoServicio,
      creadoPor: (authProvider.credentialAuth.documento == null) ?  "CARGO_${authProvider.personauth.dni}"  :"CARGO_${authProvider.credentialAuth.documento}",
      esVehicular: true,
      codigoTipoCarga: outProvider.lazyResponse?.codTipoCarga?? 0,
      codigoTipoMotivo: int.parse( outProvider.selectedReason.codigo! ),
      codigoConductor: driverProvider.driverResponse!.codPers,
      codigoEmpresa: driverProvider.driverResponse!.codEmpresa,
      codigoPersonal: vehicleProvider.vehicleResponse!.codigoVehiculo,
      codigoTipoMovimiento: vehicleProvider.vehicleResponse!.codMovSgte,
      parqueo: "" ,
    );

    final MovementBody movementPersonBody = MovementBody(
      codigoMovPeatonal: 0,
      esVehicular: false,
      autorizadoPor: int.parse( outProvider.selectedAutorizante.codPersonal! ),
      codigoArea: int.parse( outProvider.selectedAccessArea.codigo! ),
      codigoTipoMotivo: int.parse( outProvider.selectedReason.codigo! ),
      codigoCarreta: null,
      codigoServicio: gProvider.relationModel.codigoServicio,
      creadoPor: (authProvider.credentialAuth.documento == null) ?  "CARGO_${authProvider.personauth.dni}"  :"CARGO_${authProvider.credentialAuth.documento}",
      codigoTipoCarga: null,
      codigoConductor: null,
      codigoEmpresa: driverProvider.driverResponse!.codEmpresa,
      codigoPersonal: driverProvider.driverResponse!.codPers,
      codigoTipoMovimiento: driverProvider.driverResponse!.codMovSgte,
    );

    final resp  = await MovementService.registerMovement( movementVehicleBody );

    final resp1 = await MovementService.registerMovement( movementPersonBody );


    if( resp!.transaccion == 1 && resp1!.transaccion == 1){

      final CreateCargoBody cargoBody = CreateCargoBody(
        codTipoCarga: outProvider.lazyResponse?.codTipoCarga?? 0 ,
        alcoholimetro: outProvider.alcoholimetro,
        codCliente: gProvider.relationModel.codigoCliente,
        codServicio: gProvider.relationModel.codigoServicio,
        codMovVehicular: resp.codMovCreado ,
        codMovPeatonal: resp1.codMovCreado,
        carreta: outProvider.carretaController.text,
        carga: outProvider.selectedCarga,
        idOrigen: (outProvider.selectedOrigin.originCode == null) ? null : int.parse(outProvider.selectedOrigin.originCode!),
        contenedor: outProvider.containerController.text,
        codTContenedor: (outProvider.selectedOptionRadio.codeOptionRadio == null) ? null : int.parse(outProvider.selectedOptionRadio.codeOptionRadio!),
        booking: outProvider.bookingController.text,
        contrato: outProvider.contratoController.text,
        creadoPor: (authProvider.credentialAuth.documento == null) ?  "CARGO_${authProvider.personauth.dni}"  :"CARGO_${authProvider.credentialAuth.documento}",
        codAutorizante: int.parse(outProvider.selectedAutorizante.codPersonal!),
        codMotivo: int.parse( outProvider.selectedReason.codigo! ),
        codAreaAcceso: int.parse( outProvider.selectedAccessArea.codigo! ),
        codOpLogis: (outProvider.selectedOperator.operatorCode == null) ? null : int.parse(outProvider.selectedOperator.operatorCode! ),
        guiaTransp:  outProvider.gTranportistaController.text,
        codMaterial: (outProvider.materialSelected.codigo == null)
            ? null
            : int.parse(outProvider.materialSelected.codigo!),
        destino: outProvider.destinoController.text,
        kilometraje: outProvider.kilometrajeController.text,
      );

      final resp2 = await CargoService.createCargo( cargoBody );

      if( resp2!.estado == 1){

        // ignore: unused_local_variable
        final List<EppRegister> codesEpps = outProvider.selectedEpps!.map((epp) {
          return EppRegister(
            codeEpp: int.parse(epp.codeEpps!)
          );
        }).toList(); 

        // ignore: use_build_context_synchronously
        if( outProvider.alcoholimetroPhoto != null ) await PhotoCargoService.uploadImageForm( context, outProvider.alcoholimetroPhoto!.path, 12, resp2.codigo! ,'');
        // ignore: use_build_context_synchronously
        if( outProvider.containerPhoto != null )     await PhotoCargoService.uploadImageForm( context, outProvider.containerPhoto!.path, 5, resp2.codigo! ,'');
        // ignore: use_build_context_synchronously
        if( outProvider.gTranportistaPhoto != null ) await PhotoCargoService.uploadImageForm( context, outProvider.gTranportistaPhoto!.path, 7, resp2.codigo! ,'');
        // ignore: use_build_context_synchronously
        if( outProvider.bookingPhoto != null )       await PhotoCargoService.uploadImageForm( context, outProvider.bookingPhoto!.path, 9, resp2.codigo! ,'');
        // ignore: use_build_context_synchronously
        if( outProvider.contratoPhoto != null )      await PhotoCargoService.uploadImageForm( context, outProvider.contratoPhoto!.path, 10, resp2.codigo! ,'');

        if( outProvider.selectedPhotosVPosition.isNotEmpty )  {
          final photos = outProvider.selectedPhotosVPosition;
          for ( PhotoVehiclePosition photo in photos ) {
            // ignore: use_build_context_synchronously
            await PhotoCargoService.uploadImageForm( context, photo.file!.path, photo.position, resp2.codigo!, '' );
          }
        }

        if( outProvider.selectedGuias.isNotEmpty){

          final guias = outProvider.selectedGuias;

          for (var guia in guias) {

            int? codePhoto;

            if( guia.file != null ) {
              // ignore: use_build_context_synchronously
              codePhoto =  await PhotoCargoService.uploadImageMultiForm( context, guia.file!.path, 4, resp2.codigo!, guia.descripcion);
            }

            final input  = MultiInput(
              inputCode: 4,
              description: guia.descripcion,
              codePhoto: codePhoto,
            );

            codesMultiGuias.add(input);
          }
        }

        if( outProvider.selectedPrecintos.isNotEmpty){
          
          final precintos = outProvider.selectedPrecintos;
          for (var precinto in precintos) {

            int? codePhoto;

            if( precinto.file != null ) {
              codePhoto =  await PhotoCargoService.uploadImageMultiForm( context, precinto.file!.path, 8 , resp2.codigo!, precinto.descripcion);
            } 

            final input  = MultiInput(
              inputCode: 8,
              description: precinto.descripcion,
              codePhoto:  codePhoto,
            );

            codesMultiPrecinto.add(input);

          }

        }

        final List<MultiInput> codesMultiFinal = codesMultiGuias + codesMultiPrecinto;

        // final MovementEppsBody eppsBody = MovementEppsBody(
        //   codCargo: resp2.codigo,
        //   codCliente: gProvider.relationModel.codigoCliente,
        //   codServicio: gProvider.relationModel.codigoServicio,
        //   creadoPor: 'CARGO_${gProvider.relationModel.codigoServicio}',
        //   codeEpps: ( outProvider.selectedEpps == null ) ? null : codesEpps,
        // ); 

        final MovementMultiBody multiBody = MovementMultiBody(
          codCargo: resp2.codigo,
          codCliente: gProvider.relationModel.codigoCliente,
          codServicio: gProvider.relationModel.codigoServicio,
          creadoPor: (authProvider.credentialAuth.documento == null) ?  "CARGO_${authProvider.personauth.dni}"  :"CARGO_${authProvider.credentialAuth.documento}",
          multi: codesMultiFinal,
        ); 

        // if( outProvider.selectedEpps!.isNotEmpty )  await MovementService.registerEpps( eppsBody );

        if( codesMultiFinal.isNotEmpty ) await MovementService.registerMulti( multiBody );

        if( gProvider.relationModel.codigoCliente == customers['yobel']) {
          await ParkingService.setResetParking( 
            driverProvider.driverResponse!.codPers!,  
            outProvider.asignedParking.codParqueo!,
            vehicleProvider.vehicleResponse!.nroPlaca!,
            gProvider.relationModel.codigoCliente!,
            gProvider.relationModel.codigoServicio!
          );
        }


        // ignore: use_build_context_synchronously
        showSnackBarAwesome(  context, 'EXITO', 'Se registro el movimiento vehicular con exito', ContentType.success );

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

      }

    }else{

      // ignore: use_build_context_synchronously
      showSnackBarAwesome(  context, 'ERROR', 'Hubo Problemas para registrar el movimiento', ContentType.failure );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

    }
    outProvider.isLoading = false;

    outProvider.cleanDriverInformation();
    outProvider.cleanEntryData();
    outProvider.cleanPhotosVehicle();
    driverProvider.cleanValidationPerson();
    vehicleProvider.cleandata();

  }

  int getIndexPhotoFB( int index ){
    switch ( index ) {
      case 0:
        return  13;
      case 1:
        return  14;
      case 2:
        return  15;
      case 3:
        return  16;
      case 4:
        return  17;
      case 5:
        return  18;
      default:
        return 1;
    }
  }


  mostrarAlertas( BuildContext context, String label ){
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Informacion"),
          content: Text(label),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.pop(context), 
              child: const Text("Aceptar"),
            )
          ],
        );
      }
    );
  }
