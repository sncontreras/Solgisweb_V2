import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';

import 'package:solgis/projects/cargo/core/styles/style.dart';
import 'package:solgis/projects/cargo/domain/entities/fields/alcoholimetro_field.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class AlcoholimetroWidget extends StatelessWidget {

  final AlcoholimetroField alcoholimetro;
  const AlcoholimetroWidget({
    Key? key, 
    required this.alcoholimetro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);

    return Column(

      children: [
        Text( "ALCOHOLIMETRO", style: styleCrearPersonaltextForm().copyWith( fontWeight:  FontWeight.bold)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            _RadioButton(
              text: "Negativo",
              value: false,
              ongroup: entryProvider.alcoholimetro,
              onchanged: (value) => entryProvider.alcoholimetro = value!,
            ),

            _RadioButton(
              text: "Positivo", 
              value: true,
              ongroup: entryProvider.alcoholimetro,
              onchanged: (value) => entryProvider.alcoholimetro = value!,
            ),

            if(alcoholimetro.hasfoto!)
              IconButton(
                onPressed: ( entryProvider.alcoholimetroPhoto != null )
                  ? () => showDialogPhoto(
                    context, 
                    entryProvider.alcoholimetroPhoto!, 
                    'Foto del Alcoholimetro',
                    (){
                      entryProvider.alcoholimetroPhoto = null;
                      Navigator.pop(context);
                    }
                  )
                  : () async {
                    final ImagePicker picker = ImagePicker();
                    final  XFile? pickedFile = await picker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
                    if(pickedFile != null) entryProvider.alcoholimetroPhoto = pickedFile; 
                  }, 
                icon: FaIcon( 
                  FontAwesomeIcons.camera, 
                  color: (entryProvider.alcoholimetroPhoto != null)
                  ? Colors.green
                  : Colors.black, 
                ),
              )

          ],
        )

      ],
    );
  }
}

class _RadioButton extends StatelessWidget {

  final String text;
  final bool value;
  final bool ongroup;
  final Function(bool?)? onchanged;
  
  const _RadioButton({
    Key? key, 
    required this.text, 
    required this.value, 
    required this.ongroup, 
    this.onchanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Radio<bool>(
          value: value, 
          groupValue: ongroup, 
          onChanged: onchanged,
        ),
        Text(text),
      ],
    );

  }
}


