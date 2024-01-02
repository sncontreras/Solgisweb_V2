import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/movimientos_page_provider.dart';

class CustomNavigationBar extends StatelessWidget {

  const CustomNavigationBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<MovimientosCargoPageProvider>(context);
    final currentIndex = uiProvider.getSelectedMenuOpt; 

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: ( int index ) => uiProvider.setSelectedMenuOpt = index,

      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: 'Dentro',
          tooltip: 'Aqui se muestran los movimientos de vehiculos que se encuentran dentro de la planta',
        ),

        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.readme),
          label: 'Dia',
          tooltip: 'Aqui se muestran los movimientos de los vehiculos de todo el dia.' 
        ),

      ]
    );
  }
}