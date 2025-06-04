import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydroponic/firebase_options.dart';
import 'package:hydroponic/pages/widgets/main_page.dart'; // Pastikan ini diimpor
import 'package:hydroponic/pages/widgets/splash_screen_page.dart';
import 'package:hydroponic/providers/button_providers';
import 'package:hydroponic/services/notification.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // Import untuk json.decode di handler background

// GlobalKey untuk navigasi, harus di luar class
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Inisialisasi plugin notifikasi lokal di luar class (tetap top-level)
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Handler untuk pesan di latar belakang (background) atau aplikasi ditutup
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');

  // Inisialisasi ulang flutter_local_notifications di isolate background
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Logic ini akan dipanggil saat notifikasi background diketuk
      // Jika Anda ingin navigasi dari background handler, Anda perlu
      // mekanisme yang lebih kompleks (misal, menyimpan payload ke SharedPreferences
      // dan menanganinya saat app di-resume/dibuka)
      print('Background Notification tapped: ${response.payload}');
    },
  );

  String channelId = message.data['status'] == 'Tidak Normal' ? 'sensor_alerts_channel' : 'info_channel';
  String channelName = message.data['status'] == 'Tidak Normal' ? 'Peringatan Sensor' : 'Informasi Sistem';
  String channelDescription = message.data['status'] == 'Tidak Normal' ? 'Notifikasi penting mengenai kondisi sensor hidroponik.' : 'Notifikasi informasi umum dari sistem.';
  Importance importance = message.data['status'] == 'Tidak Normal' ? Importance.max : Importance.defaultImportance;

  final AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    channelId, channelName, channelDescription: channelDescription,
    importance: importance, priority: Priority.high, showWhen: false, playSound: true,
  );
  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    message.hashCode, message.notification?.title, message.notification?.body,
    platformChannelSpecifics,
    payload: json.encode(message.data), // Payload JSON
  );
}

void main() async {
  await initializeDateFormatting('id');
  Intl.defaultLocale = 'id';

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  // Daftarkan handler untuk pesan di latar belakang
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Inisialisasi NotificationService dengan navigatorKey
  final NotificationService notificationService = NotificationService(navigatorKey);
  await notificationService.requestNotificationPermission();
  notificationService.init();

  // Dapatkan token dan subscribe ke topik di sini jika diperlukan
  // String? fcmToken = await notificationService.getFCMToken();
  // print("FCM Token: $fcmToken");
  notificationService.subscribeToDeviceAlerts("LEBIH"); // Ganti dengan deviceId aktual

  runApp(
    ChangeNotifierProvider(
      create: (context) => ButtonProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Tambahkan navigatorKey di sini
      navigatorKey: navigatorKey,
      routes: {
        // Sesuaikan rute untuk menerima String sebagai argumen
        '/device-monitoring-detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return MainPage(deviceId: args);
        },
      },
      home: const SplashScreenPage(),
    );
  }
}