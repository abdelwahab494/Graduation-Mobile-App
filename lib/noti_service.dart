import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grad_project/database/medicine/medicine.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    // init timezone handling
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    print('Starting notification initialization...');

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/launcher_icon");

    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await notificationPlugin.initialize(initSettings);
    print('Notification plugin initialized');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_channel_id',
      'Daily Notifications',
      description: 'Daily Notification Channel',
      importance: Importance.max,
    );

    await notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    print('Notification channel created');

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'medicine_channel',
        'Medicine Reminder',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        color: Color.fromARGB(255, 134, 166, 221),
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    print('Attempting to show notification: $title, $body');
    await notificationPlugin.show(id, title, body, notificationDetails());
    print('Notification sent');
  }

  // scheduale notification
  // Future<void> scheduleNotification({
  //   int id = 1,
  //   required String title,
  //   required String body,
  //   required int hour,
  //   required int minute,
  // }) async {
  //   // get current date/time in device's local timezone
  //   final now = tz.TZDateTime.now(tz.local);

  //   // create a date/time for today at the specified hour/min
  //   var scheduledDate = tz.TZDateTime(
  //     tz.local,
  //     now.year,
  //     now.month,
  //     now.day,
  //     hour,
  //     minute,
  //   );

  //   // schedule the notification
  //   await notificationPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     scheduledDate,
  //     notificationDetails(),

  //     androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

  //     // make notification repear daily at same time
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );
  //   print("Notification Scheduled");
  // }

  // cancel all notifications
  Future<void> cancelAllNotifications() async {
    await notificationPlugin.cancelAll();
  }

  //////////////////////////////////////////////////////////////////////////////
  // medicine notification
  Future<void> scheduleNotification(Medicine medicine) async {
    for (var time in medicine.doseTimes) {
      int hour;
      int minute;
      bool isPM = false;

      try {
        final timeParts = time.split(':');
        final minuteParts = timeParts[1].split(' ');
        hour = int.parse(timeParts[0]);
        minute = int.parse(minuteParts[0]);
        // Check if time is PM
        isPM = minuteParts[1].toUpperCase().contains('PM');
      } catch (e) {
        try {
          final format = DateFormat('hh:mm a');
          final dateTime = format.parse(time);
          hour = dateTime.hour;
          minute = dateTime.minute;
          isPM = time.toUpperCase().contains('PM');
        } catch (e) {
          print('Error parsing time: $time');
          continue;
        }
      }

      // Convert to 24-hour format if PM
      if (isPM && hour != 12) {
        hour += 12;
      } else if (!isPM && hour == 12) {
        hour = 0; // Handle 12 AM case
      }

      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // schedule the notification
      await notificationPlugin.zonedSchedule(
        (medicine.id.toString() + time).hashCode,
        "Medicine Time: ${medicine.name.toUpperCase()}",
        "Time to take your medicine it's $time",
        scheduledDate,
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        // make notification repeat daily at same time
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
    print("Notification Scheduled");
  }

  // delete specific medicine
  Future<void> cancelMedicineNotifications(Medicine medicine) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    for (var time in medicine.doseTimes) {
      final notificationId = (medicine.id.toString() + time).hashCode;
      await flutterLocalNotificationsPlugin.cancel(notificationId);
    }
    print("Notifiction Deleted");
  }
}
