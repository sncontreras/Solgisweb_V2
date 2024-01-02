import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/people/domain/providers/salida_provider.dart';
import 'package:solgis/projects/people/presentation/pages/salidas/widgets/widgets.dart';

class GuiaFieldWidget extends StatelessWidget {
  const GuiaFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaProvider>(context);
    // final ingresoProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Stack(
      children: [

        GestureDetector(
          onTap: () => showBarModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            expand: false,
            builder: ( context ) => const ModalFitGuiaOut(),
          ),
          child: Container(
            width:  size.width  * .9,
            height: size.height * .065,
            margin: EdgeInsets.symmetric(vertical: size.height * .01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            // child: const Text("Ingrese las guias"),
            child: ( outProvider.selectedGuias.isEmpty)
              ? const Text("Ingrese las guias")
              : Text(outProvider.selectedGuias.length.toString())
          ),
        ),

        Positioned(
          left: 20,
          top : 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
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
