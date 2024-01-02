import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/presentation/widgets/photo_list_tile.dart';
import 'package:solgis/projects/people/domain/models/guia_model.dart';
import 'package:solgis/projects/people/domain/providers/ingreso_autorizado_provider.dart';

class ModalFitGuia extends StatelessWidget {
  const ModalFitGuia({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final entryProv = Provider.of<IngresoAutorizadoProvider>(context);
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_chart),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Guias"),
                  content: SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => entryProv.guia = value ,
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickedFile  = await picker.pickImage(
                                source: ImageSource.camera,
                              );
                              if(pickedFile != null) entryProv.fotoGuia = pickedFile;
                            },
                            child: const Icon(Icons.camera)
                          )
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if( entryProv.guia != '' ){
                          final guia = Guia( description: entryProv.guia, file: entryProv.fotoGuia);
                          entryProv.setGuia(guia);
                          entryProv.guia = "";
                          entryProv.fotoGuia = null;
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
          itemCount: entryProv.selectedGuias.length,
          itemBuilder: (_, int i) {
            Guia guia =  entryProv.selectedGuias[i];
            return PhotoListTile(
              description: guia.description,
              photo: guia.file,
              index: i,
              onpressedDeleted: ()=> entryProv.deleteGuia(i),
            );

          }
        )
      )
    );
  }
}
