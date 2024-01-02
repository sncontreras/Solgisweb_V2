import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';

import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class CargaFieldWidget extends StatelessWidget {

  const CargaFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    
    return Stack(
      children: [

        Container(
          width:  size.width * .9,
          height: size.height * .065,
          margin: EdgeInsets.symmetric(vertical: size.height * .01),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 2,
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RadioButton(
                text: "LLeno",
                value: true,
                ongroup: entryProvider.selectedCarga,
                onchanged: (value) async {
                  final  confProv = Provider.of<ConfigProvider>(context, listen: false);
                  final gProv     = Provider.of<GlobalProvider>(context, listen: false);
                  entryProvider.selectedCarga = value!;
                  if( confProv.configuration?.configuration!.codeConfig == 2 ){
                    await confProv.getInputsForCargaState( entryProvider.selectedCarga, gProv.relationModel.codigoCliente!, gProv.relationModel.codigoServicio.toString() );
                  }

                },
              ),
              _RadioButton(
                text: "Vacio", 
                value: false,
                ongroup: entryProvider.selectedCarga,
                onchanged: (value) async {
                  final  confProv = Provider.of<ConfigProvider>(context, listen: false);
                  final gProv     = Provider.of<GlobalProvider>(context, listen: false);
                  entryProvider.selectedCarga = value!;
                  if( confProv.configuration?.configuration!.codeConfig == 2 ){
                    await confProv.getInputsForCargaState( entryProvider.selectedCarga, gProv.relationModel.codigoCliente!, gProv.relationModel.codigoServicio.toString() );
                  }
                },
              ),
            ],
          ),
        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
            child: const Text(
              'Carga',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

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
          onChanged: onchanged
        ),
        Text(text),
      ],
    );

  }
}