import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/entities/photo_vehicle_position.dart';
import 'package:solgis/projects/cargo/core/helpers/validinting_movement_output.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class PhotosVehicleSalidaWidget extends StatelessWidget {

  const PhotosVehicleSalidaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    // final List<String> labelsText = [ "Delantera", "Derecho", "Trasera", "Izquierdo", "Cabina", "Guantera" ]; 

    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);
    final confProvider = Provider.of<ConfigProvider>(context);

    // final List<String> labelsText = [];
    final List<Map<String, int>> perfiles = [];

    if( confProvider.configuration!.photos!.delantera! )  perfiles.add({ "delantera" : 13 });
    if( confProvider.configuration!.photos!.derecho!   )  perfiles.add({ "derecho"   : 14 });
    if( confProvider.configuration!.photos!.trasera!   )  perfiles.add({ "trasera"   : 15 });
    if( confProvider.configuration!.photos!.izquierdo! )  perfiles.add({ "izquierdo" : 16 });
    if( confProvider.configuration!.photos!.cabina!    )  perfiles.add({ "cabina"    : 17 });
    if( confProvider.configuration!.photos!.guantera!  )  perfiles.add({ "guantera"  : 18 });
    if( confProvider.configuration!.photos!.carga!     )  perfiles.add({ "carga"     : 19 });

    return Column(
      children: [

        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          itemCount: perfiles.length,
          // itemCount: labelsText.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 170,
          ) , 
          // itemBuilder: ( _ , i) => _PhotoCard( labelText: labelsText[i], index: i ),
          itemBuilder: ( _ , i) => _PhotoCard( perfiles[i] ),
        ),

        //Boton
        Container(
          width: size.width * .9,
          height: size.height * .07,
          decoration: BoxDecoration(
            color: Colors.green, 
            borderRadius: BorderRadius.circular(10)
          ),
          child: TextButton(
            onPressed: ( outProvider.isLoading == false )
              ? () async {
                movementValiditingOut(context);
              }
              : null,
            child: ( outProvider.isLoading == false)
              ? const Text(
                  "Registrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                )
              : const Center(
                child: CircularProgressIndicator( color: Colors.white ),
              )
          ),
        ),

        SizedBox(height: size.height * .05)

      ],
    );

  }
}

  int getIndexPhotoFB( int index ){
    switch ( index ) {
      case 0:
        return  13;
      case 1:
        return  14;
      case 2:
        return  15;
      case 3:
        return  16;
      case 4:
        return  17;
      case 5:
        return  18;
      default:
        return 1;
    }
  }

  mostrarAlertas( BuildContext context, String label ){
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Informacion"),
          content: Text(label),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.pop(context), 
              child: const Text("Aceptar"),
            )
          ],
        );
      }
    );
  }

class _PhotoCard extends StatelessWidget {
  final Map<String, int> perfil;
  
  const _PhotoCard(this.perfil);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return Stack(

      children: [

        GestureDetector(

          onLongPress: ( outProvider.getPhotoVehiclePosition(perfil.values.first) == null )
          ? null
          : () {
            NDialog(
              title: Container(),
              content: const Text("¿Esta seguro que deseas eliminar?"),
              actions: <Widget>[
                TextButton(child: const Text("No"), onPressed: () => Navigator.pop(context)),
                TextButton(child: const Text("Si"), onPressed: () {
                  outProvider.deletePhotoVehiclePosition(perfil.values.first);
                  Navigator.pop(context);
                }  ),
              ],  
            ).show(context);
          },

          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final  XFile? pickedFile = await picker.pickImage( source: ImageSource.camera);
            if(pickedFile != null) {
              final PhotoVehiclePosition photoVehiclePosi = PhotoVehiclePosition(
                file: pickedFile,
                position: perfil.values.first
              );
              outProvider.setPhotoVehiclePosition(photoVehiclePosi);
            }
          },

          child: Container(
            width:  size.width * .35,
            height: size.height * .15,
            margin: EdgeInsets.symmetric(vertical: size.height * .01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            child: ( outProvider.getPhotoVehiclePosition(perfil.values.first) == null)
              ? Icon( Icons.add, size: size.aspectRatio * 150 )
              : InkWell(

                  onTap: (){

                    final image = File(outProvider.getPhotoVehiclePosition(perfil.values.first).file!.path);
                    showCupertinoModalPopup(
                      context: context, builder: (context){

                        return Center(
                          child: SizedBox(
                            height: size.height * .5,
                            width:  size.width * .5,
                            child: PhotoView(
                              imageProvider: FileImage(image),
                            ),
                          ),
                        );

                      }
                    );
                  },

                  child: SizedBox.expand(
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        fit: BoxFit.cover,
                        File(
                          outProvider.getPhotoVehiclePosition(perfil.values.first).file!.path,
                        ), 
                      ),
                    )
                  ),
                ),
          ),

        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              perfil.keys.first ,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],

    );

  }

}

class PhotoCard extends StatelessWidget {
  final int index;
  final String labelText;
  
  const PhotoCard({
    Key? key, 
    required this.labelText, 
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return Stack(

      children: [

        GestureDetector(

          onLongPress: ( outProvider.getPhotoVehiclePosition(index) == null )
          ? null
          : () {
            NDialog(
              title: Container(),
              content: const Text("¿Esta seguro que deseas eliminar?"),
              actions: <Widget>[
                TextButton(child: const Text("No"), onPressed: () => Navigator.pop(context)),
                TextButton(child: const Text("Si"), onPressed: () {
                  outProvider.deletePhotoVehiclePosition(index);
                  Navigator.pop(context);
                }  ),
              ],  
            ).show(context);
          },

          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final  XFile? pickedFile = await picker.pickImage( source: ImageSource.camera);
            if(pickedFile != null) {
              final PhotoVehiclePosition photoVehiclePosi = PhotoVehiclePosition(
                file: pickedFile,
                position: index
              );
              outProvider.setPhotoVehiclePosition(photoVehiclePosi);
            }
          },

          child: Container(
            width:  size.width * .35,
            height: size.height * .15,
            margin: EdgeInsets.symmetric(vertical: size.height * .01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            child: ( outProvider.getPhotoVehiclePosition(index) == null)
              ? Icon( Icons.add, size: size.aspectRatio * 150 )
              : InkWell(

                onTap: (){

                  final image = File(outProvider.getPhotoVehiclePosition(index).file!.path);
                  showCupertinoModalPopup(
                    context: context, builder: (context){

                      return Center(
                        child: SizedBox(
                          height: size.height * .5,
                          width:  size.width * .5,
                          child: PhotoView(
                            imageProvider: FileImage(image),
                          ),
                        ),
                      );

                    }
                  );
                },

                child: SizedBox.expand(
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      fit: BoxFit.cover,
                      File(
                        outProvider.getPhotoVehiclePosition(index).file!.path,
                      ), 
                      // width: size.width * .35,
                      // height: size.height * .15,
                    ),
                  )
                )
,
                ),
          ),

        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              labelText ,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],

    );

  }

}