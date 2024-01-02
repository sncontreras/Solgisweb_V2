import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solgis/core/global/environment.dart';
import 'package:solgis/projects/alert/data/models/configuration_model.dart';
import 'package:solgis/projects/alert/domain/entities/configuration.dart';

class ConfigAlertProvider extends ChangeNotifier {
  List<Configuration>? configuration;

  Future init(int codePolitica, BuildContext context) async {
    const String uncodePath = 'api/configuration/alert/';
    final url = Uri.http(Environment.apiCargoUrl, uncodePath, {
      "codePolitica": "$codePolitica",
    });

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; chartset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      if (response.body == "[]") {
      // ignore: use_build_context_synchronously
        return showDialog(
          context: context, 
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Informacion"),
            content: const Text("No hay Configuracion para el alert con este dispositivo"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Aceptar")
              )
            ],
          ),
        );
      }
      final config = configurationModelFromJson(response.body);
      configuration = config;
      notifyListeners();
      return true;
    } else {
      // ignore: use_build_context_synchronously
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Informacion"),
          content: const Text("Hubo un problema al cargar la configuracion"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Aceptar"))
          ],
        ),
      );
    }
  }


}
