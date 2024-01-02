import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:solgis/projects/people/domain/models/datos_acceso_movimiento_model.dart';

class ModalDataAccess extends StatelessWidget {
  final List<DatoAccesoMModel> data;

  const ModalDataAccess({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: data.length,
              itemBuilder: (_, int i) {
                DatoAccesoMModel d = data[i];
                return _ListTile(data: d);
              })),
    );
  }
}

class _ListTile extends StatelessWidget {
  final DatoAccesoMModel data;

  const _ListTile({required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (data.pathImage != null)
                    InkWell(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: SizedBox(
                                height: size.height * .5,
                                width: size.width * .5,
                                child: PhotoView(
                                  imageProvider: NetworkImage(data.pathImage!),
                                ),
                              ),
                            );
                          }
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 3),
                        ),
                        child:Image(image: NetworkImage(data.pathImage!)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data.descripcion ?? '',
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
