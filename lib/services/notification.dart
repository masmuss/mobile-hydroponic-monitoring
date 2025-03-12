import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Inisialisasi notifikasi
  Future<void> init({Function(String?)? onSelectNotification}) async {
    if (_isInitialized) return;

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings =
        const InitializationSettings(android: initSettingsAndroid);

    await notificationPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (onSelectNotification != null) {
          onSelectNotification(response.payload);
        }
      },
    );

    _isInitialized = true;
  }

  // Meminta izin notifikasi
  Future<void> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          notificationPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted =
          await androidImplementation?.requestNotificationsPermission();
      if (granted == false) {
        debugPrint("Izin notifikasi tidak diberikan!");
      }
    }
  }

  // Konfigurasi detail notifikasi
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'abnormal_sensor_channel_id',
        'Abnormal Sensor',
        channelDescription:
            'Menerima notifikasi jika sensor menunjukkan nilai tidak normal.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
    );
  }

  // Menampilkan notifikasi
  Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) {
      await init(); // Pastikan sudah diinisialisasi sebelum menampilkan notifikasi
    }

    await notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }
}
