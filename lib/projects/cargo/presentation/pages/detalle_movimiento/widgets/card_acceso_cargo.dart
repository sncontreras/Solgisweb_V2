
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CardAccesoCargo extends StatelessWidget {

  final String tipoDatoAcceso;
  final String? pathUrl;
  final String? textDato;

  const CardAccesoCargo({
    Key? key, 
    required this.tipoDatoAcceso, 
    required this.pathUrl, 
    required this.textDato
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {

        showCupertinoModalPopup(
          context: context, builder: (context){
            return Center(
              child: SizedBox(
                height: size.height * .5,
                width:  size.width * .5,
                child: PhotoView(imageProvider: NetworkImage(pathUrl!)),
              ),
            ); 
          }
        );

      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: size.width * .35,
        height: (pathUrl != '') ? size.height*0.35 : size.height*0.2,
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
    
            Expanded(
              flex: 1,
              child: Container(
                width: size.width*0.4,
                height: size.height*0.04,
                decoration: const BoxDecoration(
                  color: Color(0xff213A89),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12))
                ),
                child: Center(child: Text(tipoDatoAcceso, style: const TextStyle(color: Colors.white))),
              ),
            ),

            //FOTO
            if( pathUrl != '' )
              Expanded(flex:7 ,child: Image(image: NetworkImage(pathUrl!),fit: BoxFit.cover)),

            Expanded(
              flex:2 , 
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 5),
                  child: AutoSizeText(textDato!,textAlign: TextAlign.center),
                ),
              )
            ),

          ],

        ),

      ),
    );

  }

}