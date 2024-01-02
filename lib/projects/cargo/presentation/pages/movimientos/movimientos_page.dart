import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:solgis/projects/cargo/core/utils/get_app_bar_cargo.dart';
import 'package:solgis/projects/cargo/core/utils/search_delegate_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/movimientos/widgets/custom_navigation_bar.dart';
import 'package:solgis/projects/cargo/presentation/providers/carga_type_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/movimientos_page_provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/movimientos/movimiento_dia_tab.dart';
import 'package:solgis/projects/cargo/presentation/pages/movimientos/movimiento_planta_tab.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_type_provider.dart';

class MovimientosPageCargo extends StatelessWidget {
  const MovimientosPageCargo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => MovimientosCargoPageProvider() ),
        ChangeNotifierProvider( create: ( _ ) => VehicleTypeProvider() ),
        ChangeNotifierProvider( create: ( _ ) => CargaTypeProvider() ),
        
      ],
      child: const MovimientosPageCargoState(),
    );
  }
}


class MovimientosPageCargoState extends StatelessWidget {

  const MovimientosPageCargoState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarNoSearching(context, 'Movimientos', ()=> showSearch(context: context, delegate: SearchDelegateProviderCargo())),
      bottomNavigationBar: const CustomNavigationBar(),
      body: const _MovimientosPageCargoBody(),
    );
  }

}

class _MovimientosPageCargoBody extends StatelessWidget {

  const _MovimientosPageCargoBody({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<MovimientosCargoPageProvider>(context);
    final currentIndex = uiProvider.getSelectedMenuOpt;

    switch ( currentIndex ){
      case 0:  
        return  MovimientoPlantaTab( index: currentIndex );
      case 1:  
        return  MovimientoDiaTab( index: currentIndex );
      default: 
        return  MovimientoDiaTab( index: currentIndex );
    }
  }
}