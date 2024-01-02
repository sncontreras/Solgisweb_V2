import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/entities/photo_vehicle_position.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/cargo/core/helpers/validating_movement.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/patrol/data/models/tiposfoto_model.dart';
import 'package:solgis/projects/patrol/data/services/tiposfoto_service.dart';
import 'package:solgis/projects/patrol/presentation/providers/registro_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/tipo_fotos_provider.dart';

class TomarFotosWidget extends StatelessWidget {
  const TomarFotosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map<String, int>> perfiles = [];
    final tiposfotoService = TiposFotoService();

    final tipoFotosProvider = Provider.of<TipoFotosProvider>(context);
    final registroProvider = Provider.of<RegistroProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * .08),
    
          //BOTON
          Container(
            width: size.width * .9,
            height: size.height * .07,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: TextButton(
                onPressed: (true)
                    ? () async {
                        movementValiditing(context);
                      }
                    : null,
                child: (true)
                    ? const Text(
                        "Registrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )),
          ),
    
          SizedBox(height: size.height * .05),
    
          FutureBuilder(
            future: tiposfotoService
                .getTiposFoto(registroProvider.bienTemp.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<TiposFotoDbModel>> snapshot) {
              if (!snapshot.hasData) {
                return ShimmerWidget(
                    width: size.width * 0.57, height: size.height * 0.04);
              }
              if (snapshot.data!.isEmpty) return Container();
              final tiposfoto = snapshot.data;
              perfiles.clear();
              for (final tipofoto in tiposfoto!) {
                if (tipofoto.codigoBien != null) {
                  //registroProvider.setPerfiles({"${tipofoto.nombre}": tipofoto.codigoBien ?? 15});
                  perfiles.add({"${tipofoto.nombre}": tipofoto.codigoBien ?? 15});
                  //perfiles.add({"${subbienes[0].nombre}": 15});
                }
              }
    
              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: perfiles.length,
                // itemCount: labelsText.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 170),
                // itemBuilder: ( _, i ) => _PhotoCard(  index: i , labelText: labelsText[i] ),
                itemBuilder: (_, i) => _PhotoCard(perfiles[i]),
              ); 
            },
          ),
    
          /* if (true)
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              itemCount: perfiles.length,
              // itemCount: labelsText.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 170),
              // itemBuilder: ( _, i ) => _PhotoCard(  index: i , labelText: labelsText[i] ),
              itemBuilder: (_, i) => _PhotoCard(perfiles[i]),
            ),*/
        ],
      ),
    );
  }

  Widget construirGridView(List<Map<String, int>> perfiles) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      itemCount: perfiles.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 170,
      ),
      itemBuilder: (_, i) => _PhotoCard(perfiles[i]),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final Map<String, int> perfil;
  const _PhotoCard(this.perfil);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        GestureDetector(
          onLongPress: (false)
              ? null
              : () {
                  NDialog(
                    title: Container(),
                    content: const Text("¿Esta seguro que deseas eliminar?"),
                    actions: <Widget>[
                      TextButton(
                          child: const Text("No"),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child: const Text("Si"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ).show(context);
                },
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              final PhotoVehiclePosition photoVehiclePosition =
                  PhotoVehiclePosition(
                      file: pickedFile, position: perfil.values.first);
            }
          },
          child: Container(
            width: size.width * .35,
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
                )),
            child: (true)
                ? Icon(Icons.add, size: size.aspectRatio * 150)
                : InkWell(
                    onTap: () {
                      final image = File(
                          'entryProvider.getPhotoVehiclePosition(perfil.values.first).file!.path');
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: SizedBox(
                                height: size.height * .5,
                                width: size.width * .5,
                                child: PhotoView(
                                  imageProvider: FileImage(image),
                                ),
                              ),
                            );
                          });
                    },
                    child: SizedBox.expand(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        fit: BoxFit.cover,
                        File(
                            'entryProvider.getPhotoVehiclePosition(perfil.values.first).file!.path'),
                      ),
                    )),
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
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              perfil.keys.first,
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

  const PhotoCard({Key? key, required this.labelText, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Stack(
      children: [
        GestureDetector(
          onLongPress: (entryProvider.getPhotoVehiclePosition(index) == null)
              ? null
              : () {
                  NDialog(
                    title: Container(),
                    content: const Text("¿Esta seguro que deseas eliminar?"),
                    actions: <Widget>[
                      TextButton(
                          child: const Text("No"),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child: const Text("Si"),
                          onPressed: () {
                            entryProvider.deletePhotoVehiclePosition(index);
                            Navigator.pop(context);
                          }),
                    ],
                  ).show(context);
                },
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              final PhotoVehiclePosition photoVehiclePosition =
                  PhotoVehiclePosition(file: pickedFile, position: index);
              entryProvider.setPhotoVehiclePosition(photoVehiclePosition);
            }
          },
          child: Container(
            width: size.width * .35,
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
                )),
            child: (entryProvider.getPhotoVehiclePosition(index) == null)
                ? Icon(Icons.add, size: size.aspectRatio * 150)
                : InkWell(
                    onTap: () {
                      final image = File(entryProvider
                          .getPhotoVehiclePosition(index)
                          .file!
                          .path);
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: SizedBox(
                                height: size.height * .5,
                                width: size.width * .5,
                                child: PhotoView(
                                  imageProvider: FileImage(image),
                                ),
                              ),
                            );
                          });
                    },
                    child: SizedBox.expand(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        fit: BoxFit.cover,
                        File(entryProvider
                            .getPhotoVehiclePosition(index)
                            .file!
                            .path),
                      ),
                    )),
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
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              labelText,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
