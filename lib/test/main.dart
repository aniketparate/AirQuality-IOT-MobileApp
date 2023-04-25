// import 'package:aq_iot/fetch_service.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:hive/hive.dart';
// import 'splash_screen.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await FetchService.start();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Air Quality Index',
//       home: SplashScreen(),
//     );
//   }
// }
