import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/show_snackbar_awesome.dart';
import 'package:solgis/core/domain/models/project_model_qa.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/people/domain/helpers/show_dialog_combo.dart';

class CardApp extends StatelessWidget {

  final ProjectModel project;

  const CardApp({
    Key? key, 
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size      = MediaQuery.of(context).size;
    final gProvider = Provider.of<GlobalProvider>(context);
    final relacion  = gProvider.relationModel;

    return GestureDetector(

      onTap: () async {
        if( relacion.codigoPerfil == 1 || relacion.codigoPerfil == 2 ){
          Navigator.pushNamed(context, project.route);
        }else{
          if( relacion.codigoCliente == '' ) return showSnackBarAwesome(context, 'Informacion', 'Por favor seleccione un cliente', ContentType.failure);
          showSheet(context, project.route);
        }
      },

      child: Tooltip(
        message: project.description,
        verticalOffset: 115,
        height: 30,
        child: Container(
          decoration: getDecoration(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset( project.pathImage, height:size.height * .20),
              Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: size.width*0.43,
                  height: size.height*0.05,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Text(project.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:size.width*0.06 ) ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}

BoxDecoration getDecoration(){
  return BoxDecoration(
    borderRadius:BorderRadius.circular(20), 
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Colors.black,
        blurRadius: 7,
        offset: Offset(0, 0)
      )
    ]
  );
}