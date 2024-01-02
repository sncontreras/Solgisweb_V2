import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solgis/projects/cargo/data/models/detail_movimiento_cargo_model.dart';
import 'package:solgis/projects/cargo/data/models/movimiento_cargo_model.dart';
import 'package:solgis/projects/cargo/data/services/detail_movimiento_cargo_service.dart';

class MovimientoDataCargoBody extends StatelessWidget {
  final MovimientoCargoModel movimiento;
  final String codigoServicio;

  const MovimientoDataCargoBody({
    Key? key,
    required this.movimiento,
    required this.codigoServicio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final detalleMovimiento = DetailMovimientoCargoService().getConsulta(
        movimiento.placa!,
        movimiento.codMovimiento!.toString(),
        codigoServicio);
    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * .6,
            height: size.height * .2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(4, 4))
                ]),
            child: Column(
              children: [
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.04,
                  decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12))),
                  child: const Center(
                      child: Text("Adicional",
                          style: TextStyle(color: Colors.white))),
                ),
                SizedBox(height: size.height * 0.02),
                FutureBuilder<DetailMovimientoCargoModel>(
                  future: detalleMovimiento,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // El Future está en proceso, puedes mostrar un indicador de carga aquí
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Se produjo un error al obtener los datos, puedes manejarlo aquí
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Los datos se obtuvieron con éxito, puedes acceder a ellos desde snapshot.data
                      final detalle = snapshot.data;

                      return Column(
                        children: [
                          Text(detalle?.tipoCarga ?? ""),
                          SizedBox(height: size.height * 0.01),
                          Text(detalle?.tipoVehiculo ?? ""),
                          SizedBox(height: size.height * 0.01),
                          Text(detalle?.ingresoVehicular ?? ""),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: size.height*0.03),

          if(movimiento.fechaSalida == null)
            Container(
              width: size.width*0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.car, size: 24, color:Colors.blueGrey),
                        SizedBox(width: size.width* 0.03,),
                        Column(
                          children: [
                            // const Text('3/11/2022'),

                            Text(movimiento.fechaIngreso.toString().substring(0,10)),

                            SizedBox(height: size.height*0.02),
                            Text(movimiento.fechaIngreso.toString().substring(11,19)),
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                    width: size.width*0.45,
                    height: size.height*0.04,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                    ),
                    child: const Center(child: Text("Entrada", style: TextStyle(color: Colors.white))),
                  )

                ],
              ),
            ),

          if(movimiento.fechaSalida != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: size.width*0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.car, size: 24, color:Colors.blueGrey),
                            SizedBox(width: size.width* 0.03,),
                            Column(
                              children: [
                                Text(movimiento.fechaIngreso.toString().substring(0,10)),

                                SizedBox(height: size.height*0.02),
                                Text(movimiento.fechaIngreso.toString().substring(11,19)),
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        width: size.width*0.45,
                        height: size.height*0.04,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                        ),
                        child: const Center(child: Text("Entrada", style: TextStyle(color: Colors.white))),
                      )

                    ],
                  ),
                ),

                SizedBox(width: size.width*0.05),

                Container(
                  width: size.width*0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.carSide, size: 24, color:Colors.blueGrey),
                            SizedBox(width: size.width* 0.03,),
                            Column(
                              children: [
                                Text(movimiento.fechaSalida.toString().substring(0,10)),

                                SizedBox(height: size.height*0.02),
                                Text(movimiento.fechaSalida.toString().substring(11,19)),
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        width: size.width*0.45,
                        height: size.height*0.04,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                        ),
                        child: const Center(child: Text("Salida", style: TextStyle(color: Colors.white))),
                      )

                    ],
                  ),
                ),

              ],
            ),
        ],
      ),
    );
  }
}
