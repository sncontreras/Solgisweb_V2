import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/domain/entities/guia.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/photo_guia_list_tile.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class ModalFitGuia extends StatelessWidget {
  const ModalFitGuia({super.key});


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

                  title: const Text("Guia"),
                  content: SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,
  
                    child: Row(
                      children: [
  
                        Expanded(
                          child: TextField(
                            onChanged: (value) => entryProvider.guiaTemp = value ,
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
  
                              if(pickedFile != null) entryProvider.photoTemp = pickedFile; 
  
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
  
                        if( entryProvider.guiaTemp != '' ){
                          final guia = Guia( descripcion: entryProvider.guiaTemp, file: entryProvider.photoTemp);
                          entryProvider.setGuia(guia);
                          entryProvider.guiaTemp = "";
                          entryProvider.photoTemp = null;
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
          itemCount: entryProvider.selectedGuias.length,
          itemBuilder: ( _, int i) {
            Guia guia =  entryProvider.selectedGuias[i];
            return PhotoListTile(  
              description: guia.descripcion, 
              photo: guia.file, 
              index: i,
              onpressedDeleted: ()=> entryProvider.deleteGuia(i),
            );
          }
        )
  
      )
    );
  }
}