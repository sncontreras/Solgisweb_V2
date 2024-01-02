import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class ContratoFieldOutWidget extends StatelessWidget {

  const ContratoFieldOutWidget({Key? key}) : super(key: key);

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
              textinputController: outProvider.contratoController,
              hinttext: "Ingrese el Contrato",
              keyboardType: TextInputType.text, 
              labelText: 'Contrato',
            ),
          ),
          IconButton(
            onPressed: ( outProvider.contratoPhoto != null )
              ? () => showDialogPhoto(
                context, 
                outProvider.contratoPhoto!, 
                'Foto del Contrato',
                (){
                  outProvider.contratoPhoto = null;
                  Navigator.pop(context);
                }
              )
              : () async {

                final ImagePicker picker = ImagePicker();

                final  XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );

                if(pickedFile != null) outProvider.contratoPhoto = pickedFile; 

              }, 
            icon: FaIcon( 
              FontAwesomeIcons.camera, 
              color: (outProvider.contratoPhoto != null)
              ? Colors.green
              : Colors.black, 
            ),
          )
        ], 
      ),
    
    );
  }
}