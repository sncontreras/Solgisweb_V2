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
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';

class ContainerCargaTypeOut extends StatelessWidget {

  const ContainerCargaTypeOut({
    Key? key, 

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: size.height * .05,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
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

            return DropdownButtonFormField<CargaType>(

              items: items!.map(
                (carga) => DropdownMenuItem<CargaType>(
                  value: carga,
                  child: Text( StringHelper.patternString(carga.cargaType))
                )
              ).toList(),

              onChanged: ( value ) async {
                final confProv = Provider.of<ConfigProvider>(context, listen: false);
                final gProv    = Provider.of<GlobalProvider>(context, listen: false);

                outProvider.cargaTypeSelected = value!;

                if( confProv.configuration?.configuration?.codeConfig == 1 ){
                  await confProv.getInputsForCargaType(outProvider.cargaTypeSelected.codigo!, gProv.relationModel.codigoCliente!, gProv.relationModel.codigoServicio.toString() );
                }

              },
              hint: const Text("Seleccione el tipo de carga", style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
              style:  const TextStyle(color:Colors.black, fontSize: 13),
              decoration: inputDecorationDropDown(),
              isExpanded: true,
              value: ( outProvider.cargaTypeSelected.codigo != null )
                ? outProvider.cargaTypeSelected
                : null
            );

          },

        )
      )
    );
  }
}

