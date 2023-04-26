import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:connectivity/connectivity.dart';

class FetchService {
  static const _fetchInterval = Duration(seconds: 30);

  static Timer? _timer;

  static Future<void> start() async {
    // initialize Hive
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Start background service
    _timer = Timer.periodic(_fetchInterval, (timer) async {
      // Fetch resource from server and store in Hive
      final response =
          await http.get(Uri.parse('http://192.168.4.1:8080/data'));

      print('hello');
      if (response.statusCode == 200) {
        print("hello response");
        final data = response.body;
        final box = await Hive.openBox('data_box');
        await box.put('data', data);
      }

      // Check Wi-Fi connection
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi) {
        print("hello connectivity");
      } else {
        // Wi-Fi is not connected, stop fetching resource
        stop();
      }
    });
  }

  static void stop() {
    _timer?.cancel();
  }
}
