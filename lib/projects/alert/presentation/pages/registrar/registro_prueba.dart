import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:solgis/projects/alert/presentation/providers/configuration_alert_provider.dart';
import 'package:solgis/projects/alert/presentation/providers/timer_alert_provider.dart';


class RegistrarPageAlert extends StatefulWidget {
  const RegistrarPageAlert({super.key});

  @override
  State<RegistrarPageAlert> createState() => _RegistrarPageAlertState();
}

class _RegistrarPageAlertState extends State<RegistrarPageAlert> {
  late String formattedDateTime = "";
  late Color textColor;
  late double defaultValue;
  late double value;
  late int focusedMins;
  late bool isButtonEnabled;
  late DateTime now;
  // ignore: unused_field
  bool hasElapsed60Seconds = false;
  late Timer _timer;
  // late TimeProvider timeProvider;
  late bool isEnabled;
  // ignore: unused_field
  late Timer _timerButton;
  late int lapsosMinuts;
  late int minutosFaltantes;
  late double segundosFaltantes;
  late double enableButtonValue;
  late bool canMark; // Variable para controlar si se puede marcar
  late bool
      isMarkingEnabled; // Variable para habilitar/deshabilitar el botón de marcación
  DateTime?
      lastMarkedTime; // Tiempo de la última marcación/ Tiempo en que se hizo la última marca
  bool elapsedTimeExceeded(DateTime markedTime) {
    Duration difference = DateTime.now().difference(markedTime);
    return difference.inSeconds >
        60; // Si han pasado más de 60 segundos, se considera excedido
  }

  //BOA
  late int minutosRestantesNuevaMarcacion;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    final configAlert =
        Provider.of<ConfigAlertProvider>(context, listen: false);
    lapsosMinuts = (configAlert.configuration != null)
        ? configAlert.configuration![1].value!
        : 1;
    now = DateTime.now();
    minutosFaltantes = getminutosFaltantes(lapsosMinuts);
    //cambiar dependiendo cuanto tiempo ha transcurrido.
    defaultValue = (minutosFaltantes * 60).toDouble() + secondsLeft();
    //value = 180;
    value = (minutosFaltantes * 60).toDouble() + secondsLeft();
    isButtonEnabled = true;
    focusedMins = 0;
    enableButtonValue = 60;
    canMark = true;
    lastMarkedTime = null;
    //isOnTime = true;
    isMarkingEnabled = true;
    isEnabled = true; // Establecer isEnabled como true al inicio
    // timeProvider = Provider.of<TimeProvider>(context, listen: false);
    // timeProvider.addListener(_handleTimeChange);
    // timeProvider.startTimer();
    //final timeProvider = Provider.of<TimeProvider>(context, listen: false);
    //timeProvider.addListener(_handleTimeChange);
    startTimer();
  }

