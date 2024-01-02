import 'package:flutter/material.dart';
import 'package:solgis/core/presentation/pages/home/home_page.dart';
import 'package:solgis/projects/patrol/presentation/pages/home_page_patrol.dart';
import 'package:solgis/projects/patrol/presentation/pages/registrar/registrar_page_raiz_patrol.dart';
import 'package:solgis/projects/people/presentation/pages/pages.dart';

class PatrolRoutes {
  static Map<String, WidgetBuilder> routes = {
    //RAIZ DEL BRAVOPAPA
    "/": ( _ ) => const HomePagePatrol(),
    '/registrar': ( _ ) => const RegistrarPageRaizPatrol(),
    'home': (BuildContext context) => const HomePage(),

    //RUTAS PARA LA APP PEOPLE
    'habilitar_personal': (BuildContext context) =>
        const HabilitarPersonalPage(),
  };
}
