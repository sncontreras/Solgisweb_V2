// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/presentation/widgets/photo_list_tile.dart';
import 'package:solgis/projects/people/domain/models/value_thing_model.dart';
import 'package:solgis/projects/people/domain/providers/ingreso_autorizado_provider.dart';

class ModalFitThing extends StatelessWidget {

  const ModalFitThing({super.key});

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
                  title: const Text("Materiales de valor"),
                  content: SizedBox(
                    width: size.width * .8,
                    height: size.height * .1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => entryProv.material_valor = value,
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
                              if(pickedFile != null) entryProv.fotoMaterialValor = pickedFile;
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
                        if( entryProv.material_valor != '' ){
                          final thing = ValueThing( description: entryProv.material_valor, file: entryProv.fotoMaterialValor);
                          entryProv.setThing(thing);
                          entryProv.material_valor     = "";
                          entryProv.fotoMaterialValor  = null;
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
          itemCount: entryProv.selectedThings.length,
          itemBuilder: (_, int i) {
            ValueThing thing =  entryProv.selectedThings[i];
            return PhotoListTile(
              description: thing.description,
              photo: thing.file,
              index: i,
              onpressedDeleted: ()=> entryProv.deleteThing(i),
            );
          }
        )
      )
    );
  }
}
