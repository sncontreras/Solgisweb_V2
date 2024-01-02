import 'package:flutter/material.dart';
import 'package:solgis/projects/cargo/presentation/pages/consulta/consulta_home_page_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/consulta/consulta_page_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/detalle_movimiento/detail_movimiento_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/pages.dart';
import 'package:solgis/projects/cargo/presentation/pages/registrar/register_scan_gun_cargo.dart';
import 'package:solgis/projects/cargo/presentation/pages/registrar/widgets/form_foto_cargo.dart';

class CargoRoutes{
  static Map<String, WidgetBuilder> routes = {
    //RUTAS PARA LA APP CARGO
    "/": ( _ ) => const HomePageCargo(),
    'registrar_movimiento_cargo'    : ( _ ) => const RegistrarPageCargo(),
    'movimientos_page_cargo'        : ( _ ) => const MovimientosPageCargo(),
    'ingreso_autorizado_page_cargo' : ( _ ) => const IngresoAutorizadoCargoPage(),
    'ingreso_denegado_page_cargo'   : ( _ ) => const IngresoDenegadoCargoPage(),
    'salida_autorizada_page_cargo'  : ( _ ) => const SalidaAutorizadaCargoPage(),
    'crear_conductor_page_cargo'    : ( _ ) => const CreateDriverCargoPage(),
    'crear_vehiculo_page_cargo'    : ( _ ) => const CreateVehicleCargoPage(),
    'ruta_de_movimiento_foto_placa': ( _ ) => const RegistrarFormFotoCargo(),
    'register_movimiento_gun_cargo' : ( _ ) => const RegisterScanGunCargo(),
    'consulta_home_page_cargo' : ( _ ) => const ConsultaHomePageCargo(),
    'consulta_page_cargo' : ( _ ) => const ConsultaPageCargo(),
    'detalle_movimiento_cargo' : ( _ ) => const DetailMovimientoCargo(),



    
  };
}
