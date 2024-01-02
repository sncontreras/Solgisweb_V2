import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/projects/cargo/presentation/providers/create_vehicle_provider.dart';

class CardImageVehicle extends StatelessWidget {

  const CardImageVehicle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<CreateVehicleProvider>(context);
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
              child: FutureBuilder(
                future: getImage( 
                  (vehicleProvider.foto==null)
                  ? null 
                  : vehicleProvider.foto!.path, 
                  create: true 
                ),
                builder: (context,AsyncSnapshot<Widget> snapshot) {
                  if(!snapshot.hasData) return const CircularProgressIndicator();
                  return snapshot.data!;
                },
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
                  vehicleProvider.updateImage(pickedFile.path);
                },
                
              ),
            )

          ],
        ),
      ),
    );

  }
}
