import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class GuiaFieldWidget extends StatelessWidget {

  const GuiaFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final    size       =  MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Stack(
      
      children: [

        GestureDetector(
          onTap: () => showBarModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            expand: false,
            builder: ( context ) => const ModalFitGuia(),
          ),
          child: Container(
            width:  size.width * .9,
            height: size.height * .065,
            margin: EdgeInsets.symmetric( vertical: size.height * .01 ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            child: ( entryProvider.selectedGuias.isEmpty)
              ? const Text("Ingrese las guias")
              : Text(entryProvider.selectedGuias.length.toString())
          ),
        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xFFFAFAFA),
            child: const Text(
              'Guias',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],
    );


  }

}