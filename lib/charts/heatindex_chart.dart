import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HeatIndChartPage extends StatefulWidget {
  final List heatindData;

  HeatIndChartPage({required this.heatindData});

  @override
  _HeatIndChartPageState createState() => _HeatIndChartPageState();
}

class _HeatIndChartPageState extends State<HeatIndChartPage> {
  List<charts.Series<double, DateTime>> _seriesData = [];

  @override
  void initState() {
    super.initState();
    // _updateSeriesData();
    _seriesData.add(
      charts.Series<double, DateTime>(
        id: 'HeatIndex',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (value, index) => DateTime.now().subtract(
            Duration(seconds: widget.heatindData.length - index! - 1)),
        measureFn: (value, _) => value,
        data: widget.heatindData.map((value) => value as double).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<double> measureValues = _seriesData
        .expand((series) => series.data.map((data) => data))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Heat Index Chart'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 10, end: 10, top: 50, bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            height: 300,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: measureValues
                          .asMap()
                          .entries
                          .map((entry) =>
                              FlSpot(entry.key.toDouble(), entry.value))
                          .toList())
                ],
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
        )));
  }
}
