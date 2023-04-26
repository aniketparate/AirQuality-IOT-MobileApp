// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("AQ Monitoring"),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             const Text("hello"),
//             Container(
//               padding: const EdgeInsets.all(10),
//               width: double.infinity,
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                     borderData: FlBorderData(show: false),
//                     lineBarsData: [
//                       LineChartBarData(spots: [
//                         const FlSpot(0, 1),
//                         const FlSpot(1, 3),
//                         const FlSpot(2, 10),
//                         const FlSpot(3, 7),
//                         const FlSpot(4, 12),
//                         const FlSpot(5, 13),
//                         const FlSpot(6, 17),
//                         const FlSpot(7, 15),
//                         const FlSpot(8, 20),
//                         const FlSpot(9, 13),
//                         const FlSpot(10, 17),
//                         const FlSpot(11, 15),
//                         const FlSpot(12, 20)
//                       ])
//                     ]),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
