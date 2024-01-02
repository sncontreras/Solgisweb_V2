import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/movement_service.dart';
import 'package:solgis/core/data/services/personal_service.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/global/constants.dart';
import 'package:solgis/core/helpers/alert.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

class VehiculoIngresoWidget extends StatefulWidget {
  const VehiculoIngresoWidget({super.key});


  @override
  State<VehiculoIngresoWidget> createState() => _VehiculoIngresoWidgetState();
}

class _VehiculoIngresoWidgetState extends State<VehiculoIngresoWidget> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      final vehProvider = Provider.of<VehicleProvider>(context, listen: false);
      final gProvider   = Provider.of<GlobalProvider>(context, listen: false);
      if(gProvider.relationModel.codigoCliente == customers['yobel'] ){
        vehProvider.verifyDriverForYobel(gProvider.relationModel.codigoServicio!, gProvider.relationModel.codigoCliente!);
      }else{
        vehProvider.iswithin = false;
      }
    });
    super.initState();
  }


  @override  
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final autorizadoProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final vehProvider = Provider.of<VehicleProvider>(context);
    final driverProvider = Provider.of<DriverProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);

    return Padding(

      padding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height*0.02),

      child: SingleChildScrollView(
        child: Column(

          children: [

            //N° Documento:
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CustomInput(
                  textController: autorizadoProvider.documentController,
                  hinttext: 'Documento',
                  keyboardType: TextInputType.text,
                  maxlength: 13,
                  width: size.width * .6,
                  height: size.height * .05,
                ),

                IconButton(

                  onPressed: ( autorizadoProvider.isLoading )
                    ? null
                    : ()  async {

                      if( autorizadoProvider.documentController.text == "" )  return  showSnackBarAwesome(context, 'Atencion', 'Ingrese un documento valido', ContentType.failure);
                      FocusScope.of(context).unfocus();
                      autorizadoProvider.isLoading = true;
                      autorizadoProvider.cleanDriverInformation();

                      final response = await PersonalService.validarDOI(
                        '', 
                        autorizadoProvider.documentController.text, 
                        '1', 
                        gProvider.relationModel.codigoServicio.toString() 
                      );

                      if( response.resultado == 'OK'){

                        final resp = await MovementService.checkDriver(
                          autorizadoProvider.documentController.text, 
                          gProvider.relationModel.codigoServicio.toString(),
                          gProvider.relationModel.codigoCliente!,
                        );
                        
                        if( resp == 1) {
                          // ignore: use_build_context_synchronously
                          mostrarAlertas(context, "El conductor ya se encuentra dentro de la planta");
                        }
                        else{
                          driverProvider.driverResponse = response;
                          autorizadoProvider.hasDriver = true;
                        }

                      }if( response.resultado == 'ERROR' ){

                        if( response.codPersTipo != 0 && response.codPers != -1 ){

                          // ignore: use_build_context_synchronously
                          mostrarAlertas(context, response.mensaje!);

                        }else{
                          // ignore: use_build_context_synchronously
                          CustomAlert.showAlertYesNo(context, 'Atencion', 'El documento no esta registrado. \n Desea Registrarlo?', 'crear_conductor_page_cargo');
                        }

                      }
                      autorizadoProvider.isLoading = false;
                    },

                  icon: Icon( Icons.verified_outlined, color: Colors.green, size: size.width *  .1 ), 

                )

              ],
            ),

            SizedBox(height: size.height*0.03),

            ( autorizadoProvider.isLoading )
            ? Container(
              width: double.infinity,
              height: size.height * 0.45,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
            : ( driverProvider.driverResponse == null )
              ? ( vehProvider.iswithin )
                ? const _DriverIsWhitin()
                : ( vehProvider.documentDriverwithin != '' )
                  ? TextButton(
                      onPressed: () async {

                        FocusScope.of(context).unfocus();
                        autorizadoProvider.isLoading = true;
                        autorizadoProvider.cleanDriverInformation();

                        final response = await PersonalService.validarDOI(
                          '', 
                          vehProvider.documentDriverwithin, 
                          '1', 
                          gProvider.relationModel.codigoServicio.toString() 
                        );

                        if( response.resultado == 'OK' ){
                          driverProvider.driverResponse = response;
                          autorizadoProvider.hasDriver = true;
                          autorizadoProvider.documentController.text = response.nroDoi!;
                        }if( response.resultado == 'ERROR' ){

                          if( response.codPersTipo != 0 && response.codPers != -1 ){

                            // ignore: use_build_context_synchronously
                            mostrarAlertas(context, response.mensaje!);

                          }else{
                            // ignore: use_build_context_synchronously
                            CustomAlert.showAlertYesNo(context, 'Atencion', 'El documento no esta registrado. \n Desea Registrarlo?', 'crear_conductor_page_cargo');
                          }

                        }
                        autorizadoProvider.isLoading = false;

                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)
                      ),
                      child: const Text("Conductor", style: TextStyle(color: Colors.white)),
                    )
                  : const _DocumentEmpty()
              : const DocumentInformation()
          ],
        ),
      ),
    );
  }
}

class _DocumentEmpty extends StatelessWidget{
  const _DocumentEmpty({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * .15),
      width: double.infinity,
      height: size.height * .4,
      alignment: Alignment.center,
      child: SvgPicture.asset("assets/svgs/driver-no-found.svg", fit:  BoxFit.fill),
    );
  }
}

class _DriverIsWhitin extends StatelessWidget{
  const _DriverIsWhitin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * .15),
      width: double.infinity,
      height: size.height * .4,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(child: SvgPicture.asset("assets/svgs/driver-no-found.svg", height: size.height * .25)),
          const Text('El conductor se encuentra adentro de la planta'),
        ],
      ),
    );
  }
}

mostrarAlertas( BuildContext context, String label ){
  return showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text("Informacion"),
        content: Text(label.toLowerCase()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Aceptar"),
          )
        ],
      );
    }
  );
}
