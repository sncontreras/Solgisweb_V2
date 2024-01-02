import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/helpers/pattern_string.dart';
import 'package:solgis/projects/cargo/core/helpers/consultar_placa.dart';
import 'package:solgis/projects/cargo/core/styles/style.dart';
import 'package:solgis/projects/cargo/data/models/movimiento_cargo_model.dart';

class MovimientosTilesCargo extends StatelessWidget {
  final Future<List<MovimientoCargoModel>> movimientos;

  const MovimientosTilesCargo({Key? key, required this.movimientos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movimientos,
      builder: (_, AsyncSnapshot<List<MovimientoCargoModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        }
        if (snapshot.data!.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.hourglass_empty_rounded),
              Text('No hay Movimientos', style: TextStyle(color: Colors.black))
            ],
          );
        }
        final movimientos = snapshot.data;
        return ListView.separated(
          separatorBuilder: (_, int i) => Divider(
              color: Colors.grey.shade300.withOpacity(0.5),
              indent: 10,
              endIndent: 10,
              height: 0),
          itemCount: movimientos!.length,
          itemBuilder: (_, i) =>
              _ListTileMovimiento(movimientoCargo: movimientos[i]),
        );
      },
    );
  }
}

class _ListTileMovimiento extends StatelessWidget {
  final MovimientoCargoModel movimientoCargo;
  const _ListTileMovimiento({required this.movimientoCargo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gProvider = Provider.of<GlobalProvider>(context);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'detalle_movimiento_cargo',
          arguments: movimientoCargo),
      child: ListTile(
        minLeadingWidth: 10,
        style: ListTileStyle.list,
        leading: GestureDetector(
          onTap: () async {
            await NDialog(
                dialogStyle: DialogStyle(
                  backgroundColor: const Color(0xFF999999), //0xFF9E9E9E
                ),
                title: Text(
                    'Foto de vehiculo ${movimientoCargo.placa!.toUpperCase()}',
                    style: const TextStyle(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                content: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    width: size.width * 0.05,
                    height: size.height * 0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FutureBuilder(
                          future: getImage(
                              'https://c0.klipartz.com/pngpicture/252/313/gratis-png-vista-frontal-del-carro-acura.png'),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (!snapshot.hasData) {
                              return const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/gifs/loader-gris.gif'),
                              );
                            }
                            return Container(
                              child: snapshot.data!,
                            );
                          }),
                    ))).show(context);
          },
          child: Container(
            width: size.width * .08,
            height: size.height * 0.4,
            alignment: Alignment.center,
            child: const FaIcon(FontAwesomeIcons.circleUser,
                color: Colors.blueAccent, size: 40),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              flex: 7,
              child: Text(movimientoCargo.placa!.toUpperCase(),
                  style: styleLetterpersonalmovimientotitle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
            ),
            Expanded(
                flex: 2,
                child: AutoSizeText(
                  StringHelper.patternString(movimientoCargo.tipoVehiculo ?? ''),
                  style: styleLetterpersonalmovimientotitle(),
                  maxLines: 1,
                  minFontSize: 6,
                  maxFontSize: 12,
                ))
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              flex: 7,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AutoSizeText(
                    StringHelper.patternString(movimientoCargo.nombres ?? ''),
                    minFontSize: 6,
                    maxFontSize: 12,
                    style: styleLetterpersonalmovimientosubtitle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                AutoSizeText(
                    StringHelper.patternString(movimientoCargo.empresa ?? ''),
                    minFontSize: 4,
                    maxFontSize: 12,
                    style: styleLetterpersonalmovimientosubtitle()
                        .copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              ]),
            ),
            if (movimientoCargo.fechaSalida == null)
              Expanded(
                  flex: 2,
                  child: AutoSizeText(
                    movimientoCargo.fechaIngreso!.toString().substring(11, 19),
                    style: TextStyle(
                        color: Colors.green, fontSize: size.width * 0.03),
                    minFontSize: 6,
                    maxFontSize: 12,
                  )),
          ],
        ),
        trailing: (movimientoCargo.fechaSalida == null)
            ? (gProvider.relationModel.codigoPerfil == 3
                ? const Icon(
                    Icons
                        .car_rental, // Reemplaza 'new_icon' con el icono que desees mostrar
                    color: Colors.blue, // Cambia el color si es necesario
                    size: 30,
                  )
                : GestureDetector(
                    onTap: () => consultarPlaca(context, movimientoCargo.placa!,
                        gProvider.relationModel.codigoServicio.toString(), ''),
                    child: const FaIcon(
                      FontAwesomeIcons.car,
                      color: Colors.green,
                      size: 30,
                    ),
                  ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    movimientoCargo.fechaIngreso!.toString().substring(11, 19),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: size.width * 0.03,
                    ),
                    minFontSize: 6,
                    maxFontSize: 12,
                  ),
                  AutoSizeText(
                    movimientoCargo.fechaSalida.toString().substring(11, 19),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: size.width * 0.03,
                    ),
                    minFontSize: 6,
                    maxFontSize: 12,
                  ),
                  AutoSizeText(
                    getTiempoTranscurrido(movimientoCargo.fechaIngreso!,
                            movimientoCargo.fechaSalida!)
                        .toString()
                        .substring(0, 7),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: size.width * 0.03,
                    ),
                    minFontSize: 6,
                    maxFontSize: 12,
                  ),
                ],
              ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}

Duration getTiempoTranscurrido(DateTime fecha1, DateTime fecha2) {
  final Duration resultado = fecha2.difference(fecha1);
  return resultado;
}
