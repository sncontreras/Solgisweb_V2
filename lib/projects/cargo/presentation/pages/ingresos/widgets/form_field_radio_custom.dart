import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/data/models/carga_item_model.dart';

class FieldCargaRadioCustom extends StatelessWidget {

  const FieldCargaRadioCustom({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [
        const Text("Carga"),

        Expanded(
          child: Row(
            children: CargaModel.cargaItems.map((item) => ItemRadio(item: item)).toList()
          )
        )

      ],

    );

  }
}

class ItemRadio extends StatelessWidget {
  
  final CargaModel item;
  const ItemRadio({
    Key? key, 
    required this.item
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 1, 
          groupValue: 2, 
          onChanged: (p){}
        ),
        Text(item.carga)
      ],
    );

  }
}