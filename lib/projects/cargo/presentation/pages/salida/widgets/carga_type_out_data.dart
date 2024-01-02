import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/widgets.dart';

import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';

class CargaTypeOutDataWidget extends StatelessWidget {

  const CargaTypeOutDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final configProvider = Provider.of<ConfigProvider>(context);
    final optionsList = configProvider.fieldCargaType; 
    final size = MediaQuery.of(context).size;

    if( optionsList == null ) {
      return Container(
        height: size.height * 0.55,
        alignment: Alignment.center, 
        child: const Text(
          "Seleccione un tipo de carga"
        )
      );
    }

    final inputsIndex = optionsList.map((input) => input.codigoCampoForm ).toList();

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: SingleChildScrollView(

        child: (optionsList.isEmpty)

        ? const Center(child: Text("No hay campos habilitados"))

        : Column(

          children: [

            if( inputsIndex.contains(1) )
              const CarretaFieldOutWidget(),

            if( inputsIndex.contains(2) )
              const CargaFieldOutWidget(),

            if( inputsIndex.contains(3) )
              const OrigenFieldOutWidget(),

            if( inputsIndex.contains(4) )
              const GuiaFieldOutWidget(),

            if( inputsIndex.contains(5) )
              const ContenedorFieldOutWidget(),

            if( inputsIndex.contains(6) )
              const TContenedorFieldOutWidget(),

            if( inputsIndex.contains(7) )
              const GuiaTranspFieldOutWidget(),

            if( inputsIndex.contains(8) )
              const PrecintoFieldOutWidget(),

            if( inputsIndex.contains(9) )
              const BookingFieldOutWidget(),

            if( inputsIndex.contains(10) )
              const ContratoFieldOutWidget(),

            if( inputsIndex.contains(11)  )
              const OpLogFieldOutWidget(),

          ],

        ),

      ),

    );

  }
}