import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/utils/icons_stepper.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/ingresos_pages.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/initalized_entry_data.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/vehiculo_ingreso_widget.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class IngresoAutorizadoCargoPage extends StatelessWidget {

  const IngresoAutorizadoCargoPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final consulta = ModalRoute.of(context)!.settings.arguments as ConsultaModelCargo;
    
    return IngresoCargoPage(
      titleIngreso: 'INGRESO AUTORIZADO',
      colorAppBar: Colors.green,
      body: const  _IngresoAutorizadoBody(),
      /*registrarFunction: () async {
        validatingFieldsEntryMovCargo(context, consulta);
      },*/
    ); 
  }

}

class _IngresoAutorizadoBody extends StatelessWidget {

  const _IngresoAutorizadoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const VehicleContainer(),
          SizedBox(height: size.height * .01),
          const Text('TIPO DE CARGA', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold )),
          SizedBox(height: size.height*0.01),
          const ContainerCargaType(),
          IconStepper(
            enableNextPreviousButtons: false,
            icons: getIcons(),
            enableStepTapping: entryProvider.hasDriver,
            activeStep: entryProvider.indexStep,
            onStepReached: ( index ) {
              if ( entryProvider.hasDriver ) entryProvider.indexStep = index;
            }
          ),
          const SelectedWidget(),
        ],
      ),
    );

  }
}

class SelectedWidget extends StatelessWidget {

  const SelectedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ingresoProvider = Provider.of<IngresoAutorizadoProvider>(context);

    switch (ingresoProvider.indexStep) {
      case 0:
        return const VehiculoIngresoWidget();

      case 1:
        return const InitializedEntryData();

      case 2:
        return const PhotosVehicleWidget();

      default:
        return const VehiculoIngresoWidget();
    }
  }

}
