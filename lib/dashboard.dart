import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "package:hive/hive.dart";
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchService {
  static const _fetchInterval = Duration(seconds: 30);

  static Timer? _timer;

  static Future<void> start() async {
    // Start background service
    _timer = Timer.periodic(_fetchInterval, (timer) async {
      // Fetch resource from server and store in Hive
      final response =
          await http.get(Uri.parse('http://192.168.4.1:8080/data'));

      if (response.statusCode == 200) {
        final data = response.body;
        // print(data);

        final dataBox = Hive.box('dataBox');

        final decodeData = jsonDecode(data);
        print(decodeData);

        await dataBox.put('lastFetchedData', data);
      }

      // Check Wi-Fi connection
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.wifi) {
        // Wi-Fi is not connected, stop fetching resource
        stop();
      }
    });
  }

  static void stop() {
    _timer?.cancel();
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String _data;
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _checkLogin();
    FetchService.start();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final box = Hive.box('dataBox');
    final data = box.get('lastFetchedData', defaultValue: '');
    setState(() {
      _data = data!;
    });
  }

  @override
  void dispose() {
    FetchService.stop();
    super.dispose();
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email == null || password == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      setState(() {
        _email = email;
        _password = password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Air Quality Monitoring'),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              prefs.remove('password');
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.logout, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome, $_email!'),
            SizedBox(
              height: 16.0,
              child: Text('Hello'),
            ),
            SizedBox(
              height: 16.0,
              child: Text(_data),
            ),
          ],
        ),
      ),
    );
  }
}
