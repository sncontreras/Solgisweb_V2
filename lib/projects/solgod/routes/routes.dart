import 'package:flutter/material.dart';
import 'package:solgis/projects/solgod/presentation/home/home_page_solgod.dart';
import 'package:solgis/projects/solgod/presentation/pages/servicio/marcar_servicio_page.dart';

class SolgodRoutes {
  static Map<String, WidgetBuilder> routes = {
    //RAIZ DEL SOLGOD
    "/": (context) => const HomePageSolgod(),
    //RUTAS PARA LA APP SOLGOD
    'marcar_servicio_solgod': (BuildContext context) => MarcarServicioPage(),
    // 'ingreso_autorizado_people'      : (BuildContext context) => const IngresoAutorizadoPage(),
    // 'salida_autorizada_people'       : (BuildContext context) => const SalidaAutorizadaPage(),
    // 'ingreso_denegado_people'        : (BuildContext context) => const IngresoDenegadoPage(),
    // 'movimientos_page_people'        : (BuildContext context) => const MovimientosPage(),
    // 'crear_personal_page_people'     : (BuildContext context) => const CrearPersonalPage(),
    // 'consulta_home_page_people'      : (BuildContext context) => const ConsultaHomePage(),
    // 'consulta_page_people'           : (BuildContext context) => const ConsultaPage(),
    // 'register_movimiento_gun_people' : (BuildContext context) => const RegisterScanGunPage(),
    // 'detalle_movimiento'             : (BuildContext context) => const DetailMovimientoPage(),
    // 'habilitar_personal'             : (BuildContext context) => const HabilitarPersonalPage(),
  };
}
