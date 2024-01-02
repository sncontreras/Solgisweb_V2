import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/custom_input_field.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class ContenedorFieldOutWidget extends StatelessWidget {

  const ContenedorFieldOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return Container(
      width: size.width,
      height: size.height * .1,
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      alignment: Alignment.center,

      child: Row(
        children: [
          Expanded(
            child: CustomInputField(
              textinputController: outProvider.containerController,
              hinttext: "Ingrese el Contenedor",
              keyboardType: TextInputType.text, 
              labelText: 'Contenedor',
            ),
          ),
          IconButton(
            onPressed: ( outProvider.containerPhoto != null )
              ? () => showDialogPhoto(
                context, 
                outProvider.containerPhoto!, 
                'Foto del Contenedor',
                (){
                  outProvider.containerPhoto = null;
                  Navigator.pop(context);
                }
              )
              : () async {
                final ImagePicker picker = ImagePicker();
                final  XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if(pickedFile != null) outProvider.containerPhoto = pickedFile; 
              }, 

            icon: FaIcon( 
              FontAwesomeIcons.camera, 
              color: (outProvider.containerPhoto != null)
              ? Colors.green
              : Colors.black, 
            ),

          )
        ], 
      ),

    );
  }
}


