import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _dataBox = Hive.box('data_box');
  late String _data;

  @override
  void initState() {
    super.initState();
    _data = _dataBox.get('data', defaultValue: '');
    _dataBox.watch(key: 'data').listen((event) {
      setState(() {
        _data = event.value ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AIR QUALITY INDEX"),
      ),
      body: Text(_data),
    );
  }
}
