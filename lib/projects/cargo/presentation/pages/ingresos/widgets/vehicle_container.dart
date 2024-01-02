import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/core/presentation/widgets/read_only_input.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

class VehicleContainer extends StatelessWidget {

  const VehicleContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      // height: size.height * .26,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical:15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _VehicleInfo(),
              SizedBox(height: size.height * .03),
            ],
          ),
        ),
      ),
    );

  }
}


class _VehicleInfo extends StatelessWidget {
  const _VehicleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size  = MediaQuery.of(context).size;
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final vehicle = vehicleProvider.vehicleResponse;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //PLACA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('PLACA: ', style: TextStyle(color: Colors.blue)),
                InputReadOnlyWidget(initialValue: vehicle?.nroPlaca?? '' , width: size.width * .2),
              ],
            ),

            //TIPO DE VEHICULO  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TIPO: ', style: TextStyle(color: Colors.blue)),
                InputReadOnlyWidget(initialValue:  vehicle?.tipoVehiculo?? '' ,  width: size.width * .3),
              ],
            ),
            // SizedBox(height: size.height*0.01),

            if( vehicle!.tProp != null && vehicle.tProp!.isNotEmpty )
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('T. PROP: ', style: TextStyle(color: Colors.blue)),
                  InputReadOnlyWidget(initialValue: vehicle.tProp?? '',  width: size.width * .3),
                ],
              ),
            // if( vehicle.tProp != null )
            //   SizedBox(height: size.height*0.01),

            //FECHA VENCIMIENTO SOAT  
            if( vehicle.fSoat != null && vehicle.tProp!.isNotEmpty )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('SOAT: ', style: TextStyle(color: Colors.blue)),
                  InputReadOnlyWidget(initialValue: vehicle.fSoat?.substring(0,10)  ,  width: size.width * .3),
                ],
              ),
            // if( vehicle.tProp != null )
            //   SizedBox(height: size.height*0.01),

            //FECHA REVISION TECNICA
            if( vehicle.fRevTec != null && vehicle.tProp!.isNotEmpty )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('TECNICA: ', style: TextStyle(color: Colors.blue)),
                  InputReadOnlyWidget(initialValue: vehicle.fRevTec?.substring(0,10),  width: size.width * .3),
                ],
              ),

          ],
        ),

        //FOTO
        FutureBuilder(

          future: getImage(vehicle.img),

          builder: ( _ , AsyncSnapshot<Widget>  snapshot) {

            if(!snapshot.hasData){
              return SizedBox(
                width: size.width*0.3,
                height: size.width*0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                    image: AssetImage('assets/gifs/loader.gif'),
                  ),
                ),
              );
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: size.width*0.3,
                height: size.width*0.25,
                child: snapshot.data,
              ),
            );

          },
        ),

      ],
    );

  }
}