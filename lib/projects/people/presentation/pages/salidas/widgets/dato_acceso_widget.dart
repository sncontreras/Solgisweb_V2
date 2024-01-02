import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:solgis/core/domain/helpers/get_image.dart';
import 'package:solgis/projects/people/domain/models/datos_acceso_movimiento_model.dart';
import 'package:solgis/projects/people/presentation/widgets/widgets.dart';
import 'package:solgis/projects/people/styles/style.dart';

class DatoAccesoWidget extends StatelessWidget {

  final List<DatoAccesoMModel>? datos;
  const DatoAccesoWidget({super.key, this.datos});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: _showDatos(datos!, size, context),
    );
  }

}

  List<Widget> _showDatos(List<DatoAccesoMModel> datos, Size size, BuildContext context) => datos.map((dato) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:size.height * .02 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            (dato.codTipoDatoAcceso == 1) ? 'E. Guia:  ' : 'E. Material:  ',
            style: styleCrearPersonaltextForm()
          ),

          if(dato.pathImage != '')
            SizedBox(width: (dato.codTipoDatoAcceso == 1) ?size.width* 0.03 : null ),

          InputReadOnlyWidget(
            initialValue: dato.descripcion, 
            width: (dato.pathImage == '') 
              ? size.width*0.57 
              : size.width*0.43
          ),

          if(dato.pathImage != '')

            GestureDetector(

              onTap: ()async{

                await NDialog(
                  dialogStyle: DialogStyle(
                    backgroundColor: const Color(0xFF999999), //0xFF9E9E9E
                  ),
                  title: Text('Foto de ${(dato.codTipoDatoAcceso == 1) ? "Guia" : "Material"}',
                    style:  const TextStyle(
                      color: Colors.black
                    ), 
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis
                  ),

                  content: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    width: size.width*0.05,
                    height: size.height*0.35,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FutureBuilder(
                        future: getImage(dato.pathImage),
                        builder: ( _ , AsyncSnapshot<Widget> snapshot) {
                          if(!snapshot.hasData){
                            return const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/gifs/loader-gris.gif'),
                            );
                          }

                          return Container(
                            child: snapshot.data!,
                          );

                        },

                      ),

                    )
                  )

                ).show(context);

              },

              child :const Icon(Icons.camera_alt_outlined),

            ),

        ],
      ),
    );

  }).toList();
