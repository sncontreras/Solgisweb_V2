import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/core/theme/theme_cargo.dart';

class PlacaFormConsulta extends StatelessWidget {
  
  const PlacaFormConsulta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        AutoSizeText('Ingrese la placa', style: AppThemeCargo.lighThemeCargo.textTheme.displayMedium,), 


      ],

    );

  }

}