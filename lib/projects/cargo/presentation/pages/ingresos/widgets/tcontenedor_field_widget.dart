import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:solgis/projects/cargo/domain/objetos/objetos.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class TContenedorFieldWidget extends StatelessWidget {

  const TContenedorFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size =  MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Stack(

      children: [

        GestureDetector(
          onTap: () async {
            await showMaterialModalBottomSheet(
              context: context,
              expand: false,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Material(
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: options.map(
                        (option) => ListTile(
                          title: Text(option.tamanio.toString()),
                          onTap:  () {
                            entryProvider.selectedOptionRadio = option;
                            Navigator.pop(context);
                          } 
                        )
                      ).toList(),
                    ),
                  )
                );
              }
            );
          },
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
            // child:const Text("Seleccione el tamaño del contenedor"),
            child: ( entryProvider.selectedOptionRadio.codeOptionRadio == null )
              ? const Text("Seleccione el tamaño del contenedor")
              : Text(entryProvider.selectedOptionRadio.tamanio.toString())
          ),
        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
            child: const Text(
              'T. Contenedor',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],
    );

  }
}



