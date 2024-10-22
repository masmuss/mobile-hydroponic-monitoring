// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:hydroponic/pages/monitoring_and_device_control.dart';
// import 'package:hydroponic/pages/devices_list.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       routes: {
//         '/device-monitoring-detail': (context) {
//           final args = ModalRoute.of(context)!.settings.arguments as String;
//           return MonitoringAndDeviceControl(deviceId: args);
//         },
//       },
//       home: const DevicesList(),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic/firebase_options.dart';
import 'package:hydroponic/pages/widgets/main_page.dart';
import 'package:hydroponic/pages/widgets/splash_screen_page.dart';
import 'package:hydroponic/providers/button_providers';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ButtonProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/device-monitoring-detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return MainPage(deviceId: args);
        },
      },
      home: const SplashScreenPage(),
    );
  }
}
