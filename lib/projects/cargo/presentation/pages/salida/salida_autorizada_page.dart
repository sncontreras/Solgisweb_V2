import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/data/services/movement_service.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/core/utils/icons_stepper.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

class SalidaAutorizadaCargoPage extends StatefulWidget {

  const SalidaAutorizadaCargoPage({super.key});

  @override
  State<SalidaAutorizadaCargoPage> createState() => _SalidaAutorizadaCargoPageState();
}

class _SalidaAutorizadaCargoPageState extends State<SalidaAutorizadaCargoPage> {

  @override
  void initState() {
    Future.delayed( Duration.zero ).then(
      (_) {
        final gProvider        = Provider.of<GlobalProvider>(context, listen: false);
        final vehicleProvider  = Provider.of<VehicleProvider>(context, listen: false);
        MovementService.getLazyEntry(context, gProvider.relationModel.codigoServicio!, vehicleProvider.vehicleResponse!.codigoVehiculo!);
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size           = MediaQuery.of(context).size;
    final driverProvider = Provider.of<DriverProvider>(context);
    final outProvider    = Provider.of<SalidaAutorizadaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          'SALIDA AUTORIZADA',
          style: TextStyle(
            fontSize: size.width * .07,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: BackButton(
          onPressed: () {
            outProvider.cleanDriverInformation();
            outProvider.cleanEntryData();
            outProvider.cleanPhotosVehicle();
            driverProvider.cleanValidationPerson();
            Navigator.pop(context);
          },
        )
      ),
      body: const _SalidaAutorizadaBody(),
    );

  }
}

class _SalidaAutorizadaBody extends StatelessWidget {

  const _SalidaAutorizadaBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const VehicleContainerSalida(),
          IconStepper(
            enableNextPreviousButtons: false,
            enableStepTapping: outProvider.hasDriver,
            icons: getIcons(),
            activeStep: outProvider.indexStep ,
            onStepReached: (index) {
              if ( outProvider.hasDriver ) outProvider.indexStep = index;
            }
          ),
          const _SelectedWidget(),
        ],
      ),
    );

  }
}


class _SelectedWidget extends StatelessWidget {

  const _SelectedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    switch ( outProvider.indexStep ) {
      case 0:
        return const VehiculoSalidaWidget();
      case 1:
        return const InitializedOutData();
      case 2:
        return const PhotosVehicleSalidaWidget();
      default:
        return const VehiculoSalidaWidget();
    }
  }
}
