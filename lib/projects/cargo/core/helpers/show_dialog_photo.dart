import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';

showDialogPhoto(BuildContext context, XFile? file, String textLabel, Function()? onpressed ) async {
  final size = MediaQuery.of(context).size;

  await NDialog(
    dialogStyle: DialogStyle(backgroundColor: const Color(0xFF999999)),
    title: Text(
      textLabel,
      style: const TextStyle( color: Colors.black), 
      maxLines: 1, 
      overflow: TextOverflow.ellipsis
    ),
    content: SizedBox(
      width: size.width*0.5,
      height: size.height*0.5,
      child:Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FutureBuilder(
                future: getImage(file!.path),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if(!snapshot.hasData){
                    return const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/gifs/loader-gris.gif'),
                    );
                  }
                  return Container(
                    child: snapshot.data!,
                  );
                }
              ),
            ),
          ),
          TextButton(
            onPressed: onpressed,
            child:  const Text('Eliminar', style: TextStyle(color: Colors.black)), 
          ),
        ],
      )
    )
  ).show(context);




}