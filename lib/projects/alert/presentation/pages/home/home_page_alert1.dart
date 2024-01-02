import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:solgis/projects/alert/domain/entities/history.dart';

class HomePageAlert1 extends StatefulWidget {
  const HomePageAlert1({Key? key}) : super(key: key);

  @override
  State<HomePageAlert1> createState() => _HomePageAlert1State();
}

class _HomePageAlert1State extends State<HomePageAlert1> {
  double defaultValue = 10;
  double value = 10.0;
  bool isStarted = false;
  int focusedMins = 0;
  List<History> listHistory = [];
  late Timer _timer;
  // HistoryController historyController = HistoryController();

  void startTimer() {
    focusedMins = value.toInt();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (value <= 1) {
          setState(() {
            timer.cancel();
            value = defaultValue;
            isStarted = false;
            listHistory.add(
                History(dateTime: DateTime.now(), focusedSecs: focusedMins));
            // listHistory = historyController.read("history");
            // historyController.save("history", listHistory);
          });
        } else {
          setState(() {
            value--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert v2'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade900],
              begin: const FractionalOffset(0.5, 1)),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(50),
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    children: [
                      SleekCircularSlider(
                        initialValue: value,
                        min: 0,
                        max: 10,
                        appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            trackWidth: 15,
                            handlerSize: 20,
                            progressBarWidth: 15,
                            shadowWidth: 0,
                          ),
                          customColors: CustomSliderColors(
                            trackColor: Colors.lightGreen,
                            progressBarColor: Colors.green,
                            hideShadow: true,
                            dotColor: Colors.green,
                          ),
                          size: 250,
                          angleRange: 360,
                          startAngle: 270,
                        ),
                        onChange: (newValue) {
                          setState(() {
                            value = newValue;
                          });
                        },
                        innerWidget: (double newValue) {
                          return Center(
                            child: Text(
                              "${(value ~/ 60).toInt().toString().padLeft(2, '0')}:${(value % 60).toInt().toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 46,
                              ),
                            ),
                          );
                        },
                      ),
                      if (isStarted)
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
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0))),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    const Expanded(
                        child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "Ultima Marcacion",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "18:00\n a destiempo\n 12-06-2023\n :(",
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text("Proxima Marcacion",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            Text(
                              "18:00 \n 12-06-2023 ",
                              style: TextStyle(
                                fontSize: 20.0,
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
                        onPressed: () {
                          setState(() {
                            if (!isStarted) {
                              isStarted = true;
                              startTimer();
                            } else {
                              _timer.cancel();
                              value = defaultValue;
                              isStarted = false;
                            }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Marcacion",
                            style:
                                TextStyle(color: Colors.white, fontSize: 22.0),
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
