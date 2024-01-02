import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/registrar_form_cargo.dart';

class NumPadWithKeyBoard extends StatelessWidget {

  final int length;
  // final Function onPressed;

  const NumPadWithKeyBoard({super.key, 
    required this.length, 
    // required this.onPressed,
  });

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final numpadProvider= Provider.of<NumPadProvider>(context); 
    // ignore: unused_local_variable
    final loginProvider = Provider.of<GlobalProvider>(context, listen: false).relationModel;
    final registroProvider = Provider.of<RegisterProvider>(context);

    return SizedBox(

      width: size.width,
      height: size.height*0.5,

      child: Column(

        children: <Widget>[

          Preview(text: registroProvider.placa , length: length),

        ],

      ),

    );

  }

}

class Preview extends StatelessWidget {

  final int length;
  final String text;

  const Preview({super.key, required this.length, required this.text});

  @override
  Widget build(BuildContext context) {

    List<Widget> previewLength = [];
    for (var i = 0; i < length; i++) {
      bool valor = text.length >= i+1;
      previewLength.add(Dot(isActive: valor, number: valor? text.substring(i,i+1) : null));
    } 
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Wrap(
        children: previewLength
      )
    );
  }

}

class Dot extends StatelessWidget {

  final bool isActive;
  final String? number;

  const Dot({super.key,  
    this.isActive = false, 
    this.number
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final registroProvider = Provider.of<RegisterProvider>(context);

    return  Container(
      padding: const  EdgeInsets.all(8.0),
      child: isActive
      ? SizedBox(
        width: 30.0, 
        height: 30.0,
        child: Text(
          '$number', 
          style: const TextStyle(
            color: Colors.white, 
            fontSize:20, 
            fontWeight: FontWeight.bold
          )
        )
      )
      : Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.white
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),

        child: TextField(
          cursorHeight: 5,
          controller: registroProvider.inputController1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * .08
          ),
          keyboardType: TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],

          onChanged: (value){
            if( value.length == 1 ){
              if(registroProvider.placa.length < 6){
                registroProvider.placa += value;
                FocusScope.of(context).nextFocus();
              }
            }
            if(value.isEmpty){
              registroProvider.placa = registroProvider.placa.substring(0, registroProvider.placa.length-1);
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }

}

