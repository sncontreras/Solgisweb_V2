import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class PrecintoFieldOutWidget extends StatelessWidget {

  const PrecintoFieldOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final  size         =  MediaQuery.of(context).size;
    final  outProvider  = Provider.of<SalidaAutorizadaProvider>(context);

    return Stack(
      
      children: [

        GestureDetector(

          onTap: () => showBarModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            expand: false,
            builder: ( _ ) => const ModalFitPrecinto(),
          ),

          child: Container(
            width:  size.width * .9,
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
            child: ( outProvider.selectedPrecintos.isEmpty)
              ? const Text("Ingrese los Precintos")
              : Text(outProvider.selectedPrecintos.length.toString())
          ),

        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
            child: const Text(
              'Precintos',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],
    );

  }
}