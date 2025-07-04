// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:grad_project/database/medicine/medicine.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationProvider extends ChangeNotifier {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationProvider() {
//     _initializeNotifications();
//   }

//   Future<void> _initializeNotifications() async {
//     tz.initializeTimeZones();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> scheduleDailyMedicineNotifications(Medicine medicine, parseTimeOfDay) async {
//     await cancelNotifications(medicine.id!.toString());

//     for (int i = 0; i < medicine.doseTimes.length; i++) {
//       final time = parseTimeOfDay(medicine.doseTimes[i]);
//       final notificationId = (medicine.id.hashCode + i).hashCode;

//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         notificationId,
//         'تذكير بالدواء: ${medicine.name}',
//         'متنساش تاخد ${medicine.name} في معاده!',
//         _nextInstanceOfTime(time, medicine.startDate!, medicine.endDate),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'medicine_channel',
//             'Medicine Reminders',
//             channelDescription: 'تذكيرات يومية لتناول الأدوية',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: true,
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   }

//   tz.TZDateTime _ CattimeOfDay(String time) {
//     final parts = time.split(' ');
//     final timeParts = parts[0].split(':');
//     int hour = int.parse(timeParts[0]);
//     final minute = int.parse(timeParts[1]);
//     if (parts[1].toLowerCase() == 'pm' && hour != 12) {
//       hour += 12;
//     } else if (parts[1].toLowerCase() == 'am' && hour == 12) {
//       hour = 0;
//     }
//     return TimeOfDay(hour: hour, minute: minute);
//   }

//   tz.TZDateTime _nextInstanceOfTime(
//       TimeOfDay time, DateTime startDate, DateTime? endDate) {
//     final now = tz.TZDateTime.now(tz.local);
//     var scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );

//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }

//     if (scheduledDate.isBefore(startDate)) {
//       scheduledDate = tz.TZDateTime(
//         tz.local,
//         startDate.year,
//         startDate.month,
//         startDate.day,
//         time.hour,
//         time.minute,
//       );
//     }

//     if (endDate != null && scheduledDate.isAfter(endDate)) {
//       scheduledDate = tz.TZDateTime(
//         tz.local,
//         endDate.year,
//         endDate.month,
//         endDate.day,
//         time.hour,
//         time.minute,
//       );
//     }

//     return scheduledDate;
//   }

//   Future<void> cancelNotifications(String medicineId) async {
//     // Assuming a reasonable number of dose times (e.g., max 5 per day)
//     for (int i = 0; i < 5; i++) {
//       final notificationId = (medicineId.hashCode + i).hashCode;
//       await _flutterLocalNotificationsPlugin.cancel(notificationId);
//     }
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:grad_project/database/medicine/medicine.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationProvider {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationProvider() {
//     _initializeNotifications();
//   }

//   Future<void> _initializeNotifications() async {
//     tz.initializeTimeZones();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     // Request notification permissions for Android 13+
//     if (Platform.isAndroid) {
//       await _flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.requestNotificationsPermission();
//     }
//   }

//   Future<void> scheduleDailyMedicineNotifications(Medicine medicine) async {
//     // Check if medicine.id or startDate is null
//     if (medicine.id == null || medicine.startDate == null) {
//       print('Cannot schedule notifications: medicine ID or startDate is null');
//       return;
//     }

//     await cancelNotifications(medicine.id!.toString());

//     for (int i = 0; i < medicine.doseTimes.length; i++) {
//       final time = _parseTimeOfDay(medicine.doseTimes[i]);
//       final notificationId = (medicine.id.hashCode + i).hashCode;

//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         notificationId,
//         'تذكير بالدواء: ${medicine.name}',
//         'متنساش تاخد ${medicine.name} في معاده!',
//         _nextInstanceOfTime(time, medicine.startDate!, medicine.endDate),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'medicine_channel',
//             'Medicine Reminders',
//             channelDescription: 'تذكيرات يومية لتناول الأدوية',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: true,
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   }

//   TimeOfDay _parseTimeOfDay(String time) {
//     final parts = time.split(' ');
//     final timeParts = parts[0].split(':');
//     int hour = int.parse(timeParts[0]);
//     final minute = int.parse(timeParts[1]);
//     if (parts[1].toLowerCase() == 'pm' && hour != 12) {
//       hour += 12;
//     } else if (parts[1].toLowerCase() == 'am' && hour == 12) {
//       hour = 0;
//     }
//     return TimeOfDay(hour: hour, minute: minute);
//   }

//   tz.TZDateTime _nextInstanceOfTime(
//       TimeOfDay time, DateTime startDate, DateTime? endDate) {
//     final now = tz.TZDateTime.now(tz.local);
//     var scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );

//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }

//     if (scheduledDate.isBefore(startDate)) {
//       scheduledDate = tz.TZDateTime(
//         tz.local,
//         startDate.year,
//         startDate.month,
//         startDate.day,
//         time.hour,
//         time.minute,
//       );
//     }

//     if (endDate != null && scheduledDate.isAfter(endDate)) {
//       scheduledDate = tz.TZDateTime(
//         tz.local,
//         endDate.year,
//         endDate.month,
//         endDate.day,
//         time.hour,
//         time.minute,
//       );
//     }

//     return scheduledDate;
//   }

//   Future<void> cancelNotifications(String medicineId) async {
//     // Assuming a reasonable number of dose times (e.g., max 5 per day)
//     for (int i = 0; i < 5; i++) {
//       final notificationId = (medicineId.hashCode + i).hashCode;
//       await _flutterLocalNotificationsPlugin.cancel(notificationId);
//     }
//   }
// }
