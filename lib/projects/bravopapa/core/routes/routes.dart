import 'package:flutter/material.dart';
import 'package:solgis/core/presentation/pages/home/home_page.dart';
import 'package:solgis/projects/bravopapa/presentation/pages/home_page_bravopapa.dart';
import 'package:solgis/projects/people/presentation/pages/pages.dart';

class BravoPapaRoutes {
  static Map<String, WidgetBuilder> routes = {
    //RAIZ DEL BRAVOPAPA
    "/": (context) => const HomePageBravoPapa(),
    'home': (BuildContext context) => const HomePage(),

    //RUTAS PARA LA APP PEOPLE
    'habilitar_personal': (BuildContext context) =>
        const HabilitarPersonalPage(),
  };
}
