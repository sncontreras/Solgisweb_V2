import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/bravopapa/core/routes/routes.dart';
//import 'package:solgis/projects/bravopapa/presentation/widgets/volume_control.dart';
import 'package:solgis/projects/people/domain/providers/salida_provider.dart';

class BravoPapaApp extends StatelessWidget {
  const BravoPapaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers del BRAVOPAPA
        ChangeNotifierProvider(create: ((_) => SalidaProvider())),
      ],
      //child: const BravoPapaAppState(),
      child: const Stack(
        children: [
          BravoPapaAppState(), // Mantiene el cuerpo principal
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

class BravoPapaAppState extends StatefulWidget {
  const BravoPapaAppState({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BravoPapaAppStateState createState() => _BravoPapaAppStateState();
}

class _BravoPapaAppStateState extends State<BravoPapaAppState> {
  @override
  void initState() {
    super.initState();
    // Puedes realizar inicializaciones o configuraciones iniciales aquí
    // Por ejemplo, cargar datos, configurar controladores, etc.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bravo Papa',
      debugShowCheckedModeBanner: false,
      routes: BravoPapaRoutes.routes,
      initialRoute: "/",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
    );
  }
}