//  void _handleTimeChange() {
//     final timeProvider = Provider.of<TimeProvider>(context, listen: false);
//     if (timeProvider.hasElapsedThreeMinutes) {
//       setState(() {
//         isButtonEnabled = true; // Habilitar el botón después de que pasen los 3 minutos
//       });
//     }
//   }
  void _updateDateTime() {
    DateTime now = DateTime.now();
    int minutesToAdd = 3 -
        (now.minute %
            3); // Minutos restantes para el próximo intervalo de 3 minutos
    DateTime nextUpdateTime = now.add(Duration(minutes: minutesToAdd));

    formattedDateTime =
        DateFormat.Hm().format(nextUpdateTime); // Formato de hora actualizado

    if (nextUpdateTime.minute % 3 == 0) {
      // Cambiar el color cada 3 minutos
      textColor = Colors.blue;
    } else {
      textColor =
          Colors.black; // Resto del tiempo, mantener el color negro por defecto
    }

    Future.delayed(Duration(minutes: minutesToAdd)).then((_) {
      // Actualizar cada 3 minutos
      if (mounted) {
        setState(() {
          _updateDateTime();
        });
      }
    });
  }

  int getminutosFaltantes(int time) {
    final minutesElapsed = DateTime.now().minute;
    switch (time) {
      case 3:
        if (minutesElapsed < 3) return 3 - minutesElapsed;
        if (minutesElapsed >= 3 && minutesElapsed < 6) {
          return 6 - minutesElapsed;
        }
        if (minutesElapsed >= 6 && minutesElapsed < 9) {
          return 9 - minutesElapsed;
        }
        if (minutesElapsed >= 9 && minutesElapsed < 12) {
          return 12 - minutesElapsed;
        }
        if (minutesElapsed >= 12 && minutesElapsed < 15) {
          return 15 - minutesElapsed;
        }
        if (minutesElapsed >= 15 && minutesElapsed < 18) {
          return 18 - minutesElapsed;
        }
        if (minutesElapsed >= 18 && minutesElapsed < 21) {
          return 21 - minutesElapsed;
        }
        if (minutesElapsed >= 21 && minutesElapsed < 24) {
          return 24 - minutesElapsed;
        }
        if (minutesElapsed >= 24 && minutesElapsed < 27) {
          return 27 - minutesElapsed;
        }
        if (minutesElapsed >= 27 && minutesElapsed < 30) {
          return 30 - minutesElapsed;
        }
        return 0;

      case 15:
        if (minutesElapsed <= 15) return 15 - minutesElapsed;
        if (minutesElapsed >= 15 && minutesElapsed <= 30) {
          return 30 - minutesElapsed;
        }
        if (minutesElapsed >= 30 && minutesElapsed <= 45) {
          return 45 - minutesElapsed;
        }
        if (minutesElapsed >= 45 && minutesElapsed <= 60) {
          return 60 - minutesElapsed;
        }
        return 0;

      case 30:
        if (minutesElapsed <= 30) return 30 - minutesElapsed;
        if (minutesElapsed >= 30) return 60 - minutesElapsed;
        return 0;

      case 45:
        if (minutesElapsed <= 45) return 45 - minutesElapsed;
        if (minutesElapsed >= 45) return 45 - (minutesElapsed - 45);
        return 0;

      default:
        return 0;
    }
  }

  int secondsLeft() {
    final secondsElapsed = DateTime.now().second;
    return 60 - secondsElapsed;
  }

  int timeLeft() {
    return getminutosFaltantes(3)*60 + secondsLeft();
  }


  void startTimer() {
    focusedMins = value.toInt();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (value <= 0) {
          setState(() {
            value = lapsosMinuts * 60;
            isButtonEnabled = true;
            canMark = true;
            isMarkingEnabled =
                true; // Habilitar el botón después de reiniciar el tiempo
            // timer.cancel();
          });
        } else {
          setState(() {
            value--;
            if (isMarkingEnabled) {
              enableButtonValue--;
            }
          });
        }

        if (enableButtonValue <= 0) {
          setState(() {
            isMarkingEnabled =
                true; // Deshabilitar el botón durante el ciclo de 3 minutos
            enableButtonValue = 60;
          });
        }
      },
    );
  }

  void _handleMarking() {
    final buttonEnableProvider =
        Provider.of<ButtonEnableProvider>(context, listen: false);

    if (canMark) {
      setState(() {
        lastMarkedTime = DateTime.now();
        canMark = false;
        _timerButton = Timer(const Duration(seconds: 60), () {
          setState(() {
            canMark = true;
            if (lastMarkedTime == null) {
              buttonEnableProvider.disableButton();
            }
          });
        });
        isMarkingEnabled = false; // Deshabilitar el botón después de marcar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String _getFormattedTime({required DateTime markedTime}) {
      final DateTime now = DateTime.now();
      final String day = now.day.toString().padLeft(2, '0');
      final String month = now.month.toString().padLeft(2, '0');
      final String year = now.year.toString();
      final String hour = now.hour.toString().padLeft(2, '0');
      final String minute = now.minute.toString().padLeft(2, '0');

      // late bool exceedTime = elapsedTimeExceeded(markedTime);

      final String formattedTime = '$hour:$minute-$day/$month/$year ';

      return formattedTime;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert v2'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(50),
              child: Center(
                child: Stack(
                  children: [
                    SleekCircularSlider(
                      initialValue: value,
                      min: 0,
                      max: lapsosMinuts * 60,
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          trackWidth: 10,
                          handlerSize: 15,
                          progressBarWidth: 10,
                          shadowWidth: 0,
                        ),
                        customColors: CustomSliderColors(
                          trackColor: Colors.grey.shade200,
                          progressBarColor: const Color(0xff5DAEC7),
                          hideShadow: true,
                          dotColor: const Color.fromRGBO(93, 174, 199, 1).withOpacity(0.5),
                        ),
                        size: size.aspectRatio * 600,
                        angleRange: 360,
                        startAngle: 270,
                      ),
                      innerWidget: (double newValue) {
                        return Center(
                          child: Text(
                            "${(value ~/ 60).toInt().toString().padLeft(2, '0')}:${(value % 60).toInt().toString().padLeft(2, '0')}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 250,
                        height: 250,
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(5.0, 5.0),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0))),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          children: [
                            const Text(
                              "Ultima Marcacion",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              lastMarkedTime != null
                                  ? _getFormattedTime(
                                      markedTime: lastMarkedTime!)
                                  : "",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: hasElapsed60Seconds
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            const Text("Proxima Marcacion",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10.0),
                            Text(
                              formattedDateTime,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ))
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        onPressed: isEnabled
                            ? () {
                                setState(() {
                                        print(timeLeft());

                                  _handleMarking();
                                  isEnabled = false;
                                  hasElapsed60Seconds = elapsedTimeExceeded(lastMarkedTime!);
                                  Future.delayed(Duration(seconds: timeLeft()),
                                      () {
                                    if (mounted) {
                                      setState(() {
                                        isEnabled =
                                            true; // Habilitar el botón después de 60 segundos
                                        hasElapsed60Seconds =
                                            true; // Si han pasado 60 segundos, se establece como true
                                      });
                                    }
                                  });
                                });
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text(
                            "Marcacion",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.aspectRatio * 70),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
