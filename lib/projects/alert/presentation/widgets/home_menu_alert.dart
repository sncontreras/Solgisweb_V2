import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solgis/projects/alert/presentation/widgets/widgets.dart';

class MenuAlert extends StatelessWidget {
  const MenuAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //OPCION REGISTRAR
        ButtonMenuAlert(
          icon: FontAwesomeIcons.clock , 
          text: 'Registrar',
          onpressed: () => Navigator.pushNamed(context, 'registrar_marcacion'),
        ),

        //OPCION MARCACIONES
        ButtonMenuAlert(
          icon: FontAwesomeIcons.bookAtlas, 
          text: 'Marcaciones',
          onpressed: () => Navigator.pushNamed(context, 'listar_marcaciones'),
        )

      ],
    );
  }
}
