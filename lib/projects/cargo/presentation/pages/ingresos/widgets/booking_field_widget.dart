import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/helpers/show_dialog_photo.dart';

import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class BookingFieldWidget extends StatelessWidget {

  const BookingFieldWidget({Key? key}) : super(key: key);

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
              textinputController: entryProvider.bookingController,
              hinttext: "Ingrese el Booking",
              keyboardType: TextInputType.text, 
              labelText: 'Booking',
            ),
          ),

          IconButton(
            onPressed: ( entryProvider.bookingPhoto != null )
              ? () => showDialogPhoto(
                context, 
                entryProvider.bookingPhoto!, 
                'Foto del Booking',
                (){
                  entryProvider.bookingPhoto = null;
                  Navigator.pop(context);
                }
              )
              : () async {

                final ImagePicker picker = ImagePicker();

                final  XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );

                if(pickedFile != null) entryProvider.bookingPhoto = pickedFile; 

              }, 
            icon: FaIcon( 
              FontAwesomeIcons.camera, 
              color: (entryProvider.bookingPhoto != null)
              ? Colors.green
              : Colors.black, 
            ),
          )

        ],

      ),

    );
  }
}