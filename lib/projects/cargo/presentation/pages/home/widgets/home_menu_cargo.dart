import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/widgets/widgets.dart';

class MenuCargo extends StatelessWidget {
  const MenuCargo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<GlobalProvider>(context).relationModel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (serviceProvider.codigoPerfil != 3)
          ButtonMenuCargo(
            icon: FontAwesomeIcons.qrcode,
            text: 'Escaner',
            onpressed: () => Navigator.pushReplacementNamed(
                context, 'register_movimiento_gun_cargo'),
          ),
        //OPCION REGISTRAR
        if (serviceProvider.codigoPerfil != 3)
          ButtonMenuCargo(
            icon: FontAwesomeIcons.car,
            text: 'Registrar',
            onpressed: () =>
                Navigator.pushNamed(context, 'registrar_movimiento_cargo'),
          ),

        //OPCION MOVIMIENTOS
        ButtonMenuCargo(
          icon: FontAwesomeIcons.carSide,
          text: 'Movimientos',
          onpressed: () =>
              Navigator.pushNamed(context, 'movimientos_page_cargo'),
        ),

        //OPCION CONSULTAR
        ButtonMenuCargo(
          icon: FontAwesomeIcons.magnifyingGlass,
          text: 'Consultar',
          onpressed: () =>
              Navigator.pushNamed(context, 'consulta_home_page_cargo'),
        ),
      ],
    );
  }
}
