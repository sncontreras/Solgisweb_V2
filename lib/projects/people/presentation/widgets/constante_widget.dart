import 'package:flutter/material.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/projects/people/domain/models/consulta_persona_model.dart';
import 'package:solgis/projects/people/presentation/widgets/widgets.dart';
import 'package:solgis/projects/people/styles/style.dart';

class ConstantesWidgetSalida extends StatelessWidget {

  final ConsultaModel consulta;

  const ConstantesWidgetSalida({
    Key? key, 
    required this.consulta
  }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(

      padding: EdgeInsets.symmetric(horizontal: size.width*0.0729, vertical: size.height*0.0116),
      width: double.infinity,
      height: size.height * 0.43,

      child: Column(

        children: [

          // FOTO
          FutureBuilder(

            future: getImage(consulta.img),

            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {

              if(!snapshot.hasData){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: size.width*0.33,
                    height: size.width*0.33,
                    child: const Image(
                      image: AssetImage('assets/gifs/loader.gif'),
                    ),
                  ),
                );
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: size.width*0.33,
                  height: size.width*0.33,
                  child: snapshot.data,
                ),
              );

            }

          ),

          SizedBox(height: size.height*0.02),

          //CAMPO DNI
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text( (consulta.tipoDocumento=='DNI')? 'DNI:' : (consulta.tipoDocumento=='PASAPORTE')? 'Pasaporte:': 'Carnet:', style: styleCrearPersonaltextForm()),
              Text("Documento:", style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.docPersona),
            ]
          ),
          SizedBox(height: size.height*0.02), 

          //CAMPO NOMBRE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nombre:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.nombresPersona),
            ]
          ),

          SizedBox(height: size.height*0.02), 

          //CAMPO CARGO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cargo:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.cargo),
            ]
          ),

          SizedBox(height: size.height*0.02), 

          //CAMPO EMPRESA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Empresa:  ', style: styleCrearPersonaltextForm()),
              InputReadOnlyWidget(initialValue: consulta.empresa)
            ]
          ),

        ],
      ),
    );
  }
}