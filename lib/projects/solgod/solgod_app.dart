import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/projects/people/domain/providers/consulta_form_provider.dart';
import 'package:solgis/projects/solgod/domain/providers/marcar_servicio_provider.dart';
import 'package:solgis/projects/solgod/routes/routes.dart';

class SolgodApp extends StatelessWidget {
  const SolgodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Providers del SOLGOD
        ChangeNotifierProvider(create: (_) => MarcarServicioProvider()),
        // ChangeNotifierProvider( create: (_) => RadioProvider() ),
        // ChangeNotifierProvider( create: (_) => NumPadProvider() ),
        // ChangeNotifierProvider( create: (_) => RegistrarFormProvider() ),
        // ChangeNotifierProvider( create: (_) => MovimientosProvider() ),
        // ChangeNotifierProvider( create: (_) => MovimientosPageProvider() ),
        // ChangeNotifierProvider( create: (_) => RadioListProvider() ),
        // ChangeNotifierProvider(create: ((_) => IngresoAutorizadoProvider())),
        // ChangeNotifierProvider(create: ((_) => SalidaProvider())),
      ],
      child: const SolgodAppState(),
    );
  }
}

class SolgodAppState extends StatelessWidget {
  const SolgodAppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolGOD',
      debugShowCheckedModeBanner: false,
      routes: SolgodRoutes.routes,
      initialRoute: "/",
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme()),
    );
  }
}
