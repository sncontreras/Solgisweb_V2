import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class GuiaTranspFieldOutWidget extends StatelessWidget {

  const GuiaTranspFieldOutWidget({Key? key}) : super(key: key);

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
              textinputController: outProvider.gTranportistaController,
              hinttext: "Ingrese el G. Transportista",
              keyboardType: TextInputType.text, 
              labelText: 'G. Transportista',
            ),
          ),
          IconButton(
            onPressed: ( outProvider.gTranportistaPhoto != null )
              ? () => showDialogPhoto(
                context, 
                outProvider.gTranportistaPhoto!, 
                'Foto G. Transportista',
                (){
                  outProvider.gTranportistaPhoto = null;
                  Navigator.pop(context);
                }
              )
              : () async {
                final ImagePicker picker = ImagePicker();
                final  XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if(pickedFile != null) outProvider.gTranportistaPhoto = pickedFile; 
              }, 
            icon: FaIcon( 
              FontAwesomeIcons.camera, 
              color: (outProvider.gTranportistaPhoto != null)
              ? Colors.green
              : Colors.black, 
            ),
          )
        ], 
      ),

    );
  }
}