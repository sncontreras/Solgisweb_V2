import 'package:flutter/material.dart';

mensajeImage(BuildContext context, String label) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Informacion"),
          content: Text(label),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Aceptar"),
            )
          ],
        );
      });
}