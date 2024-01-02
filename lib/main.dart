import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_identifier/flutter_device_identifier.dart';
import 'package:solgis/core/app/app.dart';
import 'package:solgis/core/device/preferences.dart';
import 'package:solgis/projects/bravopapa/data/services/notifications_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Preferences.init();
  runApp(const Appsol());
  await FlutterDeviceIdentifier.requestPermission();
  SystemChrome.setEnabledSystemUIMode( SystemUiMode.manual, overlays: [] );

}
