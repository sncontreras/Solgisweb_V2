import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  late int _lapsosMinuts;
  late Timer _timer;
  late double _value;

  TimerProvider() {
    _lapsosMinuts = 3;
    _value = _lapsosMinuts * 60.toDouble();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_value <= 0) {
          _value = _lapsosMinuts * 60.toDouble();
          notifyListeners();
        } else {
          _value--;
          notifyListeners();
        }
      },
    );
  }

  double get timerValue => _value;
}

class ButtonEnableProvider extends ChangeNotifier {
  bool _isButtonEnabled = true;

  bool get isButtonEnabled => _isButtonEnabled;

  void disableButton() {
    _isButtonEnabled = false;
    notifyListeners();
  }

  void enableButton() {
    _isButtonEnabled = true;
    notifyListeners();
  }
}
