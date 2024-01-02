
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/custom_input_field.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class ContenedorFieldWidget extends StatelessWidget {

  const ContenedorFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Container(
      width: size.width,
      height: size.height * .1,
      margin: EdgeInsets.symmetric(vertical: size.height * .01),
      alignment: Alignment.center,

      child: Row(
        children: [
          Expanded(
            child: CustomInputField(
              textinputController: entryProvider.containerController,
              hinttext: "Ingrese el Contenedor",
              keyboardType: TextInputType.text, 
              labelText: 'Contenedor',
            ),
          ),
          IconButton(
            onPressed: ( entryProvider.containerPhoto != null )
              ? () => showDialogPhoto(
                context, 
                entryProvider.containerPhoto!, 
                'Foto del Contenedor',
                (){
                  entryProvider.containerPhoto = null;
                  Navigator.pop(context);
                }
              )
              : () async {
                final ImagePicker picker = ImagePicker();
                final  XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if(pickedFile != null) entryProvider.containerPhoto = pickedFile; 
              }, 

            icon: FaIcon( 
              FontAwesomeIcons.camera, 
              color: (entryProvider.containerPhoto != null)
              ? Colors.green
              : Colors.black, 
            ),

          )
        ], 
      ),

    );
  }
}


