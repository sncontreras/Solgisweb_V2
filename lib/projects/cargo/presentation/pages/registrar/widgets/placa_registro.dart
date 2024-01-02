// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/core/helpers/consultar_placa.dart';
import 'package:solgis/projects/cargo/core/theme/theme_cargo.dart';
import 'package:solgis/projects/cargo/presentation/providers/registrar_form_cargo.dart';

class PlacaFormRegistro extends StatelessWidget {
  const PlacaFormRegistro({super.key});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(

      width: size.width*0.95,
      height: size.height*0.6,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText( 'Ingrese el numero de placa', style: AppThemeCargo.lighThemeCargo.textTheme.displaySmall ), 
          SizedBox( height: size.height*0.05 ),
          const Input(),
        ],
      ),

    );  
  }
}

class Input extends StatefulWidget{
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  late FocusNode firstInputFocus;

  @override
  void initState() {
    firstInputFocus  = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    firstInputFocus.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final registroProvider = Provider.of<RegisterProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            height: size.width * .2,
            width : size.width * .7,
            decoration: (registroProvider.inputController1.text != "" ) ? null :BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(
                  10.0),
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: TextFormField(
              focusNode: firstInputFocus,
              showCursor: false,
              controller: registroProvider.inputController1 ,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * .12
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: (value){
                if( value.length == 6 ){
                  if(registroProvider.placa.length < 6){
                    registroProvider.placa += value;
                    FocusScope.of(context).nextFocus();
                  }
                  //if(registroProvider.placa.length == 6){
                    registroProvider.placa = value;

                    consultarPlaca(context, registroProvider.placa, gProvider.relationmodel.codigoServicio.toString(), gProvider.relationModel.codigoCliente.toString());
                    registroProvider.cleanInputControllers();
                    print(registroProvider.placa);
                    registroProvider.placa = '';
                    print(registroProvider.placa);
                  //}
                }
                /*if(value.isEmpty){
                  registroProvider.placa = registroProvider.placa.substring(0, registroProvider.placa.length-1);
                  FocusScope.of(context).previousFocus();
                }*/
              },
                    
            ),
          ),

          

        ],
      ),
    );

  }
}
