import 'package:flutter/material.dart';
import 'package:solgis/projects/alert/presentation/pages/pages.dart';

class AlertRoutes {
  static Map<String, WidgetBuilder> routes = {
    //RUTAS PARA LA APP ALERT
    "/": (_) => const HomePageAlert(),
    'registrar_marcacion': (_) => const RegistrarPageAlert(),
    'listar_marcaciones': (_) => const MarcacionesPageAlert(),
  };
}
