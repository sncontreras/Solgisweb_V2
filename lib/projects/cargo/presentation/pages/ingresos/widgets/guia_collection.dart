import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:provider/provider.dart';

//import 'package:image_picker/image_picker.dart';
import 'package:solgis/projects/cargo/core/utils/show_dialog.dart';
//import 'package:solgis/projects/people/domain/providers/ingreso_autorizado_provider.dart';

class GuiaCollection extends StatefulWidget {
  const GuiaCollection({Key? key}) : super(key: key);

  @override
  State<GuiaCollection> createState() => _GuiaCollectionState();
}

class _GuiaCollectionState extends State<GuiaCollection> {

  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    () async {
      _permissionStatus = await Permission.storage.status;
      if( _permissionStatus != PermissionStatus.granted ) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_chart),
        onPressed: () async {
          await mostrarDialogParaGuia(context);
        // _onGuiaButtonPressed(context,ImageSource.camera);
        }, 
      ),

      // body: Consumer<IngresoAutorizadoProvider>(
      //   builder: (_, photoFile, __) {
      //     return SizedBox(
      //       height: 350,
      //       child: ListView.builder(
      //         padding: const EdgeInsets.all(8),
      //         itemCount: photoFile.selectedGuias.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           XFile? file = photoFile.selectedGuias[index].file;
      //           return ListPhoto(file!.name, file.path, index);
      //         }
      //       )
      //     );
      //   }
      // )

    );

  }



}
