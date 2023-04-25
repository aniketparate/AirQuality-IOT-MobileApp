import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CoChartPage extends StatefulWidget {
  final List coData;

  CoChartPage({required this.coData});

  @override
  _CoChartPageState createState() => _CoChartPageState();
}

class _CoChartPageState extends State<CoChartPage> {
  List<charts.Series<double, DateTime>> _seriesData = [];

  @override
  void initState() {
    super.initState();
    _seriesData.add(
      charts.Series<double, DateTime>(
        id: 'CO',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (value, index) => DateTime.now()
            .subtract(Duration(seconds: widget.coData.length - index! - 1)),
        measureFn: (value, _) => value,
        data: widget.coData.map((value) => value as double).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CO Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: charts.TimeSeriesChart(
                _seriesData,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
