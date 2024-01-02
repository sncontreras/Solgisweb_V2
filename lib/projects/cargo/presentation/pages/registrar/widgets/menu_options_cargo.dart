import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solgis/projects/cargo/presentation/widgets/widgets.dart';

class MenuOptions extends StatelessWidget {
  
  const MenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;

    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        //SCANNER
        // ButtonMenuCargo(
        //   icon: FontAwesomeIcons.barcode,
        //   text: 'ESCANEAR', 
        //   onpressed:()async{
        //     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //       "#ff6666", 
        //       'Cancelar', 
        //       false, 
        //       ScanMode.BARCODE
        //     );
        //     // getResultScanner(context,barcodeScanRes);
        //   },
        // ),

        // SizedBox(width: size.width*0.1),

        //INICIO
        ButtonMenuCargo(
          icon: FontAwesomeIcons.house,
          text: 'INICIO', 
          onpressed:()=> Navigator.pushReplacementNamed(context, '/'),
        ),  
        //const SizedBox(width: 50.0),
        //FOTO
      /* ButtonMenuCargo(
          icon: FontAwesomeIcons.camera,
          text: 'FOTO', 
          onpressed:()=> Navigator.pushReplacementNamed(context, 'ruta_de_movimiento_foto_placa'),
        ),*/
        //SCAN
        


      ],

    );

  }
}