import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> mostrarNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.high, priority: Priority.max);

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
      1, 'EMERGENCIA', 'Alerta enviada', notificationDetails);
}
