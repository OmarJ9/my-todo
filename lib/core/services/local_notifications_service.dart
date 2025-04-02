import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final settings = InitializationSettings(
      android: const AndroidInitializationSettings(
        "@mipmap/ic_launcher",
      ),
      iOS: const DarwinInitializationSettings(),
    );

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );
  }

  static Future<void> _onTap(NotificationResponse response) async {
    if (response.payload != null) {}
  }

  Future<void> scheduleNotification(
    String title,
    String body,
    DateTime date,
    int reminder,
  ) async {
    // Generate a unique notification ID from title and date
    int notificationId = title.hashCode;

    await cancelNotification(notificationId);
    const androidDetails = AndroidNotificationDetails(
      'id_1',
      'Basic Channel',
      importance: Importance.max,
      priority: Priority.max,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.from(date.subtract(Duration(minutes: reminder)), tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
