import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

mostrarDialogParaGuia(BuildContext context) async {

  await showDialog(
    context: context, 
    builder: ( context ) {

      final size = MediaQuery.of(context).size;
      // final entryProvider = Provider.of<IngresoAutorizadoProvider>(context, listen: false);
      return AlertDialog(

        title: const Text("Guia"),
        content: SizedBox(
          width: size.width * .8,
          height: size.height * .1,

          child: Row(
            children: [

              const Expanded(
                child: TextField(
                  // onChanged: (value) => entryProvider.guiaTemp = value ,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();

                    try {
                      final  XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        maxWidth: 1080,
                        maxHeight: 1080,
                        imageQuality: 100,
                        preferredCameraDevice: CameraDevice.rear
                      );

                      // ignore: avoid_print
                      if(pickedFile != null) print(pickedFile.path);

                      // if(pickedFile != null) entryProvider.photoTemp = pickedFile; 

                    } catch (e) {
                      debugPrint(e.toString());
                    }

                  },
                  child: const Icon(Icons.camera)
                )
              )

            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: (){

              // if(entryProvider.guiaTemp != ''){
              //   final guia = Guia(
              //     descripcion: entryProvider.guiaTemp,
              //     file: entryProvider.photoTemp
              //   );

              // entryProvider.setGuia(guia);
              // }

              // print(entryProvider.selectedGuias.length);

            }, 
            child: const Text("Agregar")
          )
        ],

      );
    },
  );

}

