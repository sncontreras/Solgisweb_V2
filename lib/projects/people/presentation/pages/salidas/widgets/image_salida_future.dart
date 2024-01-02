import 'package:flutter/material.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';


class ImageSalidaFuture extends StatelessWidget{

  final String? urlimage;
  final bool? onlyShow;

  const ImageSalidaFuture({super.key, 
    this.urlimage, 
    this.onlyShow=false
  });

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(

      future:getImage(urlimage, create: true),

      builder: (context,AsyncSnapshot<Widget> snapshot) {

        if(!snapshot.hasData) return const CircularProgressIndicator();

        if(snapshot.hasData) return snapshot.data!;

        return Container();

      },

    );

  }
}
