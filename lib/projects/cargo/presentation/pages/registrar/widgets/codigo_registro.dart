import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/core/theme/theme_cargo.dart';
import 'package:solgis/projects/cargo/presentation/providers/registrar_form_cargo.dart';

class CodigoFormRegistro extends StatelessWidget {
  const CodigoFormRegistro({super.key});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width*0.95,
      height: size.height*0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText( 'Ingrese el Codigo', style: AppThemeCargo.lighThemeCargo.textTheme.displaySmall ), 
          SizedBox( height: size.height*0.05 ),
          const Input(),
        ],
      ),
    );  
  }
}

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          _InputContainer(),
          _InputContainer(),
          _InputContainer(),
          _InputContainer(),
          _InputContainer(),
          _InputContainer(),

        ],

      ),
    );

  }
}

class _InputContainer extends StatelessWidget {

  const _InputContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final registroProvider = Provider.of<RegisterProvider>(context);

    return Form(
      child: Row(
        children: [
          Container(
            height: size.width * .15 ,
            width : size.width * .1,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: 2
              ),
              borderRadius: BorderRadius.circular(5)
            ),
            child: TextFormField(
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
                  if(registroProvider.codigo.length < 6){
                    registroProvider.codigo += value;
                    FocusScope.of(context).nextFocus();
                  }
                  if(registroProvider.codigo.length == 6){
                    //ALL:Realizar la peticion del DOI
                    // ignore: avoid_print
                    print(registroProvider.codigo);
                  }
                }
                if(value.isEmpty){
                  registroProvider.codigo = registroProvider.codigo.substring(0, registroProvider.codigo.length-1);
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          )
        ],
      ),
    );

  }
}