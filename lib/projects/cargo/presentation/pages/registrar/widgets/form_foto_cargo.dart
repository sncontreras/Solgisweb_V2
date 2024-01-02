import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/home/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/registrar_form_cargo.dart';

class RegistrarFormFotoCargo extends StatelessWidget {
  const RegistrarFormFotoCargo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final tipoProvider = Provider.of<RegisterProvider>(context);

    return const Stack(
      children: [
        HomePageBackGroundCargo(), // Imagen de fondo
        //MovimientoFotoPlaca(), // Contiene tus botones
      ],
    );
  }
}
