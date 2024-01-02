import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/data/models/datos_acceso_movimiento_cargo.dart';
import 'package:solgis/projects/cargo/data/models/movimiento_cargo_model.dart';
import 'package:solgis/projects/cargo/data/services/datos_acceso_cargo_service.dart';
import 'package:solgis/projects/cargo/presentation/pages/detalle_movimiento/widgets/custom_button_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/detalle_movimiento/widgets/movimiento_data_acceso_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/detalle_movimiento/widgets/movimiento_data_cargo.dart';
import 'package:solgis/projects/cargo/presentation/providers/detalle_movimiento_provider_cargo.dart';

class DetailMovimientoCargo extends StatelessWidget {
  const DetailMovimientoCargo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MovimientoCargoModel movimiento =
        ModalRoute.of(context)!.settings.arguments as MovimientoCargoModel;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => DetalleMovimientoCargoProvider()))
      ],
      child: DetailMovimientoPageState(movimiento: movimiento),
    );
  }
}

class DetailMovimientoPageState extends StatelessWidget {
  final MovimientoCargoModel movimiento;

  const DetailMovimientoPageState({Key? key, required this.movimiento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gProvider = Provider.of<GlobalProvider>(context).relationModel;
    final datosSalida = DatosAccesoCargoService();
    final codigoServicio = gProvider.codigoServicio.toString();

    return FutureBuilder(
      future: datosSalida.getDatosAccesosCargoMovimiento(
          (movimiento.fechaSalida == null) ? 2 : 1,
          int.parse(gProvider.codigoServicio.toString()),
          movimiento.placa),
      builder: (context, AsyncSnapshot<List<DatoAccesoMCargoModel>?> snapshot) {
        final datosSalida = snapshot.data;

        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    //HEADER
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff213A89),
                              Color(0xff284393),
                              Color(0xff5267AE),
                            ]),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * .45,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                  future: getImage(movimiento.imagen),
                                  builder: (context,
                                      AsyncSnapshot<Widget> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                          width: size.width * 0.45,
                                          height: size.height * 0.2,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            child: const Image(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/gifs/loader-gris.gif'),
                                            ),
                                          ));
                                    }

                                    return Container(
                                      width: size.width * 0.45,
                                      height: size.height * 0.2,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        child: snapshot.data,
                                      ),
                                    );
                                  }),
                              const SizedBox(height: 10),
                              Text(
                                movimiento.nombres != ''
                                    ? movimiento.nombres!
                                        .split(' ')
                                        .map((nombre) {
                                        if (nombre == '') return null;
                                        return nombre[0] +
                                            nombre.substring(1).toLowerCase();
                                      }).join(' ')
                                    : '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              Text(
                                movimiento.placa != ''
                                    ? movimiento.placa!.split(' ').map((placa) {
                                        if (placa == '') return null;
                                        return placa[0] +
                                            placa.substring(1).toUpperCase();
                                      }).join(' ')
                                    : '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              Text(
                                movimiento.dni != '' ? movimiento.dni! : '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                movimiento.empresa != ''
                                    ? movimiento.empresa!
                                      //   .split(' ')
                                      //   .map((empresa) {
                                      //   if (empresa == '') return null;
                                      //   return empresa[0] +
                                      //       empresa.substring(1).toLowerCase();
                                      // }).join(' ')
                                    : '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //BODY ES DINAMICO
                    SelectedWidgetBody(
                      movimiento: movimiento,
                      datosSalida: datosSalida,
                      codigoServicio: codigoServicio,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            Positioned(
                top: size.height*0.42,
                left: ( datosSalida != null && datosSalida.isNotEmpty ) ? size.width* 0.15 : size.width* 0.35,
                child: Row(
                  children: [
                    const CustomButton(textButton: 'Movimiento'),
                    if( datosSalida != null && datosSalida.isNotEmpty)
                      SizedBox(width: size.width*.1),
                    if( datosSalida != null && datosSalida.isNotEmpty)
                      const CustomButton(textButton: 'Acceso'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SelectedWidgetBody extends StatelessWidget {
  final MovimientoCargoModel movimiento;
  final List<DatoAccesoMCargoModel>? datosSalida;
  final String codigoServicio;

  const SelectedWidgetBody({
    Key? key,
    required this.movimiento,
    required this.datosSalida,
    required this.codigoServicio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailmovProvider =
        Provider.of<DetalleMovimientoCargoProvider>(context);
    final currentIndex = detailmovProvider.indexCurrent;

    switch (currentIndex) {
      case 1:
        return MovimientoDataCargoBody(
          movimiento: movimiento,
          codigoServicio: codigoServicio,
        );

      case 2:
        return MovimientoDatoAccesoCargoBody(
            movimiento: movimiento, datosSalida: datosSalida);

      default:
        return MovimientoDataCargoBody(
          movimiento: movimiento,
          codigoServicio: codigoServicio,
        );
    }
  }
}
