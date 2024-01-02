import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/destino_field_out_widget.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/kilometraje_field_out_widget.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/materiales_field_widget_out.dart';
import 'package:solgis/projects/cargo/presentation/pages/salida/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';


class OutDataWidget extends StatelessWidget {

  const OutDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final configProvider = Provider.of<ConfigProvider>(context);
    final optionsList = configProvider.configuration!.configuration!.configExtra!.fieldsOut; 

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: SingleChildScrollView(

        child: (optionsList == null)

        ? const Center(child: Text("No hay campos habilitados"))

        : Column(

          children: [

            if( optionsList.carreta!.hasfoto != null )
              const CarretaFieldOutWidget(),

            if( optionsList.carga!.hasfoto != null )
              const CargaFieldOutWidget(),

            if( optionsList.origin!.hasfoto != null )
              const OrigenFieldOutWidget(),

            if( optionsList.guia!.hasfoto != null )
              const GuiaFieldOutWidget(),

            if( optionsList.container!.hasfoto != null )
              const ContenedorFieldOutWidget(),

            if( optionsList.tContenedor!.hasfoto != null )
              const TContenedorFieldOutWidget(),

            if( optionsList.gTransportista!.hasfoto != null )
              const GuiaTranspFieldOutWidget(),

            if( optionsList.precinto!.hasfoto != null )
              const PrecintoFieldOutWidget(),

            if( optionsList.booking!.hasfoto != null )
              const BookingFieldOutWidget(),

            if( optionsList.contrato!.hasfoto != null )
              const ContratoFieldOutWidget(),

            if( optionsList.opLogistico!.hasfoto != null )
              const OpLogFieldOutWidget(),

            if( optionsList.tipoMaterial!.hasfoto != null )
              const MaterialsFieldOutWidget(),

            if( optionsList.destino!.hasfoto != null )
              const DestinoFieldOutWidget(),

            if( optionsList.kilometraje!.hasfoto != null )
              const KilometrajeFieldOutWidget(),
            

          ],
        ),
      ),
    );
  }
}