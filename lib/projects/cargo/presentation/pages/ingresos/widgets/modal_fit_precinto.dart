import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:solgis/projects/cargo/domain/entities/guia.dart';
import 'package:solgis/projects/cargo/domain/entities/precinto.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/photo_guia_list_tile.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class ModalFitPrecinto extends StatelessWidget {
  const ModalFitPrecinto({super.key});


  @override
  Widget build(BuildContext context) {

    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_chart),

          onPressed: () {

            showDialog(
              context: context, 
              builder: ( context ) {

                return AlertDialog(

                  title: const Text("Precinto"),
                  content: SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,

                    child: Row(
                      children: [

                        Expanded(
                          child: TextField(
                            onChanged: (value) => entryProvider.precintoTemp = value ,
                          )
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () async {

                              final ImagePicker picker = ImagePicker();

                              final  XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.camera,
                              );

                              if(pickedFile != null) entryProvider.precintoPhotoTemp = pickedFile; 

                            },
                            child: const Icon(Icons.camera)
                          )
                        )

                      ],
                    ),
                  ),

                  actions: [
                    TextButton(
                      onPressed: ()  {

                        if( entryProvider.precintoTemp != '' ){
                          final precinto = Precinto( descripcion: entryProvider.precintoTemp, file: entryProvider.precintoPhotoTemp);
                          entryProvider.setPrecinto(precinto);
                          entryProvider.precintoTemp = "";
                          entryProvider.precintoPhotoTemp = null;
                        }

                        Navigator.pop(context);

                      }, 
                      child: const Text("Agregar")
                    )
                  ],

                );

              },
            );

          }, 

        ),

        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entryProvider.selectedPrecintos.length,
          itemBuilder: ( _, int i) {
            Precinto precinto = entryProvider.selectedPrecintos[i];
            return PhotoListTile(
              description: precinto.descripcion,
              photo: precinto.file, 
              index: i,
              onpressedDeleted: ()=> entryProvider.deletePrecinto(i),
            );
          }
        )

      )
    );

  }
}