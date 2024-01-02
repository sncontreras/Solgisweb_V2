import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/core/presentation/widgets/shimmer_widget.dart';
import 'package:solgis/projects/cargo/core/utils/dropdown_decoration.dart';
import 'package:solgis/projects/cargo/data/models/tipos_carga_model.dart';
import 'package:solgis/projects/cargo/data/services/carga_type__services.dart';
import 'package:solgis/projects/cargo/domain/entities/carga_type.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class ContainerCargaType extends StatelessWidget {

  const ContainerCargaType({
    Key? key, 

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size          = MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final gProvider     = Provider.of<GlobalProvider>(context);

    return SizedBox(

      width: double.infinity,
      height: size.height * .05,

      child: FutureBuilder(

        future: CargaTypeService.getCargaType( gProvider.relationModel.codigoCliente.toString()),

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

          if( items!.length  < 5 ){

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

            return DropdownButtonFormField<CargaType>(

              items: items.map(
                (carga) => DropdownMenuItem<CargaType>(
                  value: carga,
                  child: Text(StringHelper.patternString(carga.cargaType))
                )
              ).toList(),

              onChanged: ( value ) async{
                final confProv  = Provider.of<ConfigProvider>(context, listen: false);
                final gProv     = Provider.of<GlobalProvider>(context, listen: false);
                entryProvider.cargaTypeSelected = value!;
                if( confProv.configuration?.configuration!.codeConfig == 1 ){
                  await confProv.getInputsForCargaType(entryProvider.cargaTypeSelected.codigo!, gProv.relationModel.codigoCliente!, gProv.relationModel.codigoServicio.toString() );
                }
              },

              hint: const Text("Seleccione el tipo de carga", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
              style: const TextStyle(color:Colors.black, fontSize: 13),
              decoration: inputDecorationDropDown(),
              isExpanded: true,
              value: ( entryProvider.cargaTypeSelected.codigo != null )
                ? entryProvider.cargaTypeSelected
                : null
            );

          }

        },
      )
    );
  }
}

class RadioListButton extends StatelessWidget {

  final TipoCargaModel tipoCarga;

  final double width;

  const RadioListButton({super.key, 
    required this.tipoCarga, 
    required this.width
  });
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    
    return SizedBox(
      width: width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size.width * .035,
            child: Radio<CargaType>(
              value: tipoCarga, 
              groupValue: entryProvider.cargaTypeSelected,
              onChanged: (entryProvider.indexStep != 0 )
              ? null
              : (value)  async {
                final  confProv = Provider.of<ConfigProvider>(context, listen: false);
                final gProv     = Provider.of<GlobalProvider>(context, listen: false);
                entryProvider.cargaTypeSelected = value!;
                if( confProv.configuration?.configuration!.codeConfig == 1 ){
                  await confProv.getInputsForCargaType(entryProvider.cargaTypeSelected.codigo!, gProv.relationModel.codigoCliente!, gProv.relationModel.codigoServicio.toString() );
                }
              },
            ),
          ),
          Container(
            width: width - size.width * .07 ,
            alignment: Alignment.centerLeft,
            child: Text(
              (tipoCarga.cargaType ??'').toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      )
    );
  }

}