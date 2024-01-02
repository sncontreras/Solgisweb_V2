import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:solgis/projects/cargo/presentation/pages/driver/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/create_driver_provider.dart';

class CardImageDriver extends StatelessWidget {

  const CardImageDriver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<CreateDriverProvider>(context);
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      
      borderRadius:  BorderRadius.circular(25),

      child: SizedBox(

        width: size.width*0.5,
        height: size.height*0.3,
        
        child: Stack(

          children: [

            //FOTO
            SizedBox(
              width: double.infinity,
              height: size.height*0.5,
                child: ImageWidget(
                  urlimage:(driverProvider.foto==null)
                  ? null 
                  : driverProvider.foto!.path 
                ),
            ),  

            //CAMARA
            Positioned(

              top: size.height*0.001,
              right: size.width*0.06,

              child: IconButton(  

                icon:Icon(Icons.camera_alt, color: Colors.white, size: size.width*0.15),

                onPressed: () async {  
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 25,
                  );
                  if ( pickedFile == null )return;
                  driverProvider.updateImage(pickedFile.path);
                },
                
              ),
            )

          ],
        ),
      ),
    );

  }
}
