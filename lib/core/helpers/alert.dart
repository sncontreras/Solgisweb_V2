import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CustomAlert{

  static showAlertYesNo( BuildContext context, String title, String content, String namePage){
    NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      // title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(content),
      ),
      actions: <Widget>[
        TextButton(child: const Text("Si"), onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, namePage);
        }),
        TextButton(child: const Text("No"), onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }



}