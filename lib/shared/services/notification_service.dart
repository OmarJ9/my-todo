import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/colors.dart';

import '../utilities.dart';

class NotificationsHandler {
  static void requestpermission(context) {
    print('jjjjjjjjjjjjjjjjjjjjjjj');
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  static Future<void> createNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.time_watch} It Is Time For Your Task!!!',
        body: 'Check Your Tasks Now !!',
        notificationLayout: NotificationLayout.Default,
        backgroundColor: Colors.amber,
        color: Appcolors.purple,
      ),
    );
  }

  static Future<void> createScheduledNotification({
    required int date,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
          backgroundColor: Colors.amber,
          color: Appcolors.purple,
        ),
        schedule: NotificationCalendar(
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          day: date,
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
        ));
  }
}
