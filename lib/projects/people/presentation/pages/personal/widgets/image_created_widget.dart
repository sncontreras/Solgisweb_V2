import 'package:flutter/material.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';

class ImageCreatedWidget extends StatelessWidget{

  final String? urlimage;

  const ImageCreatedWidget({super.key, this.urlimage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(urlimage, create: true),
      builder: (context,AsyncSnapshot<Widget> snapshot) {
        if(!snapshot.hasData) return const CircularProgressIndicator();
        // if(snapshot.hasData) return snapshot.data!;
        return snapshot.data!;
      },
    );
  }
}