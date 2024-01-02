import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/destino_field_widget.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/kilometraje_field_widget.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/tipo_vehiculo_field_widget.dart';
import 'package:solgis/projects/cargo/presentation/pages/ingresos/widgets/widgets.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class EntryDataWidget extends StatelessWidget {
  const EntryDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    final optionsList =
        configProvider.configuration!.configuration!.configExtra!.fieldsEntry;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final liviano = entryProvider.cargaTypeSelected.cargaType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: (optionsList == null)
            ? const Center(child: Text("No hay campos habilitados"))
            : Column(
                children: [
                  //condicion para crec y chec
                  if (optionsList.carreta!.hasfoto != null && liviano! != 'LIVIANO') 
                    const CarretaFieldWidget(),

                  if (optionsList.carga!.hasfoto != null)
                    const CargaFieldWidget(),

                  if (optionsList.origin!.hasfoto != null)
                    const OrigenFieldWidget(),
                  
                  //condicion para crec y chec
                  if (optionsList.guia!.hasfoto != null && liviano! != 'LIVIANO')
                    const GuiaFieldWidget(),

                  if (optionsList.container!.hasfoto != null)
                    const ContenedorFieldWidget(),

                  if (optionsList.tContenedor!.hasfoto != null)
                    const TContenedorFieldWidget(),

                  if (optionsList.gTransportista!.hasfoto != null)
                    const GuiaTranspFieldWidget(),

                  if (optionsList.precinto!.hasfoto != null)
                    const PrecintoFieldWidget(),

                  if (optionsList.booking!.hasfoto != null)
                    const BookingFieldWidget(),

                  if (optionsList.contrato!.hasfoto != null)
                    const ContratoFieldWidget(),

                  if (optionsList.opLogistico!.hasfoto != null)
                    const OpLogFieldWidget(),

                  //CONFIGURACION PARA MARCONA //condicion para crec y chec
                  if (optionsList.tipoMaterial!.hasfoto != null && liviano! != 'LIVIANO')
                    const MaterialsFieldWidget(),

                  if (optionsList.tipoVehiculo!.hasfoto != null)
                    const TipoVehiculoFieldWidget(),

                  if (optionsList.kilometraje!.hasfoto != null)
                    const KilometrajeFieldWidget(),

                  if (optionsList.destino!.hasfoto != null)
                    const DestinoFieldWidget(),
                ],
              ),
      ),
    );
  }
}
