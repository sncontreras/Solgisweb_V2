import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/detalle_movimiento_provider_cargo.dart';

class CustomButton extends StatelessWidget {

  final String textButton; 
  
  const CustomButton({
    Key? key, 
    required this.textButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final detailMovProvider = Provider.of<DetalleMovimientoCargoProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        (textButton == 'Movimiento')? detailMovProvider.indexCurrent = 1 : detailMovProvider.indexCurrent = 2;
      },
      child: Container(
        width: size.width* .3,
        height: size.height * .08,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff284393),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(4,4)
            )
          ]
        ),
        child: Center(child: Text(textButton, style: const TextStyle(color: Color(0xff213A89), fontWeight: FontWeight.bold, fontSize: 16))),
      ),
    );

  }
}