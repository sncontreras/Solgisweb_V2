import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:solgis/projects/people/styles/style.dart';

class ButtonMenuPeople extends StatelessWidget {

  final IconData icon;
  final String text;
  final Function()? onpressed;

  const ButtonMenuPeople({
    Key? key, 
    required this.icon, 
    required this.text, 
    this.onpressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white,size: size.width*0.06),
          onPressed: onpressed,
        ),
        AutoSizeText(text,  style: textStyleLetter()),
      ],
    );

  }

}