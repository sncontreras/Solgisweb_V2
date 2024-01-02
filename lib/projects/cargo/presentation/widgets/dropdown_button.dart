import 'package:flutter/material.dart';
import 'package:solgis/core/presentation/widgets/dropdown_button.dart';

import 'package:solgis/projects/cargo/core/styles/style.dart';

class DropDownButtonForm extends StatelessWidget {

  final String text;
  final List<DropdownMenuItem<int>>? items;
  final void Function(int?) onchanged;
  final int? value;
  final String? hintText;
  final String Function(int?)? onvalidator;


  const DropDownButtonForm({
    Key? key, 
    required this.text, 
    this.items, 
    required this.onchanged, 
    this.value,
    this.hintText, 
    this.onvalidator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  //CAMPO 
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text( text, style: styleCrearPersonaltextForm()),

        DropdownButtonWidget(
          items: items,
          onchanged: onchanged,
          value: value,
        )
      ],
    );

  }
}