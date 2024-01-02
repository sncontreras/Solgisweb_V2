import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:solgis/core/domain/providers/global_provider.dart';
//import 'package:solgis/projects/people/domain/helpers/show_dialog_combo.dart';

chooseService(BuildContext context) async {
  

  // ignore: unused_local_variable
  final size = MediaQuery.of(context).size;

  return DraggableScrollableSheet(
    initialChildSize: 0.1,
    minChildSize: 0.1,
    maxChildSize: 0.7,

    builder: ( _ , scrollController) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),

      );
    },

  );


  // final gProvider = Provider.of<GlobalProvider>(context, listen:false);

  // showDialogComboService(context, 'Listado de Servicios', 'hola prueba');

}