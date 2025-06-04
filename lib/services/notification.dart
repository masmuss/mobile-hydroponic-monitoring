import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState> navigatorKey;

  // Constructor
  NotificationService(this.navigatorKey) {
    _initializeLocalNotifications();
  }

  // Inisialisasi notifikasi lokal
  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Pastikan ikon ini ada

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: DarwinInitializationSettings(
      //   onDidReceiveLocalNotification: (id, title, body, payload) => {},
      // ),
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Local Notification tapped: ${response.payload}');
        // Anda bisa menambahkan logika navigasi di sini
        // Misalnya, jika payload adalah rute:
        // Navigator.pushNamed(context, response.payload!);
      },
    );
  }

  // Metode untuk menangani klik pada notifikasi lokal
  void _handleNotificationTap(String? payload) {
    if (payload != null) {
      try {
        final Map<String, dynamic> data = json.decode(payload);
        final String? deviceId = data['deviceId'] as String?;

        if (deviceId != null) {
          print('Navigating to device dashboard for Device ID: $deviceId');
          // Gunakan navigatorKey untuk navigasi
          navigatorKey.currentState?.pushNamed(
            '/device-monitoring-detail',
            arguments: "7452706212",
          );
        }
      } catch (e) {
        print('Error decoding notification payload: $e');
      }
    }
  }

  // Meminta izin notifikasi
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Inisialisasi listener FCM dan channel notifikasi
  void init() {
    _createNotificationChannels();
    _setupFirebaseMessagingListeners();
  }

  // Membuat Notification Channels (Android Oreo ke atas)
  void _createNotificationChannels() async {
    const AndroidNotificationChannel alertsChannel = AndroidNotificationChannel(
      'sensor_alerts_channel', // ID channel, harus sama dengan di Firebase Function
      'Peringatan Sensor', // Nama channel yang terlihat oleh pengguna
      description: 'Notifikasi penting mengenai kondisi sensor hidroponik.', // Deskripsi channel
      importance: Importance.max, // Prioritas notifikasi
      playSound: true,
      enableVibration: true,
    );

    const AndroidNotificationChannel infoChannel = AndroidNotificationChannel(
      'info_channel', // ID channel, harus sama dengan di Firebase Function
      'Informasi Sistem', // Nama channel
      description: 'Notifikasi informasi umum dari sistem.',
      importance: Importance.defaultImportance, // Prioritas notifikasi
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(alertsChannel);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(infoChannel);

    print('Notification channels created.');
  }

  // Menyiapkan listener untuk pesan FCM
  void _setupFirebaseMessagingListeners() {
    // Handler untuk pesan foreground (saat aplikasi terbuka)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.title}, ${message.notification?.body}');
        _showLocalNotification(message); // Tampilkan notifikasi lokal
      }
      // Anda bisa menambahkan logika UI di sini (misal: AlertDialog)
    });

    // Handler saat pengguna mengetuk notifikasi yang diterima saat aplikasi di background/terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      // Logika navigasi atau aksi lain berdasarkan message.data
    });

    // Dapatkan pesan jika aplikasi dibuka dari kondisi terminated oleh notifikasi
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state by notification!');
        _handleNotificationTap(message.toString());
      }
    });
  }

  // Menampilkan notifikasi lokal
  Future<void> _showLocalNotification(RemoteMessage message) async {
    String channelId = message.data['status'] == 'Tidak Normal' ? 'sensor_alerts_channel' : 'info_channel';
    String channelName = message.data['status'] == 'Tidak Normal' ? 'Peringatan Sensor' : 'Informasi Sistem';
    String channelDescription = message.data['status'] == 'Tidak Normal' ? 'Notifikasi penting mengenai kondisi sensor hidroponik.' : 'Notifikasi informasi umum dari sistem.';
    Importance importance = message.data['status'] == 'Tidak Normal' ? Importance.max : Importance.defaultImportance;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode, // ID notifikasi unik
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['abnormalDetail'] ?? 'no_payload',
    );
  }

  // Subscribe ke topik notifikasi
  Future<void> subscribeToDeviceAlerts(String deviceId) async {
    final String topic = 'device_alerts_$deviceId';
    await _firebaseMessaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  // Unsubscribe dari topik notifikasi
  Future<void> unsubscribeFromDeviceAlerts(String deviceId) async {
    final String topic = 'device_alerts_$deviceId';
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }

  // Dapatkan token perangkat FCM
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }
}