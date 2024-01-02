import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/data/models/datos_acceso_movimiento_cargo.dart';
import 'package:solgis/projects/cargo/data/models/movimiento_cargo_model.dart';
import 'package:solgis/projects/cargo/presentation/pages/detalle_movimiento/widgets/card_acceso_cargo.dart';

class MovimientoDatoAccesoCargoBody extends StatelessWidget {

  final MovimientoCargoModel movimiento;
  final List<DatoAccesoMCargoModel>? datosSalida;

  const MovimientoDatoAccesoCargoBody({
    Key? key, 
    required this.movimiento,
    required this.datosSalida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    if(movimiento.fechaSalida == ''){
      return OnlyEntryDataCargoWidget(movimiento: movimiento, datosSalida: datosSalida);
    }else{
      return EntryandExitDataWidget(movimiento: movimiento, datosSalida: datosSalida );
    }
  }

}

class EntryandExitDataWidget extends StatelessWidget{

  final MovimientoCargoModel movimiento;
  final List<DatoAccesoMCargoModel>? datosSalida;

  const EntryandExitDataWidget({
    Key? key, 
    required this.movimiento,
    required this.datosSalida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    if(datosSalida == null) return Container();

    return SizedBox(
      
      width: double.infinity,
      height: size.height * .55,

      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical:size.height * .05),
        itemCount: datosSalida!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ( _ , i ) {

          return CardAccesoCargo(
            tipoDatoAcceso: (datosSalida![i].codTipoDatoAcceso == 1)? 'Guia' : 'Material',
            pathUrl: datosSalida![i].pathImage,
            textDato: datosSalida![i].descripcion ,
          );

        },
      ),

    );

  }

}

class OnlyEntryDataCargoWidget extends StatelessWidget{

  final List<DatoAccesoMCargoModel>? datosSalida;

  final MovimientoCargoModel movimiento;

  const OnlyEntryDataCargoWidget({
    Key? key, 
    required this.movimiento, 
    this.datosSalida
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(datosSalida == null) return Container();


    return SizedBox(
      
      width: double.infinity,
      height: size.height * .55,

      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical:size.height * .05),
        itemCount: datosSalida!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ( _ , i ) {

          return CardAccesoCargo(
            tipoDatoAcceso: (datosSalida![i].codTipoDatoAcceso == 1)? 'Guia' : 'Material',
            pathUrl: datosSalida![i].pathImage,
            textDato: datosSalida![i].descripcion ,
          );

        },
      ),

    );




    // return Padding(
    //   padding: EdgeInsets.only(top: size.height*.09),

    //   child: Row(

    //     mainAxisAlignment: MainAxisAlignment.center,

    //     children: datosSalida!.map((dato) {

    //       return CardAcceso(
    //         tipoDatoAcceso: (dato.codTipoDatoAcceso== 1) ? 'Guia' : 'Material', 
    //         pathUrl: dato.pathImage, 
    //         textDato: dato.descripcion
    //       );

    //     }).toList(),

    //   ),

    // );

  }

}