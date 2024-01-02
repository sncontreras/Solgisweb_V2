import 'package:flutter/material.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';


class ImageWidget extends StatelessWidget{

  final String? urlimage;

  const ImageWidget({super.key, this.urlimage});

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(

      future: getImage( urlimage, create: true ),

      builder: (context,AsyncSnapshot<Widget> snapshot) {
        if(!snapshot.hasData) return const CircularProgressIndicator();
        return snapshot.data!;
      },

    );

  }

}