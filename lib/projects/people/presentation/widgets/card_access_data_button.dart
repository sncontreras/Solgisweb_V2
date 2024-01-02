import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:solgis/projects/people/domain/models/datos_acceso_movimiento_model.dart';
import 'package:solgis/projects/people/presentation/widgets/widgets.dart';

class CardAccessDataButton extends StatelessWidget {
  final List<DatoAccesoMModel> data;

  const CardAccessDataButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => showBarModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            expand: false,
            builder: ( context ) => ModalDataAccess(data: data),
          ),
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 98,
          width: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon((data.first.codTipoDatoAcceso == 1) ? Icons.description_outlined : Icons.laptop, size: 24, color: Colors.blueAccent),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "${data.length}",
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 105,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                  )
                ),
                child: Text( (data.first.codTipoDatoAcceso == 1) ? "Guias" : "Materiales" ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
