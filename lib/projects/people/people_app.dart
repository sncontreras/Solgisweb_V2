import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/people/data/services/movimiento_service.dart';
import 'package:solgis/projects/people/domain/providers/salida_provider.dart';
import 'package:solgis/projects/people/routes/routes.dart';

import 'domain/providers/providers.dart';

class PeopleApp extends StatelessWidget{
  const PeopleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Providers del PEOPLE
        ChangeNotifierProvider( create: (_) => ConsultaFormProvider() ),
        ChangeNotifierProvider( create: (_) => RadioProvider() ),
        ChangeNotifierProvider( create: (_) => NumPadProvider() ),
        ChangeNotifierProvider( create: (_) => RegistrarFormProvider() ),
        ChangeNotifierProvider( create: (_) => MovimientosProvider() ),
        ChangeNotifierProvider( create: (_) => MovimientosPageProvider() ),
        ChangeNotifierProvider( create: (_) => RadioListProvider() ),
        ChangeNotifierProvider(create: ((_) => IngresoAutorizadoProvider())),
        ChangeNotifierProvider(create: ((_) => SalidaProvider())),
      ],
      child: const PeopleAppState(),
    );
  }

}

class PeopleAppState extends StatelessWidget {
  const PeopleAppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'People',
      debugShowCheckedModeBanner: false,
      routes: PeopleRoutes.routes,
      initialRoute: "/",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.aBeeZeeTextTheme()
      ),
    );
  }
} 