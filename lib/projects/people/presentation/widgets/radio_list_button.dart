import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/people/domain/providers/radio_list_provider.dart';

class RadioListButton extends StatelessWidget {

  final int index ;
  final int value;
  final String title;
  final double width;

  const RadioListButton({super.key, 
    
    required this.index, 
    required this.value, 
    required this.title, 
    required this.width
  });
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    final radioListTile  = Provider.of<RadioListProvider>(context);

    return SizedBox(
      width: width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size.width * .07,
            height: size.height * .03,
            child: Radio<int>(
              value: value, 
              groupValue: (index==0)? radioListTile.getValorTipoPersonaDentroPlanta: radioListTile.getValorTipoPersonaMovimientoDia,
              onChanged: (value)=>(index==0)?radioListTile.setValorTipoPersonaDentroPlanta=value! : radioListTile.setValorTipoPersonaMovimientoDia=value!,
            ),
          ),
          Container(
            width: width - size.width * .07 ,
            height: size.height * .03,
            alignment: Alignment.center,
            child: Text(title),
          ),
        ],
      )
    );
  }

}