import 'package:android_physical_buttons/android_physical_buttons.dart' as pb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/auth_device_provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/core/domain/providers/home_provider.dart';
import 'package:solgis/core/domain/providers/person_auth_provider.dart';
import 'package:solgis/core/presentation/widgets/initialized_widget.dart';
import 'package:solgis/core/routers/routes.dart';


class Appsol extends StatelessWidget {
  
  const Appsol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //PROVEEDOR DEL LOGIN.
        //PROVEEDOR DEL SOLAPP.
        //PROVEEDOR DE INFORMACION DEL DISPOSITIVO
        ChangeNotifierProvider( create: ( _ ) => AuthDeviceProvider()),
        ChangeNotifierProvider( create: ( _ ) => HomeProvider()),
        ChangeNotifierProvider( create: ( _ ) => GlobalProvider()),
        ChangeNotifierProvider( create: ( _ ) => PersonAuthProvider()),
      ], 
      child: const AppsolState(),
    );
  }
}

class AppsolState extends StatelessWidget {

  const AppsolState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'SOLAPP',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.aBeeZeeTextTheme()
      ),
      home: const InitializedWidget(),
      routes: SolgisRoutes.getAppRoutes(),

    );

  }
}


class LocationTracker extends StatefulWidget {
  const LocationTracker({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _LocationTrackerState createState() => _LocationTrackerState();
  
}


class _LocationTrackerState extends State<LocationTracker> {
  Position? _position;
  Geolocator geolocator = Geolocator();

  @override
  void initState() {
    super.initState();
    
    initLocation();

    pb.AndroidPhysicalButtons.listen((key) {
      // ignore: avoid_print
      print(key.index);
       // Key.power, Key.volume
    });
  }
  void initLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Geolocator.getPositionStream().listen((Position currentLocation) {
          setState(() {
            _position = currentLocation;
          });
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracker'),
      ),
      body: Center(
        child: _position != null
            ? Text('Lat: ${_position?.latitude}, Lon: ${_position?.longitude}')
            : const Text('Location data not available'),
      ),
    );
  }
}
