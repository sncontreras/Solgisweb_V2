import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';

class CargaTypeEntryDataWidget extends StatelessWidget {

  const CargaTypeEntryDataWidget({Key? key}) : super(key: key);

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
              const CarretaFieldWidget(),

            if( inputsIndex.contains(2) )
              const CargaFieldWidget(),

            if( inputsIndex.contains(3) )
              const OrigenFieldWidget(),

            if( inputsIndex.contains(4) )
              const GuiaFieldWidget(),

            if( inputsIndex.contains(5) )
              const ContenedorFieldWidget(),

            if( inputsIndex.contains(6) )
              const TContenedorFieldWidget(),

            if( inputsIndex.contains(7) )
              const GuiaTranspFieldWidget(),

            if( inputsIndex.contains(8) )
              const PrecintoFieldWidget(),

            if( inputsIndex.contains(9) )
              const BookingFieldWidget(),

            if( inputsIndex.contains(10) )
              const ContratoFieldWidget(),

            if( inputsIndex.contains(11)  )
              const OpLogFieldWidget(),

            if( inputsIndex.contains(20)  )
              const MaterialsFieldWidget(),

          ],

        ),

      ),

    );

  }
}