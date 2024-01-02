import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/core/presentation/widgets/dropdown_button_sheet.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';
import 'package:solgis/projects/cargo/data/services/carga_type__services.dart';
import 'package:solgis/projects/cargo/presentation/providers/carga_type_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/movimientos_page_provider.dart';
import 'package:solgis/projects/people/styles/style.dart';

class MovimientosHeader extends StatelessWidget {

  final int index;

  const MovimientosHeader({
    super.key, 
    required this.index,
  });

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('es');

    final size                = MediaQuery.of(context).size;
    final movimientosProvider = Provider.of<MovimientosCargoPageProvider>(context);
    final cVehicleProvider    = Provider.of<CargaTypeProvider>(context);
    final gProvider           = Provider.of<GlobalProvider>(context);

    return Container(
      padding: const EdgeInsets.only(top:20),
      color: Colors.transparent,
      width: double.infinity,
      height: size.height * 0.25,

      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          //FECHA 
          AutoSizeText(DateFormat('EEEE, d MMMM yyyy', 'es').format(DateTime.now()), style: textStyleDate(), minFontSize: 6),

          SizedBox( height: size.height*0.02),


          //CANTIDAD
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText('Cantidad:', style: TextStyle( color: Colors.green, fontSize: size.height*0.03, fontWeight: FontWeight.bold), minFontSize: 6),
              SizedBox( width: size.width * 0.01),
              AutoSizeText('${movimientosProvider.movimientosContador}', style: TextStyle(fontSize: size.height*0.03, fontWeight:  FontWeight.bold, color:  Colors.black), minFontSize: 6,),
            ],
          ),

          SizedBox( height: size.height * 0.03),


          // TIPO DE CARGA
          FutureBuilder(

            future: CargaTypeService.getCargaType(gProvider.relationModel.codigoCliente!),

            builder: ( _ , AsyncSnapshot<List<TipoCargaModel>> snapshot ) {

              if( !snapshot.hasData ){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ShimmerWidget(
                    width:  size.width,
                    height: size.height * .08,
                  ),
                );
              }

              final items = snapshot.data;

              if( items!.length < 5 ){

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:items.map((typeCarga) {
                    return RadioListButton(
                      tipoCarga: typeCarga,
                      width: size.width * .23,
                    );
                  }).toList(),
                );


              }else{
                return DropDownButtonSheet(
                  textLabel: ( cVehicleProvider.selectedCargaType == null )
                    ? 'Seleccione el Tipo de Carga'
                    : cVehicleProvider.selectedCargaType!.cargaType!.toLowerCase() , 
                  textTitle: 'Tipo de Carga',
                  widgets: items.map(
                    (type) => ListTile(
                      title: Text(StringHelper.patternString(type.cargaType)),
                      onTap: (){
                        cVehicleProvider.selectedCargaType = type;
                        Navigator.pop(context);
                      },
                    )
                  ).toList(), 
                );

              }
            },
          ),

          //TIPO DE VEHICULO
          // FutureBuilder(

          //   future: VehicleService.getVehicleTypes('', gProvider.relationModel.codigoCliente!),

          //   builder: ( _ , AsyncSnapshot<List<VehicleTypeModel>> snapshot ) {

          //     if( !snapshot.hasData ){
          //       return ClipRRect(
          //         borderRadius: BorderRadius.circular(50),
          //         child: ShimmerWidget(
          //           width:  size.width,
          //           height: size.height * .08,
          //         ),
          //       );
          //     }

          //     final items = snapshot.data;

          //     return DropDownButtonSheet(
          //       textLabel: ( tVehicleProvider.selectedVehicleType == null )
          //         ? 'Seleccione el Tipo de Vehiculo'
          //         : tVehicleProvider.selectedVehicleType!.vehicleType!.toLowerCase() , 
          //       textTitle: 'Tipo de Vehiculo',
          //       widgets: items!.map(
          //         (type) => ListTile(
          //           title: Text(StringHelper.patternString(type.vehicleType)),
          //           onTap: (){
          //             tVehicleProvider.selectedVehicleType = type;
          //             Navigator.pop(context);
          //           },
          //         )
          //       ).toList(), 
          //     );

          //   },

          // ),

        ],
      ),
    );
  }
}


class RadioListButton extends StatelessWidget {

  final TipoCargaModel tipoCarga;
  final double width;

  const RadioListButton({
    super.key, 
    required this.tipoCarga, 
    required this.width
  });
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final cVehicleProvider    = Provider.of<CargaTypeProvider>(context);

    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size.width * .035,
            child: Radio<TipoCargaModel>(
              value: tipoCarga, 
              groupValue: cVehicleProvider.selectedCargaType,
              onChanged: (value)  =>  cVehicleProvider.selectedCargaType = value!,
            ),
          ),
          Container(
            width: width - size.width * .07 ,
            alignment: Alignment.centerLeft,
            child: Text(
              (tipoCarga.cargaType ??''),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      )
    );
  }

}