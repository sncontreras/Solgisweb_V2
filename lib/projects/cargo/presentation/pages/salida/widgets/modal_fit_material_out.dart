import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/presentation/widgets/photo_list_tile.dart';
import 'package:solgis/projects/people/domain/models/value_thing_model.dart';
import 'package:solgis/projects/people/domain/providers/salida_provider.dart';

class ModalFitMaterialOut extends StatelessWidget {

  const ModalFitMaterialOut({super.key});

  @override
  Widget build(BuildContext context) {

    final outProvider = Provider.of<SalidaProvider>(context);
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

                  title: const Text("Material de Valor"),
                  content: SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,

                    child: Row(
                      children: [

                        Expanded(
                          child: TextField(
                            onChanged: (value) => outProvider.guia = value ,
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
  
                              if(pickedFile != null) outProvider.fotoGuia = pickedFile; 
  
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
  
                        if( outProvider.guia != '' ){
                          final thing = ValueThing( description: outProvider.guia, file: outProvider.fotoGuia);
                          outProvider.setThing(thing);
                          outProvider.materialValor     = "";
                          outProvider.fotoMaterialValor = null;
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
          itemCount: outProvider.selectedThings.length,
          itemBuilder: ( _, int i) {
            ValueThing thing =  outProvider.selectedThings[i];
            return PhotoListTile(  
              description: thing.description, 
              photo: thing.file, 
              index: i,
              onpressedDeleted: ()=> outProvider.deleteThing(i),
            );
          }
        )
  
      )
    );
  }
}