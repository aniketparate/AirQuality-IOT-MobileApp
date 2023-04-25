import 'dart:async';
import 'dart:convert';
import 'package:aq_iot/co_chart.dart';
import 'package:aq_iot/temp_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List _co = [];
  final List _temp = [];
  final List _humidity = [];
  final List _heatIndex = [];

  static const _fetchInterval = Duration(seconds: 30);
  static Timer? _timer;

  Future<void> start() async {
    // Start background service
    _timer = Timer.periodic(_fetchInterval, (timer) async {
      // Fetch resource from server and store in list
      final response =
          await http.get(Uri.parse('http://192.168.4.1:8080/data'));

      if (response.statusCode == 200) {
        final data = response.body;
        final decodeData = jsonDecode(data);
        print(decodeData);
        final weatherData = WeatherData.fromJson(decodeData);

        setState(() {
          _co.add(weatherData.co);
          _temp.add(weatherData.temp);
          _humidity.add(weatherData.humidity);
          _heatIndex.add(weatherData.heatIndex);
        });
        print(_co);
        print(_temp);
        print(_humidity);
        print(_heatIndex);
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

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('CO Chart'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoChartPage(coData: _co),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Temperature Chart'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TempChartPage(tempData: _temp),
                      ));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text('Air Quality Monitoring'),
          actions: [
            IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                prefs.remove('password');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              icon: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.logout, color: Colors.black),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CO',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        if (_co.isNotEmpty)
                          Text(
                            '${_co.last.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24.0),
                          ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temperature',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        if (_temp.isNotEmpty)
                          Text(
                            '${_temp.last.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24.0),
                          ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Humidity',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        if (_humidity.isNotEmpty)
                          Text(
                            '${_humidity.last.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24.0),
                          ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Heat Index',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (_heatIndex.isNotEmpty)
                          Text(
                            '${_heatIndex.last.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24.0),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
