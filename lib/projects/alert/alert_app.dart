import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/alert/core/routes/routes.dart';
import 'package:solgis/projects/alert/presentation/providers/configuration_alert_provider.dart';
import 'package:solgis/projects/alert/presentation/providers/timer_alert_provider.dart';

class AlertApp extends StatelessWidget {
  const AlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => ButtonEnableProvider()),
        ChangeNotifierProvider(create: (_) => ConfigAlertProvider()),
      ],
      child: const AlertAppState(),
    );
  }
}

class AlertAppState extends StatefulWidget {
  const AlertAppState({Key? key}) : super(key: key);
  @override
  State<AlertAppState> createState() => _AlertAppStateState();
}

class _AlertAppStateState extends State<AlertAppState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero).then((_) async {
        final gProvider = Provider.of<GlobalProvider>(context, listen: false);
        final confProvider =
            Provider.of<ConfigAlertProvider>(context, listen: false);
        await confProvider.init(
            gProvider.relationModel.codPolitica ?? 0, context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert v2',
      debugShowCheckedModeBanner: false,
      routes: AlertRoutes.routes,
      initialRoute: "/",
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.aBeeZeeTextTheme()),
    );
  }
}
