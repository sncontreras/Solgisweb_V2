import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/carga_type_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/movimientos_page_provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/movimientos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/widgets/widgets.dart';

class MovimientoPlantaTab extends StatefulWidget {

  final int index;

  const MovimientoPlantaTab({
    super.key, 
    required this.index, 
  });

  @override
  State<MovimientoPlantaTab> createState() => _MovimientoPlantaTabState();

}

class _MovimientoPlantaTabState extends State<MovimientoPlantaTab> {
  
  @override
  Widget build(BuildContext context) {

    // final movProvider = Provider.of<MovimientosCargoPageProvider>(context);
    // final tVehicleProvider = Provider.of<VehicleTypeProvider>(context);
    final cVehicleProvider    = Provider.of<CargaTypeProvider>(context);


    return RefreshIndicator(
      onRefresh: () async {
        cVehicleProvider.selectedCargaType = null;
        setState(() {});
      },
      child: Column(
        children: [
          //Filtro por tipo de vehiculo.
          MovimientosHeader( index: widget.index ),
          const Expanded( child: MovimientosTilesPageBody() ),
        ],
      ),
    );

  }
}

class MovimientosTilesPageBody extends StatelessWidget {
  const MovimientosTilesPageBody({super.key});

  @override
  Widget build(BuildContext context) {

    final movProvider = Provider.of<MovimientosCargoPageProvider>(context, listen: false);
    final cVehicleProvider = Provider.of<CargaTypeProvider>(context);
    final gProvider   = Provider.of<GlobalProvider>(context);
    // final tVehicleProvider = Provider.of<VehicleTypeProvider>(context);
    // final codVehicleType = tVehicleProvider.selectedVehicleType?.codeVehicleType ?? 0;
    final int codCargaType = int.parse(cVehicleProvider.selectedCargaType?.codigo ?? '0') ;

    return MovimientosTilesCargo(
      movimientos: movProvider.getMovimientosCargofilCarga(
        gProvider.relationModel.codigoServicio!, 
        codCargaType , 
        "", 
        1
      ) 
    );

    // return MovimientosTilesCargo(
    //   movimientos: movProvider.getMovimientosCargo(
    //     gProvider.relationModel.codigoServicio!, 
    //     codVehicleType , 
    //     "", 
    //     1
    //   ) 
    // );

  }
}


