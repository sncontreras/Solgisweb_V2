import 'dart:async';

import 'package:android_physical_buttons/android_physical_buttons.dart' as pb;
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:solgis/projects/bravopapa/data/models/create_signal_body.dart';
import 'package:solgis/projects/bravopapa/data/services/signal_service.dart';
import 'package:solgis/projects/bravopapa/presentation/widgets/count_send_signal.dart';
import 'package:vibration/vibration.dart';

class VolumeControlWidget extends StatefulWidget {
  const VolumeControlWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VolumeControlWidgetState createState() => _VolumeControlWidgetState();
}

class _VolumeControlWidgetState extends State<VolumeControlWidget> {
  // Agrega aquí las variables y lógica necesarias para controlar los botones de volumen.
  // Puedes utilizar el plugin 'volume_control' u otros para interactuar con los botones de volumen.
  //Position? _position;
  bool isUpdatePending = false;
  int valor = CountSendSignal.instance.getCounterValue();
  bool activo = false;

  //background location
  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String altitude = 'waiting...';
  String accuracy = 'waiting...';
  String bearing = 'waiting...';
  String speed = 'waiting...';
  String time = 'waiting...';
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    //initLocation();
    if (!activo) {
      initLocationBackground();
      activo = false;
    }
    //initBackgroundLocation();
    pb.AndroidPhysicalButtons.listen((key) {
      //updateLocation(); // Key.power, Key.volume
      //debounceUpdateLocation();
      if (CountSendSignal.instance.getCounterValue() == 7) {
        Future.delayed(const Duration(seconds: 1), () {
          if (key.name == "volume") {
            updateLocation();
            Vibration.vibrate();
          }
        });
      }
      logger.d(CountSendSignal.instance.getCounterValue());

      CountSendSignal.instance.increaseCounter();
      if (CountSendSignal.instance.getCounterValue() > 7) {
        CountSendSignal.instance.resetCounter();
      }
      if (CountSendSignal.instance.getCounterValue() == 4) {
        Future.delayed(const Duration(seconds: 3), () {
          _miMetodo();
        });
      }
    });
    // Inicializa el control de los botones de volumen aquí, si es necesario.
  }

  void initLocationBackground() async {
  logger.d('inicializandose el back location');
    await BackgroundLocation.startLocationService(distanceFilter: 20);
    BackgroundLocation.getLocationUpdates((location) {
      setState(() {
        latitude = location.latitude.toString();
        longitude = location.longitude.toString();
        accuracy = location.accuracy.toString();
        altitude = location.altitude.toString();
        bearing = location.bearing.toString();
        speed = location.speed.toString();
        time = DateTime.fromMillisecondsSinceEpoch(location.time!.toInt())
            .toString();
      });
      /*print('''\n
                        Latitude:  $latitude
                        Longitude: $longitude
                        Altitude: $altitude
                        Accuracy: $accuracy
                        Bearing:  $bearing
                        Speed: $speed
                        Time: $time
                      ''');*/
    });
  }

  /*Future<void> initBackgroundLocation() async {
    await BackgroundLocation.startLocationService();
    await BackgroundLocation.getLocationUpdates((location) {
      // Aquí obtienes la ubicación actual en segundo plano.
      logger.d(
          'Ubicación en segundo plano: ${location.latitude}, ${location.longitude}');
    });
  }*/

  void _miMetodo() {
    if (CountSendSignal.instance.getCounterValue() != 0) {
      CountSendSignal.instance.resetCounter();
      logger.d('reiniciando contador');
    }
  }

  void debounceUpdateLocation() {
    if (!isUpdatePending) {
      isUpdatePending = true;
      Timer(const Duration(seconds: 1), () {
        isUpdatePending = false;
        updateLocation();
      });
    }
  }

  void updateLocation() async {
    try {
      // Obtener la posición actual
      /*Position currentLocation = await Geolocator.getCurrentPosition();
      setState(() {
        _position = currentLocation;
      });*/
      SignalService.sendSignal(CreateSignalBody(
          puesto: '',
          latitud: latitude, //_position?.latitude.toString(),
          longitud: longitude, //_position?.latitude.toString(),
          mensaje: 'ayuda',
          numero: '972311303'));
      logger.f('alerta enviada');
    } catch (e) {
      // ignore: avoid_print
      print("Error al actualizar la ubicación: $e");
    }
  }

  /*void initLocation() async {
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
  }*/

  @override
  void dispose() {
    // Libera recursos y detén la interacción con los botones de volumen al cerrar el widget.
    // Puedes hacerlo en el método dispose.
    super.dispose();
    //BackgroundLocation.stopLocationService();
  }

  @override
  Widget build(BuildContext context) {
    // No es necesario retornar ningún widget de interfaz de usuario.
    return Container();
  }
}
