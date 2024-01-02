// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget{

  final String hinttext;
  final TextInputType keyboardType;
  final int? maxlength;
  Function(String)? onchanged;
  final String labelText;
  TextEditingController? textinputController;
  Function()? oneditingcomplete;
  final TextCapitalization? textcap;
  
  CustomInputField({super.key, 
    required this.hinttext, 
    required this.keyboardType, 
    this.maxlength, 
    this.onchanged, 
    required this.labelText,
    this.textinputController,
    this.oneditingcomplete, 
    this.textcap,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: ( widget.textcap == null) ? TextCapitalization.none  :widget.textcap! ,
      controller: widget.textinputController,
      maxLength: widget.maxlength,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      onEditingComplete: widget.oneditingcomplete,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        labelText: widget.labelText,
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0
          )
        )
      ),
      onChanged: widget.onchanged,
    );
  }
}