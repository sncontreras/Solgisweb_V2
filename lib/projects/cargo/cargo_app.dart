import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/core/routes/route.dart';
import 'package:solgis/projects/cargo/presentation/providers/configuration_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/driver_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/ingreso_autorizado_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/registrar_form_cargo.dart';
import 'package:solgis/projects/cargo/presentation/providers/salida_autorizada_provider.dart';
import 'package:solgis/projects/cargo/presentation/providers/vehicle_provider.dart';

class CargoApp extends StatelessWidget{

  const CargoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers:[
        ChangeNotifierProvider( create: (_) => RegisterProvider() ),
        ChangeNotifierProvider( create: (_) => ConfigProvider() ),
        ChangeNotifierProvider( create: (_) => DriverProvider() ),
        ChangeNotifierProvider( create: (_) => VehicleProvider() ),
        ChangeNotifierProvider( create: (_) => IngresoAutorizadoProvider()),
        ChangeNotifierProvider( create: (_) => SalidaAutorizadaProvider()),
      ],
      child: const CargoAppState(),
    );

  }

}

class CargoAppState extends StatefulWidget {
  const CargoAppState({Key? key}) : super(key: key);  
  @override
  State<CargoAppState> createState() => _CargoAppStateState();
}

class _CargoAppStateState extends State<CargoAppState> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      ( _ ){
        Future.delayed(Duration.zero).then(
          (_){
            final gProvider = Provider.of<GlobalProvider>(context, listen: false);
            final confProvider = Provider.of<ConfigProvider>(context, listen: false);
            confProvider.init( gProvider.relationmodel.codigoCliente!, gProvider.relationModel.codigoServicio.toString(), context );
          }
        );
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Cargo',
      debugShowCheckedModeBanner: false,
      routes: CargoRoutes.routes,
      initialRoute: "/",
      theme: ThemeData( 
        visualDensity: VisualDensity.adaptivePlatformDensity, 
        textTheme: GoogleFonts.aBeeZeeTextTheme()
      ),
    );
  }

}
