import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic/views/devices/device_monitoring_detail.dart';
import 'package:hydroponic/views/devices/devices_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/device-monitoring-detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return DeviceMonitoringDetail(deviceId: args);
        },
      },
      home: const DevicesList(),
    );
  }
}
