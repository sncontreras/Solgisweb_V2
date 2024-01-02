import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/presentation/widgets/photo_list_tile.dart';
import 'package:solgis/projects/cargo/domain/entities/guia.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
// import 'package:solgis/projects/people/domain/models/guia_model.dart';

class ModalFitGuiaOut extends StatelessWidget {

  const ModalFitGuiaOut({super.key});

  @override
  Widget build(BuildContext context) {

    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);
    final size          = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_chart),
  
          onPressed: () {
  
            showDialog(
              context: context, 
              builder: ( context ) {
  
                return AlertDialog(
  
                  title: const Text("Guia"),
                  content: SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,
  
                    child: Row(
                      children: [
  
                        Expanded(
                          child: TextField(
                            onChanged: (value) => outProvider.guiaTemp = value ,
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

                              if(pickedFile != null) outProvider.photoTemp = pickedFile; 

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

                        if( outProvider.guiaTemp != '' ){
                          final guia = Guia( descripcion: outProvider.guiaTemp, file: outProvider.photoTemp);
                          outProvider.setGuia(guia);
                          outProvider.guiaTemp     = "";
                          outProvider.photoTemp = null;
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
          itemCount: outProvider.selectedGuias.length,
          itemBuilder: ( _, int i) {
            Guia guia =  outProvider.selectedGuias[i];
            return PhotoListTile(  
              description: guia.descripcion, 
              photo: guia.file, 
              index: i,
              onpressedDeleted: ()=> outProvider.deleteGuia(i),
            );
          }
        )

      )
    );

  }

}