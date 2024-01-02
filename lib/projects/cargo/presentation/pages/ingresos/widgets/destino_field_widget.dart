import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class DestinoFieldWidget extends StatelessWidget {

  const DestinoFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      alignment: Alignment.center,

      child: CustomInputField(
        textinputController: entryProvider.destinoController,
        hinttext: "Ingrese el destino",
        keyboardType: TextInputType.text, 
        labelText: 'Destino',
      ),
    );
  }
}