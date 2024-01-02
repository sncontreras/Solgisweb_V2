import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/personal_service.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/helpers/alert.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/custom_input.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

class VehiculoSalidaWidget extends StatefulWidget {

  const VehiculoSalidaWidget({super.key});

  @override
  State<VehiculoSalidaWidget> createState() => _VehiculoSalidaWidgetState();

}

class _VehiculoSalidaWidgetState extends State<VehiculoSalidaWidget> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      final vehProvider = Provider.of<VehicleProvider>(context, listen: false);
      final gProvider = Provider.of<GlobalProvider>(context, listen: false);
      vehProvider.verifyDriver( gProvider.relationModel.codigoServicio!, gProvider.relationModel.codigoCliente! );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final size           = MediaQuery.of(context).size;
    final outProvider    = Provider.of<SalidaAutorizadaProvider>(context);
    final gProvider      = Provider.of<GlobalProvider>(context);
    final driverProvider = Provider.of<DriverProvider>(context);
    final vehProvider    = Provider.of<VehicleProvider>(context);
    final vehicle = vehProvider.vehicleResponse;

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
                  textController: outProvider.documentController,
                  hinttext: 'Nº Documento',
                  keyboardType: TextInputType.text,
                  maxlength: 13,
                  width: size.width * .45,
                  height: size.height * .05,
                  dni: vehicle!.dni ?? '',
                ),

                IconButton(

                  onPressed: ( outProvider.isLoading )
                    ? null
                    : ()  async {
                      FocusScope.of(context).unfocus();
                      outProvider.isLoading = true;
                      outProvider.cleanDriverInformation();

                      final response = await PersonalService.validarDOI(
                        '', 
                        outProvider.documentController.text , 
                        '1', 
                        gProvider.relationModel.codigoServicio.toString() 
                      );

                      if( response.resultado == 'OK'){

                        driverProvider.driverResponse = response;
                        outProvider.hasDriver = true;

                      }else if(outProvider.documentController.text == ''){
                        // ignore: avoid_print
                        print('no hay nada');
                      }else{
                        // ignore: use_build_context_synchronously
                        CustomAlert.showAlertYesNo(context, 'Informacion', 'El documento no esta registrado. \n Deseas Registrarlo?', 'crear_conductor_page_cargo');
                      }
                      outProvider.isLoading = false;
                    },

                  icon: Icon(Icons.verified_outlined, color: Colors.green, size: size.width *  .1), 

                )

              ],
            ),

            SizedBox(height: size.height*0.03),

            ( outProvider.isLoading ) 
            ? Container(
              width: double.infinity,
              height: size.height * 0.45,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
            : ( driverProvider.driverResponse == null )
              ? ( vehProvider.iswithin )
                ? ( vehProvider.documentDriverwithin != '' )
                  ? TextButton(
                    onPressed: ()async{
                      FocusScope.of(context).unfocus();
                      outProvider.isLoading = true;
                      outProvider.cleanDriverInformation();
                      final response = await PersonalService.validarDOI(
                        '', 
                        vehProvider.documentDriverwithin, 
                        '1', 
                        gProvider.relationModel.codigoServicio.toString() 
                      );

                      if( response.resultado == 'OK' ){
                        driverProvider.driverResponse = response;
                        outProvider.hasDriver = true;
                        outProvider.documentController.text = response.nroDoi!;
                      } if( response.resultado == 'ERROR' ){

                        if( response.codPersTipo != 0 && response.codPers != -1 ){

                          // ignore: use_build_context_synchronously
                          mostrarAlertas(context, response.mensaje!);

                        }else{
                          // ignore: use_build_context_synchronously
                          CustomAlert.showAlertYesNo(context, 'Atencion', 'El documento no esta registrado. \n Desea Registrarlo?', 'crear_conductor_page_cargo');
                        }

                      }
                      outProvider.isLoading = false;
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)
                    ), 
                    child:  const Text("Conductor", style: TextStyle(color: Colors.white)),
                  )
                  : const _DocumentEmpty()
                : const _DriverIsWhitin()
              // : DocumentoInformacion()
              : const DocumentoInformacion()

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
          const Text('El conductor ya se fue'),
        ],
      ),
    );
  }
}
