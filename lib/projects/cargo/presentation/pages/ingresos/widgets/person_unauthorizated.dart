import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';

class PersonUnautorizated extends StatelessWidget {

  const PersonUnautorizated({
    Key? key, 
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size           = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final configProvider = Provider.of<ConfigProvider>(context);
    // ignore: unused_local_variable
    final entryProvider  = Provider.of<IngresoAutorizadoProvider>(context);
    // ignore: unused_local_variable
    final gProvider      = Provider.of<GlobalProvider>(context);
    final driverProvider = Provider.of<DriverProvider>(context);
    final driver = driverProvider.driverResponse;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),

      child: SingleChildScrollView(
        child: Column(

          children: [

            //Fila de los datos del conductor.
            Row(

              children: [

                //NOMBRE, CARGO, EMPRESA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(driver!.persNombres!.toLowerCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    AutoSizeText(driver.persCargo!.toLowerCase()),
                    AutoSizeText(driver.persEmpresa!.toLowerCase()),
                  ],
                ),

                SizedBox(width: size.width * .02),

                //FOTO
                FutureBuilder(
                  future: getImage(driver.img),
                  builder: (context, AsyncSnapshot<Widget> snapshot) {

                    if(!snapshot.hasData){

                      return Container(
                        width: size.width * .27,
                        height: size.height * .12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/gifs/loader-gris.gif'),
                          ),
                        )
                      );

                    }

                    return Container(
                      width: size.width* .27,
                      height: size.height* .12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: snapshot.data,
                      ),
                    );

                  }
                ),

              ],

            ),

          ],
        ),
      ),
    );

  }
}



