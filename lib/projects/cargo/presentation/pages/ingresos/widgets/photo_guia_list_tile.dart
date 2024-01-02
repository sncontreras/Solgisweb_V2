
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class PhotoListTile extends StatelessWidget {

  final String description;
  final XFile? photo;
  final int index;
  Function()? onpressedDeleted;
  
  
  PhotoListTile({
    Key? key, 
    required this.description, 
    this.photo,
    required this.index,
    this.onpressedDeleted,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  if(photo != null)

                    InkWell(
                      onTap: (){

                        final image = File(photo!.path);
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

                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 3),
                        ),
                        child:  Image.file(File(photo!.path), width:39,height: 50),
                      ),

                    ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(description, style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                  ),

                  TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.transparent,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onPressed: ()  => entryProvider.deleteGuia(index),
                    onPressed: onpressedDeleted,
                    icon: const Icon(Icons.delete_forever,color: Colors.red),
                    label: const Text(''),
                  )

                ],
              )
              
            ),
          ),
        ),
      ),
    );
  }

}