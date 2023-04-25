import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HumidityChartPage extends StatefulWidget {
  final List humidityData;

  HumidityChartPage({required this.humidityData});

  @override
  _HumidityChartPageState createState() => _HumidityChartPageState();
}

class _HumidityChartPageState extends State<HumidityChartPage> {
  List<charts.Series<double, DateTime>> _seriesData = [];

  @override
  void initState() {
    super.initState();
    // _updateSeriesData();
    _seriesData.add(
      charts.Series<double, DateTime>(
        id: 'Humidity',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (value, index) => DateTime.now().subtract(
            Duration(seconds: widget.humidityData.length - index! - 1)),
        measureFn: (value, _) => value,
        data: widget.humidityData.map((value) => value as double).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Humidity Chart'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: 300,
                    child: Expanded(
                      child: charts.TimeSeriesChart(
                        _seriesData,
                        animate: true,
                        dateTimeFactory: const charts.LocalDateTimeFactory(),
                        primaryMeasureAxis: charts.NumericAxisSpec(
                          viewport: charts.NumericExtents(
                              widget.humidityData
                                      .reduce((a, b) => a < b ? a : b) -
                                  5,
                              widget.humidityData
                                      .reduce((a, b) => a > b ? a : b) +
                                  5),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
