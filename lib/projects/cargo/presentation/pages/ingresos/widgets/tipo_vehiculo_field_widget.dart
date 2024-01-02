import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/projects/cargo/data/models/vehicle_type_model.dart';
import 'package:solgis/projects/cargo/data/services/vehicle_service.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class TipoVehiculoFieldWidget extends StatelessWidget {

  const TipoVehiculoFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    final entryProvider = Provider.of<IngresoAutorizadoProvider>(context);
    final gProvider = Provider.of<GlobalProvider>(context);

    return Stack(

      children: [

        GestureDetector(
          onTap: () async {
            await showMaterialModalBottomSheet(
              context: context,
              expand: false,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Material(
                  child: SafeArea(
                    top: false,
                    child: FutureBuilder(
                      future: VehicleService.getVehicleTypes( '',gProvider.relationModel.codigoCliente.toString()),
                      //future: CargaTypeService.getCargaType( gProvider.relationModel.codigoCliente.toString(), isMaterial: true),
                      builder: ( _ , AsyncSnapshot<List<VehicleTypeModel>> snapshot) {
                        if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                        final vehicles = snapshot.data;
                        return ListView.builder(
                          itemCount: vehicles!.length,
                          itemBuilder: ( _ , i) {
                            final vehicle = vehicles[i];
                            return ListTile(
                              title: Text( StringHelper.patternString(vehicle.vehicleType!) ),
                              onTap: (){
                                entryProvider.vechicleTypeSelected = vehicle;
                                Navigator.pop(context);
                              },
                            );
                          } ,
                        );
                      },
                    ),
                  )
                );
              }
            );
          },
          child: Container(
            width:  size.width * .9,
            height: size.height * .065,
            margin: EdgeInsets.symmetric(vertical: size.height * .01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              )
            ),
            child: ( entryProvider.vehicleTypeSelected.codeVehicleType == null )
              ? const Text( "Seleccione el Tipo de Vehículo" )
              : Text( StringHelper.patternString( entryProvider.vehicleTypeSelected.vehicleType! ) )
          ),
        ),

        Positioned(
          left: 20,
          top: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: const Color(0xffFAFAFA),
            child: const Text(
              'Tipo Vehiculo',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

      ],
    );
  }
}