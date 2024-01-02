import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/patrol/core/routes/routes.dart';
import 'package:solgis/projects/patrol/presentation/providers/bien_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/registro_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/subbien_provider.dart';
import 'package:solgis/projects/patrol/presentation/providers/tipo_fotos_provider.dart';
//import 'package:solgis/projects/bravopapa/presentation/widgets/volume_control.dart';
import 'package:solgis/projects/people/domain/providers/salida_provider.dart';

class PatrolApp extends StatelessWidget {
  const PatrolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers del PATROL
        ChangeNotifierProvider(create: ((_) => SalidaProvider())),
        ChangeNotifierProvider(create: ((_) => BienProvider())),
        ChangeNotifierProvider(create: ((_) => SubBienProvider())),
        ChangeNotifierProvider(create: ((_) => TipoFotosProvider())),
        ChangeNotifierProvider(create: ((_) => RegistroProvider())),
      ],
      //child: const PatrolAppState(),
      child: const Stack(
        children: [
          PatrolAppState(), // Mantiene el cuerpo principal
          /*Positioned(
            right: 0, // Ajusta la posición del control de volumen como desees
            bottom: 0,
            child: VolumeControlWidget(), // Agrega el widget de control de volumen
          ),*/
        ],
      ),
    );
  }
}

class PatrolAppState extends StatefulWidget {
  const PatrolAppState({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PatrolAppStateState createState() => _PatrolAppStateState();
}

class _PatrolAppStateState extends State<PatrolAppState> {
  @override
  void initState() {
   /* WidgetsBinding.instance.addPostFrameCallback(
      ( _ ){
        Future.delayed(Duration.zero).then(
          (_){
            final gProvider = Provider.of<GlobalProvider>(context, listen: false);
            final bienProvider = Provider.of<BienProvider>(context, listen: false);
            bienProvider.initBienes( /*gProvider.relationmodel.codigoCliente!*/'2' );
          }
        );
      }
    );*/
    super.initState();
    // Puedes realizar inicializaciones o configuraciones iniciales aquí
    // Por ejemplo, cargar datos, configurar controladores, etc.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patrol V2',
      debugShowCheckedModeBanner: false,
      routes: PatrolRoutes.routes,
      initialRoute: "/",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
    );
  }
}
