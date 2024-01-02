import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/movimientos/widgets/movimientos_header.dart';
import 'package:solgis/projects/cargo/presentation/providers/carga_type_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/movimientos_page_provider.dart';
import 'package:solgis/projects/cargo/presentation/widgets/movimientos_tiles_cargo.dart';

class MovimientoDiaTab extends StatefulWidget {

  final int index;
  const MovimientoDiaTab({ Key? key, required this.index }) : super(key: key);

  @override
  State<MovimientoDiaTab> createState() => _MovimientoDiaTabState();
}

class _MovimientoDiaTabState extends State<MovimientoDiaTab> {
  @override
  Widget build(BuildContext context) {

    final cVehicleProvider    = Provider.of<CargaTypeProvider>(context);
    
    return RefreshIndicator(
      onRefresh: () async {
        cVehicleProvider.selectedCargaType = null;
        setState(() {});
      },
      child: Column(

        children: [

          //FILTRO DEL TIPO DE CARGA
          MovimientosHeader(index:  widget.index),

          const Expanded(child: MovimientosTilesPageBody()),

        ],

      ),
    );
  }
}

class MovimientosTilesPageBody extends StatelessWidget {

  const MovimientosTilesPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final movProvider    = Provider.of<MovimientosCargoPageProvider>(context, listen: false);
    final gProvider      = Provider.of<GlobalProvider>(context);
    // final tVehicleProvider = Provider.of<VehicleTypeProvider>(context);
    // final codVehicleType = tVehicleProvider.selectedVehicleType?.codeVehicleType;
    final cVehicleProvider = Provider.of<CargaTypeProvider>(context);
    final int codCargaType = int.parse(cVehicleProvider.selectedCargaType?.codigo ?? '0') ;

    return MovimientosTilesCargo( 
      movimientos: movProvider.getMovimientosCargofilCarga(
        gProvider.relationModel.codigoServicio!, 
        codCargaType, 
        "", 
        2
      ) 
    );

  }
}
