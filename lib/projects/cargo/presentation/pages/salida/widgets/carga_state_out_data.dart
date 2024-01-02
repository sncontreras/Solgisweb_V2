import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';

class CargaStateOutDataWidget extends StatefulWidget {
  const CargaStateOutDataWidget({super.key});
  @override
  State<CargaStateOutDataWidget> createState() => _CargaStateOutDataWidgetState();
}

class _CargaStateOutDataWidgetState extends State<CargaStateOutDataWidget> {

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_){
        _getInputs();
      }
    );

  }

  _getInputs() async {
    final  confProv = Provider.of<ConfigProvider>(context, listen: false);
    final gProv     = Provider.of<GlobalProvider>(context, listen: false);
    if( confProv.configuration?.configuration!.codeConfig == 2 ){
      await confProv.getInputsForCargaState(true, gProv.relationModel.codigoCliente!, gProv.relationModel.codigoServicio.toString() );
    }
  }


  @override
  Widget build(BuildContext context) {

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CargaFieldWidget(),
          InputsContainer(),
        ],
      ),
    );

  }
}



class InputsContainer extends StatelessWidget {

  const InputsContainer({super.key});

  @override
  Widget build(BuildContext context) {

    final configProvider = Provider.of<ConfigProvider>(context);
    final optionsList = configProvider.fieldCargaState; 
    final size = MediaQuery.of(context).size;

    if( optionsList == null ) {
      return Container(
        height: size.height * 0.55,
        alignment: Alignment.center, 
        child: const Text(
          "Seleccione un estado de carga"
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

          ],

        ),

      ),

    );

    
  }
}