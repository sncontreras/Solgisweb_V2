import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class CarretaFieldOutWidget extends StatelessWidget {

  const CarretaFieldOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      alignment: Alignment.center,

      child: CustomInputField(
        textinputController: outProvider.carretaController,
        hinttext: "Ingrese la carreta",
        keyboardType: TextInputType.text, 
        labelText: 'Carreta',
      ),
    );
  }
}