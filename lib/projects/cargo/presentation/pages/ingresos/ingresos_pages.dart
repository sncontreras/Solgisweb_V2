import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

// ignore: must_be_immutable
class IngresoCargoPage extends StatelessWidget {

  String titleIngreso;
  Color colorAppBar;
  Widget body ;
  //detalle cargo
  Function()? registrarFunction;


  // ignore: use_key_in_widget_constructors
  IngresoCargoPage({
    required this.titleIngreso,
    required this.colorAppBar,
    required this.body,
    //required this.registrarFunction,    
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final driverProvider = Provider.of<DriverProvider>(context);
    final vehProvider = Provider.of<VehicleProvider>(context);


    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorAppBar,
        title: Text(
          titleIngreso,
          style: TextStyle(
            fontSize: size.width * .07,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: BackButton(
          onPressed: () {
            entryProvider.cleanDriverInformation();
            entryProvider.cleanEntryData();
            entryProvider.cleanPhotosVehicle();
            driverProvider.cleanValidationPerson();
            vehProvider.cleandata();
            Navigator.pop(context);
          },

        )

      ),
      body: body,

    );
  }
}