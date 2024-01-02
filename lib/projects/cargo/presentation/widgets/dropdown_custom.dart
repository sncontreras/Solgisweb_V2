import 'package:flutter/material.dart';

import 'package:solgis/projects/cargo/core/styles/style.dart';


class DropDownCustom extends StatelessWidget {

  final String text;
  final Widget child;

  const DropDownCustom({
    super.key, 
    required this.text, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: styleCrearPersonaltextForm()),

        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.024),
          width: size.width*0.57,
          height: size.height*0.04,
          child: child,
        )

      ],
    );

  }
}