import 'package:flutter/material.dart';
import 'package:solgis/core/presentation/pages/home/home_page.dart';
import 'package:solgis/projects/image/presentation/pages/home_page_image.dart';
import 'package:solgis/projects/image/presentation/pages/registrar_image_page.dart';
import 'package:solgis/projects/people/presentation/pages/pages.dart';

class ImageRoutes {
  static Map<String, WidgetBuilder> routes = {
    //RAIZ DEL BRAVOPAPA
    "/": (_) => const HomePageImage(),
    '/registrar': (_) => const RegistrarImagePage(),
    'home': (BuildContext context) => const HomePage(),

    //RUTAS PARA LA APP PEOPLE
    'habilitar_personal': (BuildContext context) =>
        const HabilitarPersonalPage(),
  };
}
