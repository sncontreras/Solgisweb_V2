import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class KilometrajeFieldOutWidget extends StatelessWidget {

  const KilometrajeFieldOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      alignment: Alignment.center,

      child: CustomInputField(
        textinputController: outProvider.kilometrajeController,
        hinttext: "Ingrese el kilometraje",
        keyboardType: TextInputType.number, 
        labelText: 'Kilometraje',
      ),
    );
  }
}