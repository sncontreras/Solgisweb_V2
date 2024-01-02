import 'package:android_physical_buttons/android_physical_buttons.dart' as pb;
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/bravopapa/data/models/create_signal_body.dart';
import 'package:solgis/projects/bravopapa/data/services/notifications_service.dart';
import 'package:solgis/projects/bravopapa/data/services/signal_service.dart';
import 'package:solgis/projects/bravopapa/presentation/widgets/count_send_signal.dart';
import 'package:vibration/vibration.dart';


class PanicButtonWidget extends StatefulWidget {
  const PanicButtonWidget({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PanicButtonWidgetState createState() => _PanicButtonWidgetState();
}

class _PanicButtonWidgetState extends State<PanicButtonWidget> {
  bool isActivado = false;
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
    //initBackgroundLocation();
    pb.AndroidPhysicalButtons.listen((key) {
      //updateLocation(); // Key.power, Key.volume
      //debounceUpdateLocation();
      if (CountSendSignal.instance.getCounterValue() == 3 && isActivado) {
        Future.delayed(const Duration(seconds: 1), () {
          if (key.name == "volume") {
            updateLocation();
            Vibration.vibrate();
          }
        });
      }
      logger.d(CountSendSignal.instance.getCounterValue());
      if (isActivado) {
        CountSendSignal.instance.increaseCounter();
      }
      if (CountSendSignal.instance.getCounterValue() > 3 && isActivado) {
        CountSendSignal.instance.resetCounter();
      }
      if (CountSendSignal.instance.getCounterValue() < 3 && isActivado) {
        Future.delayed(const Duration(seconds: 3), () {
          reiniciarcontador();
        });
      }
    });
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
    });
  }

  void reiniciarcontador() {
    if (CountSendSignal.instance.getCounterValue() != 0) {
      CountSendSignal.instance.resetCounter();
      logger.d('reiniciando contador');
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
          numero: number));
      logger.f('alerta enviada');
      mostrarNotification();
    } catch (e) {
      // ignore: avoid_print
      print("Error al actualizar la ubicación: $e");
    }
  }

  void cambiarEstado() {
    setState(() {
      isActivado = !isActivado;
    });

    // Puedes ejecutar tu método aquí
    if (isActivado) {
      // Lógica cuando está activado
      initLocationBackground();
    } else {
      // Lógica cuando está desactivado
      BackgroundLocation.stopLocationService();
    }
  }
  String number = '';
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context).relationModel;
    number = globalProvider.numberDevice.toString();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: cambiarEstado,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                isActivado ? const Color.fromARGB(255, 113, 205, 121) : const Color.fromARGB(255, 255, 26, 26),
              ),
            ),
            child: Text(isActivado ? 'Activado' : 'Desactivado'),
          ),
        ],
      ),
    );
  }
}
