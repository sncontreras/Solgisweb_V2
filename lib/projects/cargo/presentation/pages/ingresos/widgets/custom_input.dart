import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hinttext;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final int maxlength;
  final double width;
  final double height;
  final String? dni;

  const CustomInput({super.key, 
    required this.hinttext,
    required this.textController,
    required this.keyboardType,
    required this.maxlength,
    required this.width,
    required this.height,
    this.dni
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 5, bottom: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        maxLength: maxlength,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(6),
          hintText: dni,
        ),
      ),
    );
  }
}
