import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';


class VehicleContainerSalida extends StatelessWidget {

  const VehicleContainerSalida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(

      width: double.infinity,
      height: size.height * .23,

      child: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical:15),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const _VehicleInfo(),
            SizedBox(height: size.height*0.02),

          ],
        ),
      ),
    );

  }
}

class _VehicleInfo extends StatelessWidget {

  const _VehicleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final vehicle = vehicleProvider.vehicleResponse;
    final outProvider = Provider.of<SalidaAutorizadaProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Column(

          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            const Text('PLACA:', style: TextStyle(color: Colors.blue)),
            SizedBox(height: size.height*0.02),
            const Text('TIPO:', style: TextStyle(color: Colors.blue)),
            SizedBox(height: size.height*0.02),
            const Text('T. CARGA: ', style: TextStyle(color: Colors.blue)),

          ],
        ),

        SizedBox(width: size.width  * .02),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${vehicle?.nroPlaca}".toUpperCase()),
            SizedBox(height: size.height*0.02),
            Text( vehicle?.tipoVehiculo?? '' ),
            SizedBox(height: size.height*0.02),
            Text(outProvider.lazyResponse?.tipoCarga?? ''),
          ],
        ),

        SizedBox(width: size.width  * .2),

        //FOTO
        FutureBuilder(

          future: getImage('https://c0.klipartz.com/pngpicture/252/313/gratis-png-vista-frontal-del-carro-acura.png'),

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