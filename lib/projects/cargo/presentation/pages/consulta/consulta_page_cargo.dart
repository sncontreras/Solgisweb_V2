import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:solgis/projects/cargo/domain/consulta_model_cargo.dart';
import 'package:solgis/projects/people/presentation/widgets/widgets.dart';
import 'package:solgis/projects/people/styles/style.dart';

class ConsultaPageCargo extends StatelessWidget {
  const ConsultaPageCargo({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context){
  
    // final consulta = ModalRoute.of(context)!.settings.arguments as ConsultaModel;
    Map argumentos                 = ModalRoute.of(context)!.settings.arguments as Map;
    ConsultaModelCargo consulta         = argumentos['consulta'];
    return Scaffold(

        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=>Navigator.of(context).pop(), 
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text('CONSULTA', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ),

        body: _ConsultaPageBody(consulta: consulta, ),

    );
  }
}

class _ConsultaPageBody extends StatelessWidget {

  final ConsultaModelCargo consulta;

  const _ConsultaPageBody({
    Key? key, 
    required this.consulta, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');

    final size = MediaQuery.of(context).size;

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      child: Column(

        children: [

          //CardImage(urlImage: consulta.img),

          //ContainerEstatus( valor: autorizacion.valor! ),

          SizedBox(height: size.height*0.02),

          //CAMPO DNI
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tipo Vehiculo:', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.tipoVehiculo),
            ]
          ),

          SizedBox(height: size.height*0.02), 

          //CAMPO NOMBRES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Conductor:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.nombres),
            ]
          ),
          SizedBox(height: size.height*0.02), 

          //CAMPO CARGO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DNI:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.dni),
            ]
          ),
          SizedBox(height: size.height*0.02), 

          //CAMPO EMPRESA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EMPRESA:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.empresa),
            ]
          ),
          SizedBox(height: size.height*0.02), 

          //CAMPO AUTORIZANTE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Placa:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.placa ),
            ],
          ),
          SizedBox(height: size.height*0.02), 

          //CAMPO MOTIVO
         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('MOTIVO:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.motivo),
            ],
          ),
          SizedBox(height: size.height*0.02), 

          //CAMPO ACCESO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ACCESSO:  ', style: styleCrearPersonaltextForm().copyWith(fontSize: 13)),
              InputReadOnlyWidget(initialValue: consulta.area),
            ],
          ),*/

          SizedBox(height: size.height*0.02), 

          //MENSAJE
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: size.height* .2 ,
            alignment: Alignment.center,
            //child: Text(autorizacion.mensaje! , style: const TextStyle(color: Colors.red),)
          )

        ],
      ),
    );
  }
}

